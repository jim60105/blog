<# 
.SYNOPSIS
    Dual Site Mode Switcher for Zola Blog (PowerShell Version)

.DESCRIPTION
    Switches between 琳.tw and 聆.tw site configurations.
    Copyright (C) 2025 Jim Chen <Jim@ChenJ.im>, licensed under GPL-3.0-or-later

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

.PARAMETER SiteName
    The site to switch to: 琳.tw, 聆.tw, clean, or status

.EXAMPLE
    .\switch-site.ps1              # Interactive mode - choose site from menu
    .\switch-site.ps1 琳.tw        # Switch to 琳.tw site mode
    .\switch-site.ps1 聆.tw        # Switch to 聆.tw site mode  
    .\switch-site.ps1 clean        # Remove all links and restore original state
    .\switch-site.ps1 status       # Check current site status

.NOTES
    Requires: Windows 10+ with Developer Mode enabled (for symbolic links without admin)
    Or run as Administrator if Developer Mode is not enabled.
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet('琳.tw', '聆.tw', 'clean', 'status', '')]
    [string]$SiteName = ''
)

# Ensure we're running in the script's directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# Set UTF-8 encoding for proper Chinese character support
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

#region P/Invoke Definitions for Hard Link Detection

# Define the struct and kernel32 function for efficient hard link detection
if (-not ([System.Management.Automation.PSTypeName]'BY_HANDLE_FILE_INFORMATION').Type) {
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
public struct BY_HANDLE_FILE_INFORMATION {
    public uint FileAttributes;
    public System.Runtime.InteropServices.ComTypes.FILETIME CreationTime;
    public System.Runtime.InteropServices.ComTypes.FILETIME LastAccessTime;
    public System.Runtime.InteropServices.ComTypes.FILETIME LastWriteTime;
    public uint VolumeSerialNumber;
    public uint FileSizeHigh;
    public uint FileSizeLow;
    public uint NumberOfLinks;
    public uint FileIndexHigh;
    public uint FileIndexLow;
}

public class Kernel32 {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool GetFileInformationByHandle(IntPtr hFile, ref BY_HANDLE_FILE_INFORMATION lpFileInformation);
}
"@
}

#endregion

#region Helper Functions

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] " -ForegroundColor Blue -NoNewline
    Write-Host $Message
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Write-WarningMsg {
    param([string]$Message)
    Write-Host "[WARNING] " -ForegroundColor Yellow -NoNewline
    Write-Host $Message
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "[ERROR] " -ForegroundColor Red -NoNewline
    Write-Host $Message
}

function Show-Usage {
    @"
Usage: .\switch-site.ps1 [site_name|command]

Commands:
  琳.tw     Switch to 琳.tw site mode (技術部落格)
  聆.tw     Switch to 聆.tw site mode (AI 對話)
  clean     Remove all links and restore original state
  status    Check current site status

Interactive mode:
  .\switch-site.ps1    # Run without parameters for interactive site selection

Examples:
  .\switch-site.ps1              # Interactive mode
  .\switch-site.ps1 琳.tw        # Switch to technical blog mode
  .\switch-site.ps1 聆.tw        # Switch to AI talks mode
  .\switch-site.ps1 clean        # Clean up and restore original state
  .\switch-site.ps1 status       # Check current site status
"@
}

function Test-GitRepository {
    try {
        $null = git rev-parse --git-dir 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}

function Test-IsHardLink {
    <#
    .SYNOPSIS
        Check if a file is a hard link (has more than one link)
    .DESCRIPTION
        On Windows, we use the kernel32 GetFileInformationByHandle API to get the
        NumberOfLinks property efficiently, avoiding slow fsutil calls.
    #>
    param([string]$Path)
    
    if (-not (Test-Path $Path -PathType Leaf)) {
        return $false
    }
    
    try {
        # Use .NET FileInfo to check if it's a reparse point or has special attributes
        $fileInfo = [System.IO.FileInfo]::new((Resolve-Path $Path).Path)
        
        # Use P/Invoke to get the number of hard links efficiently
        # This is much faster than fsutil
        $file = [System.IO.File]::Open($fileInfo.FullName, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
        try {
            $handle = $file.SafeFileHandle
            $fileInfoStruct = [BY_HANDLE_FILE_INFORMATION]::new()
            if ([Kernel32]::GetFileInformationByHandle($handle.DangerousGetHandle(), [ref]$fileInfoStruct)) {
                return $fileInfoStruct.NumberOfLinks -gt 1
            }
        }
        finally {
            $file.Close()
        }
    }
    catch {
        # Fallback: Check LinkType property (less reliable for hard links but fast)
        try {
            $item = Get-Item $Path -Force -ErrorAction SilentlyContinue
            # Note: LinkType is "HardLink" only shows for files created via mklink /H or New-Item -ItemType HardLink
            # but it may not always be populated correctly
            return $item.LinkType -eq 'HardLink'
        }
        catch {
            return $false
        }
    }
    
    return $false
}

function Test-IsSymbolicLink {
    <#
    .SYNOPSIS
        Check if a path is a symbolic link
    #>
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        return $false
    }
    
    $item = Get-Item $Path -Force
    return $item.LinkType -eq 'SymbolicLink'
}

function Get-HardLinkCount {
    <#
    .SYNOPSIS
        Get the number of hard links to a file using efficient P/Invoke
    #>
    param([string]$Path)
    
    if (-not (Test-Path $Path -PathType Leaf)) {
        return 0
    }
    
    try {
        $fileInfo = [System.IO.FileInfo]::new((Resolve-Path $Path).Path)
        $file = [System.IO.File]::Open($fileInfo.FullName, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
        try {
            $handle = $file.SafeFileHandle
            $fileInfoStruct = [BY_HANDLE_FILE_INFORMATION]::new()
            if ([Kernel32]::GetFileInformationByHandle($handle.DangerousGetHandle(), [ref]$fileInfoStruct)) {
                return $fileInfoStruct.NumberOfLinks
            }
        }
        finally {
            $file.Close()
        }
    }
    catch {
        return 1
    }
    
    return 1
}

#endregion

#region Cleanup Functions

function Remove-Hardlinks {
    <#
    .SYNOPSIS
        Clean up existing hard links and symbolic links
    #>
    Write-Info "Cleaning up existing links..."
    
    # Files that might be hard linked to root
    $filesToClean = @(
        "config.toml",
        "wrangler.jsonc",
        "frontmatter.json",
        ".frontmatter\database\mediaDb.json",
        ".frontmatter\database\pinnedItemsDb.json",
        ".frontmatter\database\taxonomyDb.json"
    )
    
    # Remove hard linked files if they exist and are hard links
    foreach ($file in $filesToClean) {
        if (Test-Path $file -PathType Leaf) {
            if (Test-IsHardLink $file) {
                Write-Info "Removing hard linked file: $file"
                Remove-Item $file -Force
            }
        }
    }
    
    # Remove content directory if it's a symbolic link or junction
    if (Test-Path "content") {
        $contentItem = Get-Item "content" -Force
        if ($contentItem.LinkType -in @('SymbolicLink', 'Junction')) {
            Write-Info "Removing linked content directory ($($contentItem.LinkType))"
            # On Windows, use .Delete() method for symlinks and junctions
            $contentItem.Delete()
        }
        elseif (Test-Path "content" -PathType Container) {
            # Check if it contains hard linked files
            $hardlinkedFiles = Get-ChildItem "content" -Recurse -File | Where-Object { Test-IsHardLink $_.FullName }
            if ($hardlinkedFiles.Count -gt 0) {
                Write-Info "Removing content directory with hard linked files"
                Remove-Item "content" -Recurse -Force
            }
        }
    }
    
    # Remove hard linked files from static directory (but keep the directory and shared files)
    if (Test-Path "static" -PathType Container) {
        Write-Info "Cleaning up hard linked files from static directory"
        
        # Find and remove only hard linked files in static
        Get-ChildItem "static" -Recurse -File | ForEach-Object {
            if (Test-IsHardLink $_.FullName) {
                Write-Info "Removing hard linked static file: $($_.FullName)"
                Remove-Item $_.FullName -Force
            }
        }
        
        # Remove empty directories in static (but keep static itself)
        Get-ChildItem "static" -Recurse -Directory | 
            Sort-Object { $_.FullName.Length } -Descending |
            Where-Object { (Get-ChildItem $_.FullName -Force).Count -eq 0 } |
            ForEach-Object {
                Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
            }
    }
    
    Write-Success "Cleanup completed"
}

#endregion

#region Link Creation Functions

function New-FileHardlinks {
    <#
    .SYNOPSIS
        Create hard links for individual configuration files
    #>
    param([string]$SourceDir)
    
    $files = @(
        "config.toml",
        "wrangler.jsonc",
        "frontmatter.json",
        ".frontmatter\database\mediaDb.json",
        ".frontmatter\database\pinnedItemsDb.json",
        ".frontmatter\database\taxonomyDb.json"
    )
    
    Write-Info "Creating hard links for individual files from $SourceDir..."
    
    foreach ($file in $files) {
        $sourceFile = Join-Path $SourceDir $file
        $targetFile = $file
        
        if (Test-Path $sourceFile -PathType Leaf) {
            # Remove existing file if it exists
            if (Test-Path $targetFile) {
                Remove-Item $targetFile -Force
            }
            
            # Create parent directory if needed
            $targetDir = Split-Path $targetFile -Parent
            if ($targetDir -and -not (Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            
            # Create hard link using New-Item
            try {
                New-Item -ItemType HardLink -Path $targetFile -Target (Resolve-Path $sourceFile).Path -Force | Out-Null
                Write-Success "Created hard link: $sourceFile -> $targetFile"
            }
            catch {
                Write-ErrorMsg "Failed to create hard link for $file : $_"
            }
        }
        else {
            Write-WarningMsg "Source file not found: $sourceFile"
        }
    }
}

function Test-IsJunction {
    <#
    .SYNOPSIS
        Check if a path is a junction point
    #>
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        return $false
    }
    
    $item = Get-Item $Path -Force
    return $item.LinkType -eq 'Junction'
}

function New-ContentSymlink {
    <#
    .SYNOPSIS
        Create symbolic link or junction for content directory
    .NOTES
        On Windows, creating symbolic links requires either:
        1. Developer Mode enabled (Windows 10 1703+), or
        2. Running as Administrator
        
        As a fallback, we use Junction points which do NOT require admin privileges.
        Junctions are similar to symbolic links but only work for directories and must use absolute paths.
    #>
    param([string]$SourceDir)
    
    $sourceContent = Join-Path $SourceDir "content"
    $targetContent = "content"
    
    Write-Info "Creating link for content directory from $SourceDir..."
    
    if (Test-Path $sourceContent -PathType Container) {
        # Remove existing content directory/symlink/junction
        if (Test-Path $targetContent) {
            $item = Get-Item $targetContent -Force
            if ($item.LinkType -in @('SymbolicLink', 'Junction')) {
                # For symlinks and junctions, use .Delete() method
                $item.Delete()
            }
            else {
                Remove-Item $targetContent -Recurse -Force
            }
        }
        
        $absoluteSource = (Resolve-Path $sourceContent).Path
        
        # Try symbolic link first (preferred - works with relative paths)
        try {
            New-Item -ItemType SymbolicLink -Path $targetContent -Target $absoluteSource -Force | Out-Null
            Write-Success "Created symbolic linked content directory: $sourceContent -> $targetContent"
            return
        }
        catch {
            Write-WarningMsg "Symbolic link creation failed (requires Developer Mode or Admin)"
        }
        
        # Fallback: Use Junction (works without admin on NTFS)
        try {
            New-Item -ItemType Junction -Path $targetContent -Target $absoluteSource -Force | Out-Null
            Write-Success "Created junction for content directory: $sourceContent -> $targetContent"
            Write-Info "Note: Junction used as fallback. Enable Developer Mode for symbolic links."
        }
        catch {
            Write-ErrorMsg "Failed to create junction for content directory: $_"
            Write-WarningMsg "Both symbolic link and junction creation failed."
            Write-WarningMsg "Make sure Developer Mode is enabled: Settings -> Update & Security -> For developers"
        }
    }
    else {
        Write-WarningMsg "Source content directory not found: $sourceContent"
    }
}

function New-StaticHardlinks {
    <#
    .SYNOPSIS
        Create hard links for static files
    #>
    param([string]$SourceDir)
    
    $sourceStatic = Join-Path $SourceDir "static"
    $targetStatic = "static"
    
    Write-Info "Creating hard links for static files from $SourceDir..."
    
    if (Test-Path $sourceStatic -PathType Container) {
        # Create the static directory if it doesn't exist
        if (-not (Test-Path $targetStatic)) {
            New-Item -ItemType Directory -Path $targetStatic -Force | Out-Null
        }
        
        # Create hard links for all files in the static directory
        Get-ChildItem $sourceStatic -Recurse -File | ForEach-Object {
            $relativePath = $_.FullName.Substring((Resolve-Path $sourceStatic).Path.Length + 1)
            $targetFile = Join-Path $targetStatic $relativePath
            $targetDir = Split-Path $targetFile -Parent
            
            # Create target directory if it doesn't exist
            if (-not (Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            
            # Check if target file exists
            if (Test-Path $targetFile) {
                if (Test-IsHardLink $targetFile) {
                    Write-Info "Replacing hard linked file: $targetFile"
                    Remove-Item $targetFile -Force
                }
                else {
                    # File exists but is not hard linked (shared file), skip it
                    Write-Info "Skipping shared file: $targetFile (already exists)"
                    return
                }
            }
            
            # Create hard link
            try {
                New-Item -ItemType HardLink -Path $targetFile -Target $_.FullName -Force | Out-Null
                Write-Info "Created hard link: $($_.FullName) -> $targetFile"
            }
            catch {
                Write-ErrorMsg "Failed to create hard link for $($_.Name): $_"
            }
        }
        
        Write-Success "Created hard links for static files from: $sourceStatic"
    }
    else {
        Write-WarningMsg "Source static directory not found: $sourceStatic"
    }
}

#endregion

#region Main Functions

function Switch-ToSite {
    <#
    .SYNOPSIS
        Main switch function to change site mode
    #>
    param([string]$Site)
    
    $siteDir = $Site
    
    Write-Info "Switching to site: $Site"
    
    # Validate site directory exists
    if (-not (Test-Path $siteDir -PathType Container)) {
        Write-ErrorMsg "Site directory '$siteDir' does not exist!"
        exit 1
    }
    
    # Clean up existing hard links first
    Remove-Hardlinks
    
    # Create new links
    New-FileHardlinks $siteDir
    New-ContentSymlink $siteDir
    New-StaticHardlinks $siteDir
    
    Write-Success "Successfully switched to $Site mode!"
    Write-Info "You can now run 'zola serve' to start the development server"
}

function Invoke-CleanMode {
    <#
    .SYNOPSIS
        Clean mode - restore original state
    #>
    Write-Info "Cleaning up all links and restoring original state..."
    
    Remove-Hardlinks
    
    Write-Success "Cleanup completed! Original state restored."
    Write-Info "All links have been removed from the project root."
}

function Get-SiteStatus {
    <#
    .SYNOPSIS
        Check current site status
    #>
    Write-Info "Current dual site mode status:"
    Write-Host ""
    
    if (Test-Path "config.toml" -PathType Leaf) {
        $configContent = Get-Content "config.toml" -Raw -ErrorAction SilentlyContinue
        $baseUrl = if ($configContent -match 'base_url\s*=\s*"([^"]+)"') { $Matches[1] } else { "unknown" }
        $title = if ($configContent -match 'title\s*=\s*"([^"]+)"') { $Matches[1] } else { "unknown" }
        Write-Info "Active site: $baseUrl ($title)"
        
        # Check if it's a hard link
        if (Test-IsHardLink "config.toml") {
            Write-Host "  Status: Hard linked ✓"
        }
        else {
            Write-Host "  Status: Not hard linked (possible issue)"
        }
    }
    else {
        Write-WarningMsg "No config.toml found - not in any site mode"
    }
    
    if (Test-Path "content") {
        $contentFiles = (Get-ChildItem "content" -Recurse -File -ErrorAction SilentlyContinue).Count
        Write-Host "  Content files: $contentFiles"
        
        # Check if content is a symbolic link or junction
        $contentItem = Get-Item "content" -Force
        if ($contentItem.LinkType -eq 'SymbolicLink') {
            Write-Host "  Content status: Symbolic linked ✓"
        }
        elseif ($contentItem.LinkType -eq 'Junction') {
            Write-Host "  Content status: Junction linked ✓"
        }
        else {
            $hardlinkedFiles = (Get-ChildItem "content" -Recurse -File | Where-Object { Test-IsHardLink $_.FullName }).Count
            if ($hardlinkedFiles -gt 0) {
                Write-Host "  Content status: Hard linked ✓"
            }
            else {
                Write-Host "  Content status: Not linked (possible issue)"
            }
        }
    }
    else {
        Write-WarningMsg "No content directory found"
    }
    
    if (Test-Path "static" -PathType Container) {
        $staticFiles = (Get-ChildItem "static" -Recurse -File -ErrorAction SilentlyContinue).Count
        Write-Host "  Static files: $staticFiles"
        
        # Check if static contains hard links
        $hardlinkedStaticFiles = (Get-ChildItem "static" -Recurse -File | Where-Object { Test-IsHardLink $_.FullName }).Count
        if ($hardlinkedStaticFiles -gt 0) {
            Write-Host "  Static status: Hard linked files + shared files ✓"
        }
        else {
            Write-Host "  Static status: Shared files only (no site-specific files)"
        }
    }
    else {
        Write-WarningMsg "No static directory found"
    }
}

function Invoke-InteractiveSiteSelection {
    <#
    .SYNOPSIS
        Interactive site selection menu
    #>
    Write-Info "Dual Site Mode Switcher"
    Write-Host ""
    Write-Host "Please select a site to switch to:"
    Write-Host ""
    Write-Host "1) 琳.tw - 琳的備忘手札 (技術部落格)"
    Write-Host "2) 聆.tw - 琳聽智者漫談 (AI 對話)"
    Write-Host "3) Clean up and restore original state"
    Write-Host "4) Check current status"
    Write-Host "5) Exit"
    Write-Host ""
    
    while ($true) {
        $choice = Read-Host "Enter your choice (1-5)"
        switch ($choice) {
            "1" {
                Write-Host ""
                Switch-ToSite "琳.tw"
                break
            }
            "2" {
                Write-Host ""
                Switch-ToSite "聆.tw"
                break
            }
            "3" {
                Write-Host ""
                Invoke-CleanMode
                break
            }
            "4" {
                Write-Host ""
                Get-SiteStatus
                break
            }
            "5" {
                Write-Host ""
                Write-Info "Goodbye!"
                exit 0
            }
            default {
                Write-ErrorMsg "Invalid choice. Please enter 1-5."
                continue
            }
        }
        break
    }
}

#endregion

#region Main Script Logic

# Check if we're in a git repository
if (-not (Test-GitRepository)) {
    Write-ErrorMsg "Not in a git repository!"
    exit 1
}

# Main script logic
switch ($SiteName) {
    "琳.tw" { Switch-ToSite "琳.tw" }
    "聆.tw" { Switch-ToSite "聆.tw" }
    "clean" { Invoke-CleanMode }
    "status" { Get-SiteStatus }
    "" { Invoke-InteractiveSiteSelection }
    default {
        Write-ErrorMsg "Unknown command: $SiteName"
        Write-Host ""
        Show-Usage
        exit 1
    }
}

#endregion
