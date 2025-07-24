#!/bin/bash
# Copyright (C) 2025 Jim Chen <Jim@ChenJ.im>, licensed under GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ==================================================================
#
# Dual Site Mode Switcher for Zola Blog
# Switches between 琳.tw and 聆.tw site configurations
#
# Usage:
#   ./switch-site.sh           # Interactive mode - choose site from menu
#   ./switch-site.sh 琳.tw     # Switch to 琳.tw site mode
#   ./switch-site.sh 聆.tw     # Switch to 聆.tw site mode
#   ./switch-site.sh clean     # Remove all hard links and restore original state
#   ./switch-site.sh status    # Check current site status

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Show usage
usage() {
    echo "Usage: $0 [site_name|command]"
    echo ""
    echo "Commands:"
    echo "  琳.tw     Switch to 琳.tw site mode (技術部落格)"
    echo "  聆.tw     Switch to 聆.tw site mode (AI 對話)"
    echo "  clean     Remove all hard links and restore original state"
    echo "  status    Check current site status"
    echo ""
    echo "Interactive mode:"
    echo "  $0        # Run without parameters for interactive site selection"
    echo ""
    echo "Examples:"
    echo "  $0            # Interactive mode"
    echo "  $0 琳.tw      # Switch to technical blog mode"
    echo "  $0 聆.tw      # Switch to AI talks mode"
    echo "  $0 clean      # Clean up and restore original state"
    echo "  $0 status     # Check current site status"
}

# Check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository!"
        exit 1
    fi
}

# Interactive site selection
interactive_site_selection() {
    print_info "Dual Site Mode Switcher"
    echo ""
    echo "Please select a site to switch to:"
    echo ""
    echo "1) 琳.tw - 琳的備忘手札 (技術部落格)"
    echo "2) 聆.tw - 琳聽智者漫談 (AI 對話)"
    echo "3) Clean up and restore original state"
    echo "4) Check current status"
    echo "5) Exit"
    echo ""
    
    while true; do
        read -rp "Enter your choice (1-5): " choice
        case $choice in
            1)
                echo ""
                switch_to_site "琳.tw"
                break
            ;;
            2)
                echo ""
                switch_to_site "聆.tw"
                break
            ;;
            3)
                echo ""
                clean_mode
                break
            ;;
            4)
                echo ""
                check_status
                break
            ;;
            5)
                echo ""
                print_info "Goodbye!"
                exit 0
            ;;
            *)
                print_error "Invalid choice. Please enter 1-5."
            ;;
        esac
    done
}

# Clean up existing hard links
cleanup_hardlinks() {
    print_info "Cleaning up existing hard links..."
    
    # Files that might be hard linked to root
    local files_to_clean=(
        "config.toml"
        "wrangler.jsonc"
    )
    
    # Remove hard linked files if they exist and are hard links
    for file in "${files_to_clean[@]}"; do
        if [[ -f "$file" ]]; then
            # Check if it's a hard link (link count > 1)
            if [[ $(stat -c '%h' "$file" 2>/dev/null) -gt 1 ]]; then
                print_info "Removing hard linked file: $file"
                rm -f "$file"
            fi
        fi
    done
    
    # Remove content directory if it's a hard link
    if [[ -d "content" ]]; then
        # Check if content is a symbolic link or if it contains hard linked files
        if [[ -L "content" ]] || [[ $(find content -type f -links +1 2>/dev/null | wc -l) -gt 0 ]]; then
            print_info "Removing hard linked content directory"
            rm -rf "content"
        fi
    fi
    
    # Remove hard linked files from static directory (but keep the directory and shared files)
    if [[ -d "static" ]]; then
        print_info "Cleaning up hard linked files from static directory"
        # Find and remove only hard linked files in static
        find static -type f -links +1 2>/dev/null | while read -r hardlinked_file; do
            print_info "Removing hard linked static file: $hardlinked_file"
            rm -f "$hardlinked_file"
        done
        
        # Remove empty directories in static (but keep static itself)
        find static -type d -empty -not -path "static" 2>/dev/null | while read -r empty_dir; do
            rmdir "$empty_dir" 2>/dev/null || true
        done
    fi
    
    print_success "Cleanup completed"
}

# Create hard links for individual files
create_file_hardlinks() {
    local source_dir="$1"
    local files=(
        "config.toml"
        "wrangler.jsonc"
    )
    
    print_info "Creating hard links for individual files from $source_dir..."
    
    for file in "${files[@]}"; do
        local source_file="$source_dir/$file"
        local target_file="$file"
        
        if [[ -f "$source_file" ]]; then
            # Remove existing file if it exists
            [[ -f "$target_file" ]] && rm -f "$target_file"
            
            # Create hard link
            ln "$source_file" "$target_file"
            print_success "Created hard link: $source_file -> $target_file"
        else
            print_warning "Source file not found: $source_file"
        fi
    done
}

# Create hard link for content directory
create_content_hardlink() {
    local source_dir="$1"
    local source_content="$source_dir/content"
    local target_content="content"
    
    print_info "Creating hard link for content directory from $source_dir..."
    
    if [[ -d "$source_content" ]]; then
        # Remove existing content directory
        [[ -d "$target_content" ]] && rm -rf "$target_content"
        
        # Create hard link for the entire directory
        # Note: We use cp -al which creates hard links for all files
        cp -al "$source_content" "$target_content"
        print_success "Created hard linked content directory: $source_content -> $target_content"
    else
        print_warning "Source content directory not found: $source_content"
    fi
}

# Create hard link for static directory
create_static_hardlink() {
    local source_dir="$1"
    local source_static="$source_dir/static"
    local target_static="static"
    
    print_info "Creating hard links for static files from $source_dir..."
    
    if [[ -d "$source_static" ]]; then
        # Create the static directory if it doesn't exist
        [[ ! -d "$target_static" ]] && mkdir -p "$target_static"
        
        # Create hard links for all files in the static directory
        find "$source_static" -type f | while read -r source_file; do
            local relative_path="${source_file#$source_static/}"
            local target_file="$target_static/$relative_path"
            local target_dir
            target_dir="$(dirname "$target_file")"
            
            # Create target directory if it doesn't exist
            [[ ! -d "$target_dir" ]] && mkdir -p "$target_dir"
            
            # Remove existing file if it exists (only if it's a hard link from previous sites)
            if [[ -f "$target_file" ]]; then
                local link_count
                link_count=$(stat -c '%h' "$target_file" 2>/dev/null)
                if [[ $link_count -gt 1 ]]; then
                    print_info "Replacing hard linked file: $target_file"
                    rm -f "$target_file"
                    elif [[ ! -f "$target_file" ]]; then
                    # File doesn't exist, safe to create hard link
                    :
                else
                    # File exists but is not hard linked (shared file), skip it
                    print_info "Skipping shared file: $target_file (already exists)"
                    continue
                fi
            fi
            
            # Create hard link
            ln "$source_file" "$target_file"
            print_info "Created hard link: $source_file -> $target_file"
        done
        
        print_success "Created hard links for static files from: $source_static"
    else
        print_warning "Source static directory not found: $source_static"
    fi
}

# Update .gitignore to ignore hard linked files
update_gitignore() {
    local gitignore_file=".gitignore"
    local ignore_patterns=(
        "# Dual site mode - hard linked files"
        "config.toml"
        "wrangler.jsonc"
        "content/"
        # Don't ignore entire static/ directory since it contains shared files
        # Individual hard linked files will be managed by the script
    )
    
    print_info "Updating .gitignore..."
    
    # Check if our patterns are already in .gitignore
    local needs_update=false
    for pattern in "${ignore_patterns[@]}"; do
        if ! grep -Fxq "$pattern" "$gitignore_file" 2>/dev/null; then
            needs_update=true
            break
        fi
    done
    
    if [[ "$needs_update" == "true" ]]; then
        # Add patterns to .gitignore
        echo "" >> "$gitignore_file"
        for pattern in "${ignore_patterns[@]}"; do
            if ! grep -Fxq "$pattern" "$gitignore_file" 2>/dev/null; then
                echo "$pattern" >> "$gitignore_file"
            fi
        done
        print_success "Updated .gitignore with hard link patterns"
    else
        print_info ".gitignore already contains necessary patterns"
    fi
}

# Clean up .gitignore (remove dual site patterns)
cleanup_gitignore() {
    local gitignore_file=".gitignore"
    local temp_file
    temp_file=$(mktemp)
    
    print_info "Cleaning up .gitignore..."
    
    # Remove dual site related patterns (but keep static/ since it's shared)
    if [[ -f "$gitignore_file" ]]; then
        grep -v -E "^# Dual site mode|^config\.toml$|^wrangler\.jsonc$|^content/$" "$gitignore_file" > "$temp_file" || true
        mv "$temp_file" "$gitignore_file"
        print_success "Cleaned up .gitignore"
    fi
}

# Main switch function
switch_to_site() {
    local site_name="$1"
    local site_dir="$site_name"
    
    print_info "Switching to site: $site_name"
    
    # Validate site directory exists
    if [[ ! -d "$site_dir" ]]; then
        print_error "Site directory '$site_dir' does not exist!"
        exit 1
    fi
    
    # Clean up existing hard links first
    cleanup_hardlinks
    
    # Create new hard links
    create_file_hardlinks "$site_dir"
    create_content_hardlink "$site_dir"
    create_static_hardlink "$site_dir"
    
    print_success "Successfully switched to $site_name mode!"
    print_info "Hard linked files and directories:"
    echo "  - config.toml"
    echo "  - wrangler.jsonc"
    echo "  - content/ (directory)"
    echo "  - static/ (site-specific files only)"
    echo ""
    print_info "You can now run 'zola serve' to start the development server"
}

# Clean mode - restore original state
clean_mode() {
    print_info "Cleaning up all hard links and restoring original state..."
    
    cleanup_hardlinks
    
    print_success "Cleanup completed! Original state restored."
    print_info "All hard links have been removed from the project root."
}

# Check current site status
check_status() {
    print_info "Current dual site mode status:"
    echo ""
    
    if [[ -f "config.toml" ]]; then
        local base_url
        local title
        base_url=$(grep '^base_url' config.toml | cut -d'"' -f2 2>/dev/null || echo "unknown")
        title=$(grep '^title' config.toml | cut -d'"' -f2 2>/dev/null || echo "unknown")
        print_info "Active site: $base_url ($title)"
        
        # Check if it's a hard link
        if [[ $(stat -c '%h' "config.toml" 2>/dev/null) -gt 1 ]]; then
            echo "  Status: Hard linked ✓"
        else
            echo "  Status: Not hard linked (possible issue)"
        fi
    else
        print_warning "No config.toml found - not in any site mode"
    fi
    
    if [[ -d "content" ]]; then
        local content_files
        content_files=$(find content -type f 2>/dev/null | wc -l)
        echo "  Content files: $content_files"
        
        # Check if content contains hard links
        local hardlinked_files
        hardlinked_files=$(find content -type f -links +1 2>/dev/null | wc -l)
        if [[ $hardlinked_files -gt 0 ]]; then
            echo "  Content status: Hard linked ✓"
        else
            echo "  Content status: Not hard linked (possible issue)"
        fi
    else
        print_warning "No content directory found"
    fi
    
    if [[ -d "static" ]]; then
        local static_files
        static_files=$(find static -type f 2>/dev/null | wc -l)
        echo "  Static files: $static_files"
        
        # Check if static contains hard links
        local hardlinked_static_files
        hardlinked_static_files=$(find static -type f -links +1 2>/dev/null | wc -l)
        if [[ $hardlinked_static_files -gt 0 ]]; then
            echo "  Static status: Hard linked files + shared files ✓"
        else
            echo "  Static status: Shared files only (no site-specific files)"
        fi
    else
        print_warning "No static directory found"
    fi
}

# Main script logic
main() {
    check_git_repo
    
    case "${1:-}" in
        "琳.tw"|"聆.tw")
            switch_to_site "$1"
        ;;
        "clean")
            clean_mode
        ;;
        "status")
            check_status
        ;;
        "-h"|"--help")
            usage
        ;;
        "")
            # Interactive mode when no parameters provided
            interactive_site_selection
        ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            usage
            exit 1
        ;;
    esac
}

main "$@"
