#!/bin/zsh
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
# Copy Markdown Files to Static Directory
# Copies markdown files from content/ to static/ directory for LLM crawlers
# to access markdown format instead of HTML.
#
# Usage: ./copy-markdown-to-static.zsh [OPTIONS]
# The script will process all .md files in content subdirectories.
#
# Dependencies:
# - zsh
# - standard Unix tools (mkdir, cp)

# Global variables
DEBUG_MODE=false
DRY_RUN=false
VERBOSE=false
CONTENT_DIR="content"
STATIC_DIR="static"

# Color codes for output
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly GRAY='\033[0;37m'
readonly RESET='\033[0m'

# Statistics
TOTAL_FILES=0
COPIED_FILES=0
SKIPPED_FILES=0
ERROR_FILES=0

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${RESET} $1" >&2; }
log_success() { echo -e "${GREEN}[SUCCESS]${RESET} $1" >&2; }
log_warn() { echo -e "${YELLOW}[WARNING]${RESET} $1" >&2; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1" >&2; }
log_debug() {
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo -e "${GRAY}[DEBUG]${RESET} $1" >&2;
    fi
}
log_verbose() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${GRAY}[VERBOSE]${RESET} $1" >&2;
    fi
}

# Check if a markdown file has draft = true in frontmatter
# Returns 0 (true) if draft = true is found, 1 (false) otherwise
is_draft() {
    local md_file="$1"
    local line_count=0
    local in_frontmatter=false
    local frontmatter_count=0
    
    while IFS= read -r line; do
        line_count=$((line_count + 1))
        
        # Check for frontmatter delimiter
        if [[ "$line" == "+++" ]]; then
            frontmatter_count=$((frontmatter_count + 1))
            if [[ $frontmatter_count -eq 1 ]]; then
                in_frontmatter=true
                elif [[ $frontmatter_count -eq 2 ]]; then
                # Reached end of frontmatter without finding draft = true
                return 1
            fi
            continue
        fi
        
        # If we're in frontmatter, check for draft = true
        if [[ "$in_frontmatter" == "true" ]]; then
            if [[ "$line" =~ ^[[:space:]]*draft[[:space:]]*=[[:space:]]*true ]]; then
                log_debug "Found draft = true in: $md_file"
                return 0  # Found draft = true
            fi
        fi
        
        # Stop after 30 lines
        if [[ $line_count -ge 30 ]]; then
            break
        fi
    done < "$md_file"
    
    return 1  # No draft = true found
}

# Display help message
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Copy markdown files from content/ to static/ directory for LLM crawler access.

Options:
  -h, --help       Show this help message
  -d, --debug      Enable debug output
  -n, --dry-run    Show what would be done without actually copying
  -v, --verbose    Show detailed copy operations

Examples:
  $0                   # Copy all markdown files
  $0 --dry-run         # Preview operations without copying
  $0 --verbose         # Show detailed progress

File Path Mapping:
  Single-file articles:
    content/AI/example.md -> static/AI/example/markdown.md

  Directory-based articles:
    content/Crypto/example/index.md -> static/Crypto/example/markdown.md

Notes:
  - Skips _index.md files (section indexes)
  - Creates target directories as needed
  - Operations are idempotent (safe to run multiple times)

EOF
}

# Check if required directories exist
check_directories() {
    log_debug "Checking required directories..."
    
    if [[ ! -d "$CONTENT_DIR" ]]; then
        log_error "Content directory not found: $CONTENT_DIR"
        log_error "Please ensure you are in the project root directory"
        return 1
    fi
    log_debug "Content directory: OK"
    
    if [[ ! -d "$STATIC_DIR" ]]; then
        log_error "Static directory not found: $STATIC_DIR"
        log_error "Please ensure you are in the project root directory"
        return 1
    fi
    log_debug "Static directory: OK"
    
    return 0
}

# Process a single markdown file
process_file() {
    local md_file="$1"
    local target=""
    
    TOTAL_FILES=$((TOTAL_FILES + 1))
    
    # Skip _index.md files
    if [[ "$md_file" == *"_index.md" ]]; then
        log_verbose "Skipping section index: $md_file"
        SKIPPED_FILES=$((SKIPPED_FILES + 1))
        return 0
    fi
    
    # Skip draft articles
    if is_draft "$md_file"; then
        log_verbose "Skipping draft article: $md_file"
        SKIPPED_FILES=$((SKIPPED_FILES + 1))
        return 0
    fi
    
    # Calculate target path
    if [[ "$md_file" == */index.md ]]; then
        # Directory-based article: content/Category/article-name/index.md → static/Category/article-name/markdown.md
        local parent_dir="${md_file:h}"  # Get directory part
        parent_dir="${parent_dir#$CONTENT_DIR/}"  # Remove content/ prefix
        target="$STATIC_DIR/${parent_dir}/markdown.md"
        log_debug "Directory-based article: $md_file -> $target"
    else
        # Single-file article: content/Category/article-name.md → static/Category/article-name/markdown.md
        local base_name="${md_file:t:r}"  # Get filename without extension
        local parent_dir="${md_file:h}"
        parent_dir="${parent_dir#$CONTENT_DIR/}"
        target="$STATIC_DIR/${parent_dir}/${base_name}/markdown.md"
        log_debug "Single-file article: $md_file -> $target"
    fi
    
    # Create target directory and copy file
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would copy: $md_file -> $target"
        COPIED_FILES=$((COPIED_FILES + 1))
    else
        local target_dir="${target:h}"
        if ! mkdir -p "$target_dir" 2>/dev/null; then
            log_error "Failed to create directory: $target_dir"
            ERROR_FILES=$((ERROR_FILES + 1))
            return 1
        fi
        
        if cp "$md_file" "$target" 2>/dev/null; then
            log_verbose "Copied: $md_file -> $target"
            COPIED_FILES=$((COPIED_FILES + 1))
        else
            log_error "Failed to copy: $md_file"
            ERROR_FILES=$((ERROR_FILES + 1))
            return 1
        fi
    fi
    
    return 0
}

# Main function
main() {
    log_info "Starting markdown copy process..."
    
    if ! check_directories; then
        return 1
    fi
    
    # Find and process all .md files
    log_info "Scanning for markdown files in $CONTENT_DIR..."
    
    # Enable extended glob and null_glob options for proper pattern matching
    setopt extended_glob null_glob
    
    # Use glob pattern to find all .md files recursively
    local md_files=($CONTENT_DIR/**/*.md)
    
    if [[ ${#md_files[@]} -eq 0 ]]; then
        log_warn "No markdown files found in $CONTENT_DIR"
        return 0
    fi
    
    log_info "Found ${#md_files[@]} markdown files"
    
    # Process each file
    for md_file in "${md_files[@]}"; do
        process_file "$md_file"
    done
    
    # Print statistics
    echo ""
    log_info "Processing complete!"
    log_info "Total files scanned: $TOTAL_FILES"
    log_success "Files copied: $COPIED_FILES"
    log_warn "Files skipped: $SKIPPED_FILES"
    if [[ $ERROR_FILES -gt 0 ]]; then
        log_error "Files with errors: $ERROR_FILES"
        return 1
    fi
    
    return 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
        ;;
        -d|--debug)
            DEBUG_MODE=true
            log_debug "Debug mode enabled"
            shift
        ;;
        -n|--dry-run)
            DRY_RUN=true
            log_info "Dry run mode enabled"
            shift
        ;;
        -v|--verbose)
            VERBOSE=true
            log_verbose "Verbose mode enabled"
            shift
        ;;
        *)
            log_error "Unknown option: $1"
            echo ""
            show_help
            exit 1
        ;;
    esac
done

# Run main function
main
exit $?
