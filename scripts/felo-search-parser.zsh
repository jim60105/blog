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
# Felo Search Parser
# Parses Felo.ai search result via API and converts them to markdown format
# similar to the provided template file.
#
# This script uses search-markdown-generator.zsh as a library for markdown
# generation functionality including AI-powered metadata generation.
#
# Usage: ./felo-search-parser.zsh [URL]
# The script will extract thread ID from the URL and fetch data via API.
#
# Example URL: https://felo.ai/search/mbHKVG9UzZisrxkaHHnSxU?invite=dOLYGeJyZJqVX
# API will be called: https://api.felo.ai/search/search/threads/mbHKVG9UzZisrxkaHHnSxU
#
# Dependencies:
# - curl or wget
# - rg (ripgrep)
# - jq
# - search-markdown-generator.zsh (library)

# Load markdown generator library
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/search-markdown-generator.zsh"

# Global variables
DEBUG_MODE=false

# Color codes for output
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly GRAY='\033[0;37m'
readonly RESET='\033[0m'

# Extracted data variables
EXTRACTED_QUESTION=""
EXTRACTED_ANSWER=""
EXTRACTED_REF_COUNT=0
EXTRACTED_JSON_FILE=""
EXTRACTED_CREATION_DATE=""

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
    log_debug "Checking for required tools: curl/wget, rg, jq"
    
    local missing_tools=()
    
    if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
        missing_tools+="curl or wget"
        log_debug "curl/wget: NOT FOUND"
    else
        log_debug "curl/wget: FOUND"
    fi
    
    for tool in rg jq; do
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

# Check for 403 permission error in API response
check_api_permission_error() {
    local content_file="$1"
    
    log_debug "Checking for API permission errors"
    
    # Check if the response contains permission error JSON
    if jq -e '.detail.can_read == false and .detail.read_permission == "PRIVATE"' "$content_file" >/dev/null 2>&1; then
        log_error "Access denied: The Felo search thread is private and cannot be accessed"
        log_error ""
        log_error "To fix this issue:"
        log_error "1. Go to the Felo search thread URL in your browser"
        log_error "2. Click the 'Share' button to make the thread public"
        log_error "3. Run this script again with the updated URL"
        log_error ""
        log_error "The thread must be publicly accessible for this script to work."
        return 1
    fi
    
    return 0
}

# Fetch content from API URL
fetch_api_content() {
    local thread_id="$1"
    
    log_info "Fetching content from API..."
    log_debug "Thread ID: $thread_id"
    
    # Create API URL
    local api_url="https://api.felo.ai/search/search/threads/${thread_id}"
    log_debug "API URL: $api_url"
    
    # Create temporary files to store content and HTTP status
    local temp_file=$(mktemp)
    local temp_headers=$(mktemp)
    local user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    
    log_debug "Created temporary file: $temp_file"
    log_debug "Created temporary headers file: $temp_headers"
    
    # Use curl first, fallback to wget
    if command -v curl >/dev/null 2>&1; then
        log_debug "Using curl to fetch API content"
        # Use curl to get both response body and HTTP status code
        local http_status
        http_status=$(curl -s -L -A "$user_agent" -w "%{http_code}" -D "$temp_headers" "$api_url" -o "$temp_file")
        local curl_exit_code=$?
        log_debug "curl exit code: $curl_exit_code"
        log_debug "HTTP status code: $http_status"
        
        if [[ $curl_exit_code -ne 0 ]]; then
            log_error "curl failed with exit code: $curl_exit_code"
            rm -f "$temp_file" "$temp_headers"
            return 1
        fi
        
        # Check for 403 Forbidden status
        if [[ "$http_status" == "403" ]]; then
            log_warn "Received HTTP 403 Forbidden, checking for permission error..."
            if check_api_permission_error "$temp_file"; then
                rm -f "$temp_file" "$temp_headers"
                return 1
            else
                rm -f "$temp_file" "$temp_headers"
                return 1
            fi
        fi
        
        # Check for other HTTP error status codes
        if [[ "$http_status" -lt 200 || "$http_status" -ge 400 ]]; then
            log_error "API request failed with HTTP status: $http_status"
            log_debug "Response content: $(cat "$temp_file")"
            rm -f "$temp_file" "$temp_headers"
            return 1
        fi
        
        elif command -v wget >/dev/null 2>&1; then
        log_debug "Using wget to fetch API content"
        wget -q -U "$user_agent" "$api_url" -O "$temp_file" -S 2>"$temp_headers"
        local wget_exit_code=$?
        log_debug "wget exit code: $wget_exit_code"
        
        if [[ $wget_exit_code -ne 0 ]]; then
            log_error "wget failed with exit code: $wget_exit_code"
            
            # Check if it's a 403 error with wget
            if grep -q "403" "$temp_headers" 2>/dev/null; then
                log_warn "Received HTTP 403 Forbidden, checking for permission error..."
                if check_api_permission_error "$temp_file"; then
                    rm -f "$temp_file" "$temp_headers"
                    return 1
                fi
            fi
            
            rm -f "$temp_file" "$temp_headers"
            return 1
        fi
    else
        log_error "Neither curl nor wget is available"
        rm -f "$temp_file" "$temp_headers"
        return 1
    fi
    
    # Check if file exists and has content
    if [[ -f "$temp_file" ]]; then
        local content_length=$(wc -c < "$temp_file")
        log_debug "Content length: $content_length bytes"
        
        # Clean up headers file
        rm -f "$temp_headers"
        
        if [[ "$content_length" -gt 50 ]]; then
            # Additional check: verify the response contains valid JSON structure
            if jq -e '.messages' "$temp_file" >/dev/null 2>&1; then
                log_success "API content fetched successfully ($content_length bytes)"
                log_debug "Content preview (first 200 chars): $(head -c 200 "$temp_file")..."
                printf '%s' "$temp_file"
                return 0
            else
                # If it's not valid thread data, check if it's a permission error
                if check_api_permission_error "$temp_file"; then
                    rm -f "$temp_file"
                    return 1
                else
                    log_error "API response does not contain valid thread data"
                    log_debug "Response content: $(cat "$temp_file")"
                    rm -f "$temp_file"
                    return 1
                fi
            fi
        else
            log_error "API response too short or empty"
            log_debug "File size: $content_length bytes"
            # Show the content for debugging
            log_debug "File content: $(cat "$temp_file")"
            rm -f "$temp_file"
            return 1
        fi
    else
        log_error "Failed to create temporary file or fetch content"
        rm -f "$temp_headers"
        return 1
    fi
}

# Prompt user for URL
prompt_for_url() {
    log_info "Felo Search Parser"
    log_debug "Entering interactive mode for URL input"
    echo -e "\nPlease enter the Felo.ai search URL:" >&2;
    echo -e "Template: ${GRAY}https://felo.ai/search/mbHKVG9UzZisrxkaHHnSxU${RESET}" >&2;
    echo -n "URL: " >&2;
    
    local url
    read -r url
    log_debug "URL entered by user: $url"
    
    if [[ -z "$url" ]]; then
        log_error "No URL provided"
        return 1
    fi
    
    local thread_id
    thread_id=$(extract_thread_id_from_url "$url")
    if [[ $? -eq 0 ]]; then
        echo "$url"
        return 0
    else
        return 1
    fi
}

# Extract JSON data from API response
extract_json_from_api() {
    local content_file="$1"
    local json_file="$2"
    
    log_debug "Extracting JSON from API response"
    
    # For API response, the entire content should be JSON
    cp "$content_file" "$json_file"
    
    local json_size=$(wc -c < "$json_file")
    log_debug "JSON size: $json_size bytes"
    
    if [[ "$json_size" -gt 100 ]]; then
        log_debug "JSON data copied successfully"
        [[ "$DEBUG_MODE" == "true" ]] && echo "DEBUG: JSON starts with: $(head -c 100 "$json_file")..." >&2
        return 0
    fi
    
    log_error "API response too small or invalid"
    return 1
}

# Extract all questions from JSON data
extract_questions() {
    # Force clean environment but keep stderr for debugging
    set +x +v +o xtrace +o verbose 2>/dev/null || true
    
    local json_file="$1"
    
    # Check if file exists and what it contains
    if [[ ! -f "$json_file" ]]; then
        echo "Error - JSON file not found"
        return
    fi
    
    # Check file size
    local file_size=$(wc -c < "$json_file")
    if [[ "$file_size" -lt 100 ]]; then
        echo "Error - JSON file too small ($file_size bytes)"
        return
    fi
    
    local questions_count
    questions_count=$(jq '.messages | length' "$json_file" 2>/dev/null || echo "0")
    
    if [[ "$questions_count" -eq 0 ]]; then
        echo "Felo Search Result"
        return
    fi
    
    # For create_basic_markdown, we only need the first message's query
    # Return it with all its lines preserved
    jq -r '.messages[0].query // empty' "$json_file" 2>/dev/null || echo "Felo Search Result"
}

# Extract all answers from JSON data with offset reference numbering
extract_answers() {
    # Force clean environment and redirect any potential debug output
    set +x +v +o xtrace +o verbose 2>/dev/null || true
    exec 4>&2  # Save stderr
    exec 2>/dev/null  # Redirect stderr to /dev/null
    
    local json_file="$1"
    
    local questions_count
    questions_count=$(jq '.messages | length' "$json_file" 2>/dev/null || echo "0")
    
    if [[ "$questions_count" -eq 0 ]]; then
        echo "Answer content not available."
        exec 2>&4  # Restore stderr
        return
    fi
    
    # Extract all messages and pair them correctly
    local all_answers=""
    
    # Process messages in index order to maintain conversation flow
    for ((i=0; i<questions_count; i++)); do
        # Use jq directly to avoid variable assignment in command substitution
        local query_text=$(jq -r ".messages[$i].query // empty" "$json_file" 2>/dev/null)
        local response_text=$(jq -r ".messages[$i].answer // empty" "$json_file" 2>/dev/null)
        
        # Clean up the question: remove any shell quoting artifacts and normalize whitespace
        query_text=$(echo "$query_text" | tr '\n' ' ')
        query_text=$(echo "$query_text" | sed 's/[[:space:]]\+/ /g' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        
        # Trim all leading and trailing whitespace and line breaks from response_text (zsh native)
        response_text="${response_text#"${response_text%%[!$' \t\r\n']*}"}"
        response_text="${response_text%"${response_text##*[!$' \t\r\n']}"}"
        
        if [[ -n "$query_text" && "$query_text" != "null" ]]; then
            # Add human message chat block
            local human_block="{% chat(speaker=\"jim\") %}\n$query_text\n{% end %}"
            if [[ -n "$all_answers" ]]; then
                all_answers="$all_answers\n\n$human_block"
            else
                all_answers="$human_block"
            fi
        fi
        
        if [[ -n "$response_text" && "$response_text" != "null" ]]; then
            # Apply reference number offset for this message (i * 1000)
            local offset=$((i * 1000))
            local adjusted_answer="$response_text"
            
            # Replace reference numbers [1], [2], etc. with [1001], [1002], etc. for message 1
            if [[ $i -gt 0 ]]; then
                # Use a temporary marker to avoid double replacement
                adjusted_answer=$(echo "$adjusted_answer" | sed -E "s/\[([0-9]+)\]/[TEMP_\1]/g")
                # Replace with offset numbers
                for ref_num in $(echo "$adjusted_answer" | grep -o 'TEMP_[0-9]\+' | sed 's/TEMP_//g' | sort -n | uniq); do
                    new_ref_num=$((ref_num + offset))
                    adjusted_answer=$(echo "$adjusted_answer" | sed "s/\[TEMP_${ref_num}\]/[$new_ref_num]/g")
                done
            fi
            
            # Add assistant message chat block
            local assistant_block="{% chat(speaker=\"felo\") %}\n$adjusted_answer\n{% end %}"
            if [[ -n "$all_answers" ]]; then
                all_answers="$all_answers\n\n$assistant_block"
            else
                all_answers="$assistant_block"
            fi
        fi
    done
    
    if [[ -z "$all_answers" ]]; then
        all_answers="Answer content not available."
    fi
    
    exec 2>&4  # Restore stderr
    printf "%b\n" "$all_answers"
}

# Extract total references count from JSON data
extract_references_count() {
    local json_file="$1"
    
    log_debug "Extracting total references count from JSON"
    [[ "$DEBUG_MODE" == "true" ]] && echo "DEBUG: Testing jq with references extraction using file..." >&2
    
    local total_ref_count=0
    local questions_count
    questions_count=$(jq '.messages | length' "$json_file" 2>/dev/null || echo "0")
    
    # Sum up references from all messages
    for ((i=0; i<questions_count; i++)); do
        # Avoid using local inside command substitution
        ref_count_temp=$(jq ".messages[$i].recall_contexts | length" "$json_file" 2>/dev/null || echo "0")
        total_ref_count=$((total_ref_count + ref_count_temp))
    done
    
    [[ "$DEBUG_MODE" == "true" ]] && echo "DEBUG: jq total references result count: $total_ref_count" >&2
    
    log_debug "Found $total_ref_count total references"
    printf '%d' "$total_ref_count"
}

# Validate content file
validate_content_file() {
    local content_file="$1"
    
    if [[ ! -f "$content_file" ]]; then
        log_error "Content file not found: $content_file"
        return 1
    fi
    
    local file_size=$(wc -c < "$content_file")
    log_debug "Content file size: $file_size bytes"
    
    if [[ "$file_size" -lt 100 ]]; then
        log_error "Content file too small: $file_size bytes"
        return 1
    fi
    
    return 0
}

# Extract creation date from JSON data with fallback
extract_creation_date() {
    local json_file="$1"
    
    log_debug "Extracting creation date from JSON file: $json_file"
    
    # Try to extract thread-level created_at first
    local thread_created_at
    thread_created_at=$(jq -r '.created_at // empty' "$json_file" 2>/dev/null)
    
    # If not available, try first message's created_at
    if [[ -z "$thread_created_at" || "$thread_created_at" == "null" ]]; then
        thread_created_at=$(jq -r '.messages[0].created_at // empty' "$json_file" 2>/dev/null)
        log_debug "Thread-level created_at not found, using first message created_at: $thread_created_at"
    else
        log_debug "Using thread-level created_at: $thread_created_at"
    fi
    
    # Convert ISO 8601 to Zola-compatible format
    if [[ -n "$thread_created_at" && "$thread_created_at" != "null" ]]; then
        # Handle both with/without timezone formats
        # Input: "2025-03-16T07:14:58.526096" or "2025-03-16T07:14:58.526096Z" or "2025-03-16T07:14:58.526096+08:00"
        # Output: "2025-03-16T07:14:58Z"
        
        # Extract date and time components, remove microseconds
        local formatted_date
        formatted_date=$(echo "$thread_created_at" | sed -E 's/(\.[0-9]+)?([+-][0-9]{2}:?[0-9]{2}|Z)?$//')
        
        # Handle timezone conversion
        if [[ "$thread_created_at" =~ [+-][0-9]{2}:?[0-9]{2}$ ]]; then
            # Convert to UTC using date command if timezone is specified
            formatted_date=$(date -u -d "$thread_created_at" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || echo "${formatted_date}Z")
            log_debug "Converted timezone to UTC: $formatted_date"
            elif [[ "$thread_created_at" =~ Z$ ]]; then
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
    else
        # Fallback to current time in UTC if extraction fails
        local fallback_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
        log_debug "Creation date extraction failed, using fallback: $fallback_date"
        echo "$fallback_date"
    fi
}

# Parse content to extract question, answer and references
parse_content() {
    local content_file="$1"
    local thread_id="$2"
    
    log_info "Parsing API content..."
    log_debug "Starting API content parsing process"
    log_debug "Content file: $content_file"
    log_debug "Thread ID: $thread_id"
    
    # Validate content file
    if ! validate_content_file "$content_file"; then
        return 1
    fi
    
    # Create temporary file for JSON data
    local json_file=$(mktemp)
    log_debug "Created temporary JSON file: $json_file"
    
    # Extract JSON from API response
    if ! extract_json_from_api "$content_file" "$json_file"; then
        rm -f "$json_file"
        return 1
    fi
    
    log_debug "Using file-based processing for JSON data"
    
    # Extract data components
    EXTRACTED_QUESTION=$(extract_questions "$json_file")
    EXTRACTED_ANSWER=$(extract_answers "$json_file")
    EXTRACTED_REF_COUNT=$(extract_references_count "$json_file")
    EXTRACTED_CREATION_DATE=$(extract_creation_date "$json_file")
    
    log_success "Content parsing completed"
    log_info "Questions extracted"
    log_info "Answer length: $(echo "$EXTRACTED_ANSWER" | wc -c) characters"
    log_debug "EXTRACTED_REF_COUNT value: '$EXTRACTED_REF_COUNT'"
    log_info "References: $EXTRACTED_REF_COUNT"
    
    # Store JSON file path for use in markdown generation
    EXTRACTED_JSON_FILE="$json_file"
    
    return 0
}

# Extract thread ID from URL and validate
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

# Get thread ID from arguments or user input
get_thread_id() {
    local url_arg="$1"
    
    log_debug "get_thread_id called with: '$url_arg'"
    
    if [[ -n "$url_arg" ]]; then
        log_debug "Using command line URL: $url_arg"
        local thread_id
        thread_id=$(extract_thread_id_from_url "$url_arg")
        local extract_result=$?
        log_debug "extract_thread_id_from_url returned: '$thread_id', exit code: $extract_result"
        if [[ $extract_result -eq 0 ]]; then
            printf '%s' "$thread_id"
            return 0
        else
            log_error "Thread ID extraction failed"
            return 1
        fi
    else
        log_debug "No URL argument provided, prompting user"
        local prompted_url
        prompted_url=$(prompt_for_url)
        local prompt_result=$?
        if [[ $prompt_result -eq 0 && -n "$prompted_url" ]]; then
            extract_thread_id_from_url "$prompted_url"
        else
            return 1
        fi
    fi
}

# Process content workflow
process_content_workflow() {
    local thread_id="$1"
    
    log_debug "Starting process_content_workflow with thread ID: $thread_id"
    log_debug "About to fetch API content for thread: $thread_id"
    
    # Fetch content from API - returns temporary file path
    local content_file
    content_file=$(fetch_api_content "$thread_id")
    local fetch_result=$?
    log_debug "fetch_api_content returned: $fetch_result"
    
    if [[ $fetch_result -ne 0 || ! -f "$content_file" ]]; then
        log_error "Could not fetch content from API"
        log_debug "fetch_api_content returned error, result code: $fetch_result"
        log_debug "content_file value: '$content_file'"
        return 1
    fi
    
    local content_size=$(wc -c < "$content_file")
    log_debug "Content fetched successfully, size: $content_size bytes"
    
    # Parse the content
    if ! parse_content "$content_file" "$thread_id"; then
        log_error "Could not parse content"
        rm -f "$content_file"
        return 1
    fi
    
    # Clean up temporary file
    rm -f "$content_file"
    
    # Generate markdown file (pass original URL format for metadata)
    local original_url="https://felo.ai/search/${thread_id}"
    local provider_name="Felo Search"
    local assistant_speaker="felo"
    local with_ai_url="${original_url}?invite=dOLYGeJyZJqVX"
    
    generate_markdown_file "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$EXTRACTED_CREATION_DATE" "$provider_name" "$assistant_speaker" "$with_ai_url"
    
    return 0
}

# Main function
main() {
    # Parse command line arguments first
    local url_arg=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --debug)
                DEBUG_MODE=true
                log_debug "Debug mode enabled in main"
                shift
            ;;
            https://*|http://*)
                url_arg="$1"
                log_debug "URL argument found: $url_arg"
                shift
            ;;
            -h|--help)
                # This is handled at script bottom, skip it here
                shift
            ;;
            *)
                log_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
            ;;
        esac
    done
    
    log_info "Starting Felo Search Parser..."
    log_debug "Debug mode: $DEBUG_MODE"
    log_debug "URL argument from parse_arguments: '$url_arg'"
    
    # Check dependencies
    if ! check_dependencies; then
        exit 1
    fi
    
    # Get thread ID from argument or user input
    log_debug "About to call get_thread_id with: '$url_arg'"
    local thread_id
    thread_id=$(get_thread_id "$url_arg")
    local get_thread_id_result=$?
    log_debug "get_thread_id returned: '$thread_id', exit code: $get_thread_id_result"
    if [[ $get_thread_id_result -ne 0 ]]; then
        log_error "Failed to get valid thread ID"
        exit 1
    fi
    if [[ -z "$thread_id" ]]; then
        log_error "get_thread_id returned empty thread ID"
        exit 1
    fi
    log_debug "Final thread ID to process: $thread_id"
    
    # Process content workflow
    log_debug "About to call process_content_workflow"
    if ! process_content_workflow "$thread_id"; then
        log_error "process_content_workflow failed"
        exit 1
    fi
    
    return 0
}

# Execute main function with early help handling
# Check for help flag first
for arg in "$@"; do
    case "$arg" in
        -h|--help)
            show_help() {
                local script_name="felo-search-parser.zsh"
                echo "Usage: $script_name [OPTIONS] [URL]"
                echo "Options:"
                echo "  --debug    Enable debug logging"
                echo "  -h, --help Show this help message"
                echo ""
                echo "If URL is not provided, the script will prompt for input."
                echo ""
                echo "Example:"
                echo "  $script_name https://felo.ai/search/oCKPWwPo8n5kEgrXo9j3X9"
                echo "  $script_name --debug https://felo.ai/search/oCKPWwPo8n5kEgrXo9j3X9"
            }
            show_help
            exit 0
        ;;
    esac
done

main "$@"
