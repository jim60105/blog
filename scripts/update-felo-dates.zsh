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
# Update Felo Dates
# Updates the date field in markdown front matter with the creation date
# fetched from Felo.ai API for articles that have a withAI field.
#
# Usage: ./update-felo-dates.zsh [OPTIONS]
# The script will process all .md files in content subdirectories.
#
# Dependencies:
# - curl or wget
# - jq
# - sed

# Global variables
DEBUG_MODE=false
DRY_RUN=false
CONTENT_DIR="content"

# Color codes for output
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly GRAY='\033[0;37m'
readonly RESET='\033[0m'

# Statistics
TOTAL_FILES=0
PROCESSED_FILES=0
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

# Check if required tools are available
check_dependencies() {
    log_info "Checking dependencies..."
    log_debug "Checking for required tools: curl/wget, jq, sed"
    
    local missing_tools=()
    
    if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
        missing_tools+="curl or wget"
        log_debug "curl/wget: NOT FOUND"
    else
        log_debug "curl/wget: FOUND"
    fi
    
    for tool in jq sed; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_tools+="$tool"
            log_debug "$tool: NOT FOUND"
        else
            log_debug "$tool: FOUND"
        fi
    done
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        log_error "Please install the missing tools and try again."
        return 1
    fi
    
    log_success "All dependencies are available"
    log_debug "Dependencies check completed successfully"
    return 0
}

# Extract withAI URL from markdown front matter
extract_with_ai_url() {
    local md_file="$1"
    
    log_debug "Extracting withAI URL from: $md_file"
    
    # Look for withAI field in the front matter (between +++ markers)
    local with_ai_url
    with_ai_url=$(sed -n '/^+++$/,/^+++$/p' "$md_file" | grep -E '^withAI\s*=' | sed -E 's/^withAI\s*=\s*[<"]*([^>"]+)[>"]*.*$/\1/')
    
    if [[ -n "$with_ai_url" && "$with_ai_url" != "null" ]]; then
        log_debug "Found withAI URL: $with_ai_url"
        echo "$with_ai_url"
        return 0
    else
        log_debug "No withAI URL found in $md_file"
        return 1
    fi
}

# Extract thread ID from Felo URL (adapted from felo-search-parser.zsh)
extract_thread_id_from_url() {
    local url="$1"
    
    log_debug "extract_thread_id_from_url called with: $url"
    
    # Basic URL validation - support both formats:
    # https://felo.ai/search/{threadId}
    # https://felo.ai/{lang}/search/{threadId}
    if [[ ! "$url" =~ ^https://felo\.ai/(search/|[^/]+/search/) ]]; then
        log_error "Invalid URL format. Please provide a valid Felo.ai search URL."
        log_debug "URL validation failed for: $url"
        return 1
    fi
    
    log_debug "URL validation passed"
    
    # Extract thread ID from URL patterns:
    # https://felo.ai/search/{threadId}?...
    # https://felo.ai/{lang}/search/{threadId}?...
    local thread_id
    thread_id=$(echo "$url" | sed -E 's|^https://felo\.ai/([^/]+/)?search/([^?]+).*|\2|')
    
    if [[ -z "$thread_id" || "$thread_id" == "$url" ]]; then
        log_error "Could not extract thread ID from URL: $url"
        return 1
    fi
    
    log_debug "Extracted thread ID: $thread_id"
    printf '%s' "$thread_id"
    return 0
}

# Fetch creation date from Felo API
fetch_creation_date_from_api() {
    local thread_id="$1"
    
    log_debug "Fetching creation date from API for thread: $thread_id"
    
    # Create API URL
    local api_url="https://api.felo.ai/search/search/threads/${thread_id}"
    log_debug "API URL: $api_url"
    
    # Create temporary file to store content
    local temp_file=$(mktemp)
    local user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    
    log_debug "Created temporary file: $temp_file"
    
    # Use curl first, fallback to wget
    if command -v curl >/dev/null 2>&1; then
        log_debug "Using curl to fetch API content"
        local http_status
        http_status=$(curl -s -L -A "$user_agent" -w "%{http_code}" "$api_url" -o "$temp_file")
        local curl_exit_code=$?
        log_debug "curl exit code: $curl_exit_code, HTTP status: $http_status"
        
        if [[ $curl_exit_code -ne 0 ]]; then
            log_error "curl failed with exit code: $curl_exit_code"
            rm -f "$temp_file"
            return 1
        fi
        
        # Check for HTTP error status codes
        if [[ "$http_status" -lt 200 || "$http_status" -ge 400 ]]; then
            log_error "API request failed with HTTP status: $http_status"
            log_debug "Response content: $(cat "$temp_file")"
            rm -f "$temp_file"
            return 1
        fi
        
    elif command -v wget >/dev/null 2>&1; then
        log_debug "Using wget to fetch API content"
        wget -q -U "$user_agent" "$api_url" -O "$temp_file"
        local wget_exit_code=$?
        log_debug "wget exit code: $wget_exit_code"
        
        if [[ $wget_exit_code -ne 0 ]]; then
            log_error "wget failed with exit code: $wget_exit_code"
            rm -f "$temp_file"
            return 1
        fi
    else
        log_error "Neither curl nor wget is available"
        rm -f "$temp_file"
        return 1
    fi
    
    # Check if file exists and has content
    if [[ -f "$temp_file" ]]; then
        local content_length=$(wc -c < "$temp_file")
        log_debug "Content length: $content_length bytes"
        
        if [[ "$content_length" -gt 50 ]]; then
            # Extract created_at from JSON response
            local created_at
            created_at=$(jq -r '.created_at // empty' "$temp_file" 2>/dev/null)
            
            # If not available, try first message's created_at
            if [[ -z "$created_at" || "$created_at" == "null" ]]; then
                created_at=$(jq -r '.messages[0].created_at // empty' "$temp_file" 2>/dev/null)
                log_debug "Thread-level created_at not found, using first message created_at: $created_at"
            else
                log_debug "Using thread-level created_at: $created_at"
            fi
            
            # Clean up temporary file
            rm -f "$temp_file"
            
            if [[ -n "$created_at" && "$created_at" != "null" ]]; then
                # Convert ISO 8601 to Zola-compatible format
                # Input: "2025-03-16T07:14:58.526096" or "2025-03-16T07:14:58.526096Z" or "2025-03-16T07:14:58.526096+08:00"
                # Output: "2025-03-16T07:14:58Z"
                
                # Extract date and time components, remove microseconds
                local formatted_date
                formatted_date=$(echo "$created_at" | sed -E 's/(\.[0-9]+)?([+-][0-9]{2}:?[0-9]{2}|Z)?$//')
                
                # Handle timezone conversion
                if [[ "$created_at" =~ [+-][0-9]{2}:?[0-9]{2}$ ]]; then
                    # Convert to UTC using date command if timezone is specified
                    formatted_date=$(date -u -d "$created_at" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || echo "${formatted_date}Z")
                    log_debug "Converted timezone to UTC: $formatted_date"
                elif [[ "$created_at" =~ Z$ ]]; then
                    # Already has Z, just clean up microseconds
                    formatted_date="$formatted_date"Z
                    log_debug "Already UTC format: $formatted_date"
                else
                    # Add Z for UTC if no timezone specified (assume UTC)
                    formatted_date="${formatted_date}Z"
                    log_debug "No timezone specified, assuming UTC: $formatted_date"
                fi
                
                log_debug "Final formatted date: $formatted_date"
                echo "$formatted_date"
                return 0
            else
                log_error "Could not extract created_at from API response"
                return 1
            fi
        else
            log_error "API response too short or empty"
            log_debug "File size: $content_length bytes"
            rm -f "$temp_file"
            return 1
        fi
    else
        log_error "Failed to create temporary file or fetch content"
        return 1
    fi
}

# Update date field in markdown front matter
update_date_in_frontmatter() {
    local md_file="$1"
    local new_date="$2"
    
    log_debug "Updating date in front matter of: $md_file"
    log_debug "New date: $new_date"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would update date to: $new_date in $md_file"
        return 0
    fi
    
    # Create a backup
    cp "$md_file" "${md_file}.backup"
    
    # Update the date field in front matter
    # Look for 'date = ' and replace the value
    sed -i -E "s/^date\s*=\s*\"[^\"]+\"/date = \"$new_date\"/" "$md_file"
    
    # Verify the change was made
    local updated_date
    updated_date=$(sed -n '/^+++$/,/^+++$/p' "$md_file" | grep -E '^date\s*=' | sed -E 's/^date\s*=\s*"([^"]+)".*/\1/')
    
    if [[ "$updated_date" == "$new_date" ]]; then
        log_success "Updated date in $md_file"
        # Remove backup file on success
        rm -f "${md_file}.backup"
        return 0
    else
        log_error "Failed to update date in $md_file"
        # Restore from backup on failure
        mv "${md_file}.backup" "$md_file"
        return 1
    fi
}

# Process a single markdown file
process_markdown_file() {
    local md_file="$1"
    
    log_debug "Processing file: $md_file"
    ((TOTAL_FILES++))
    
    # Extract withAI URL from front matter
    local with_ai_url
    with_ai_url=$(extract_with_ai_url "$md_file")
    
    if [[ $? -ne 0 || -z "$with_ai_url" ]]; then
        log_debug "Skipping $md_file: no withAI field found"
        ((SKIPPED_FILES++))
        return 0
    fi
    
    log_info "Processing: $md_file"
    log_debug "Found withAI URL: $with_ai_url"
    
    # Extract thread ID from URL
    local thread_id
    thread_id=$(extract_thread_id_from_url "$with_ai_url")
    
    if [[ $? -ne 0 || -z "$thread_id" ]]; then
        log_error "Failed to extract thread ID from URL: $with_ai_url"
        ((ERROR_FILES++))
        return 1
    fi
    
    log_debug "Extracted thread ID: $thread_id"
    
    # Fetch creation date from API
    local creation_date
    creation_date=$(fetch_creation_date_from_api "$thread_id")
    
    if [[ $? -ne 0 || -z "$creation_date" ]]; then
        log_error "Failed to fetch creation date for thread: $thread_id"
        ((ERROR_FILES++))
        return 1
    fi
    
    log_debug "Fetched creation date: $creation_date"
    
    # Update date field in front matter
    if update_date_in_frontmatter "$md_file" "$creation_date"; then
        log_success "Successfully updated: $md_file"
        ((PROCESSED_FILES++))
    else
        log_error "Failed to update: $md_file"
        ((ERROR_FILES++))
        return 1
    fi
    
    return 0
}

# Process all markdown files in content directory
process_all_markdown_files() {
    log_info "Processing all markdown files in $CONTENT_DIR..."
    
    # Check if content directory exists
    if [[ ! -d "$CONTENT_DIR" ]]; then
        log_error "Content directory not found: $CONTENT_DIR"
        return 1
    fi
    
    # Find all .md files in subdirectories of content (not the root content directory)
    local md_files=()
    while IFS= read -r -d $'\0' file; do
        md_files+=("$file")
    done < <(find "$CONTENT_DIR" -mindepth 2 -name "*.md" -type f -print0)
    
    if [[ ${#md_files[@]} -eq 0 ]]; then
        log_warn "No markdown files found in $CONTENT_DIR subdirectories"
        return 0
    fi
    
    log_info "Found ${#md_files[@]} markdown files to check"
    
    # Process each file
    for md_file in "${md_files[@]}"; do
        process_markdown_file "$md_file"
        
        # Add a small delay to be respectful to the API
        sleep 0.5
    done
    
    return 0
}

# Show usage information
show_help() {
    local script_name="update-felo-dates.zsh"
    echo "Usage: $script_name [OPTIONS]"
    echo ""
    echo "Updates the date field in markdown front matter with the creation date"
    echo "fetched from Felo.ai API for articles that have a withAI field."
    echo ""
    echo "Options:"
    echo "  --debug      Enable debug logging"
    echo "  --dry-run    Show what would be changed without making actual changes"
    echo "  --content    Specify content directory (default: content)"
    echo "  -h, --help   Show this help message"
    echo ""
    echo "Examples:"
    echo "  $script_name"
    echo "  $script_name --debug"
    echo "  $script_name --dry-run"
    echo "  $script_name --content ./聆.tw/content"
}

# Print final statistics
print_statistics() {
    log_info "Processing completed!"
    log_info "Statistics:"
    log_info "  Total files checked: $TOTAL_FILES"
    log_info "  Files processed: $PROCESSED_FILES"
    log_info "  Files skipped (no withAI): $SKIPPED_FILES"
    log_info "  Files with errors: $ERROR_FILES"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "  (This was a dry run - no actual changes were made)"
    fi
}

# Main function
main() {
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --debug)
                DEBUG_MODE=true
                log_debug "Debug mode enabled"
                shift
            ;;
            --dry-run)
                DRY_RUN=true
                log_info "Dry run mode enabled"
                shift
            ;;
            --content)
                if [[ -n "$2" && "$2" != -* ]]; then
                    CONTENT_DIR="$2"
                    log_debug "Content directory set to: $CONTENT_DIR"
                    shift 2
                else
                    log_error "--content requires a directory path"
                    exit 1
                fi
            ;;
            -h|--help)
                show_help
                exit 0
            ;;
            *)
                log_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
            ;;
        esac
    done
    
    log_info "Starting Felo Dates Updater..."
    log_debug "Debug mode: $DEBUG_MODE"
    log_debug "Dry run mode: $DRY_RUN"
    log_debug "Content directory: $CONTENT_DIR"
    
    # Check dependencies
    if ! check_dependencies; then
        exit 1
    fi
    
    # Process all markdown files
    if ! process_all_markdown_files; then
        log_error "Processing failed"
        exit 1
    fi
    
    # Print final statistics
    print_statistics
    
    return 0
}

# Execute main function
main "$@"
