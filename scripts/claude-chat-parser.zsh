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
# Claude Chat Snapshots Parser
# Parses Claude AI chat snapshots from share URLs and converts them to markdown format
# similar to the provided template file.
#
# This script uses search-markdown-generator.zsh as a library for markdown
# generation functionality including AI-powered metadata generation.
#
# Usage: ./claude-chat-parser.zsh [URL]
# The script will extract UUID from the URL and fetch data via API.
#
# Example URL: https://claude.ai/share/55718b5b-22de-4d58-96a3-f4718c9bea4a
# API will be called: https://claude.ai/api/chat_snapshots/55718b5b-22de-4d58-96a3-f4718c9bea4a
#
# Dependencies:
# - curl
# - jq
# - date
# - search-markdown-generator.zsh (library)
#
# CRITICAL IMPLEMENTATION NOTE for similar provider scripts:
# ========================================================
# When extracting data from JSON with jq in loops, AVOID this pattern:
#   local sender
#   sender=$(jq -r ".messages[$i].sender" "$file")
#   if [[ "$sender" == "value" ]]; then
#
# This can cause shell trace contamination where "sender=value" gets mixed
# into command substitution output, corrupting extracted content.
#
# ALWAYS use jq directly in conditionals instead:
#   if [[ "$(jq -r ".messages[$i].sender" "$file")" == "value" ]]; then
#
# This prevents variable assignment traces from contaminating function returns.
# See extract_questions() and extract_answers() for proper implementation examples.

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
    log_debug "Checking for required tools: curl, jq, date"
    
    local missing_tools=()
    
    if ! command -v curl >/dev/null 2>&1; then
        missing_tools+=("curl")
        log_debug "curl: NOT FOUND"
    else
        log_debug "curl: FOUND"
    fi
    
    for tool in jq date; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_tools+=("$tool")
            log_debug "$tool: NOT FOUND"
        else
            log_debug "$tool: FOUND"
        fi
    done
    
    # Check search-markdown-generator.zsh library
    if [[ ! -f "$SCRIPT_DIR/search-markdown-generator.zsh" ]]; then
        log_error "search-markdown-generator.zsh library not found"
        missing_tools+=("search-markdown-generator.zsh")
    fi
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        log_error "Please install the missing tools and try again."
        return 1
    fi
    
    log_success "All dependencies are available"
    log_debug "Dependencies check completed successfully"
    return 0
}

# Extract UUID from Claude chat share URL
extract_chat_uuid_from_url() {
    local url="$1"
    
    log_debug "extract_chat_uuid_from_url called with: $url"
    
    # Validate URL format: https://claude.ai/share/{uuid}
    if [[ ! "$url" =~ ^https://claude\.ai/share/ ]]; then
        log_error "Invalid Claude chat share URL format"
        log_error "Expected format: https://claude.ai/share/{uuid}"
        return 1
    fi
    
    # Extract UUID
    local chat_uuid
    chat_uuid=$(echo "$url" | sed -E 's|^https://claude\.ai/share/([^?]+).*|\1|')
    
    if [[ -z "$chat_uuid" || "$chat_uuid" == "$url" ]]; then
        log_error "Failed to extract UUID from URL"
        return 1
    fi
    
    # Validate UUID format (basic check)
    if [[ ! "$chat_uuid" =~ ^[a-f0-9-]{36}$ ]]; then
        log_error "Invalid UUID format: $chat_uuid"
        return 1
    fi
    
    log_debug "Extracted chat UUID: $chat_uuid"
    printf '%s' "$chat_uuid"
    return 0
}

# Fetch content from Claude API
fetch_api_content() {
    local chat_uuid="$1"
    
    log_info "Fetching chat snapshot from Claude API..."
    log_debug "Chat UUID: $chat_uuid"
    
    # Build API URL
    local api_url="https://claude.ai/api/chat_snapshots/${chat_uuid}"
    log_debug "API URL: $api_url"
    
    # Create temporary files
    local temp_file=$(mktemp)
    local temp_headers=$(mktemp)
    local user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    
    # Use curl to fetch content with comprehensive headers
    if command -v curl >/dev/null 2>&1; then
        curl -s -L \
            -H "User-Agent: $user_agent" \
            -H "Accept: application/json, text/plain, */*" \
            -H "Accept-Language: en-US,en;q=0.9" \
            -H "Accept-Encoding: gzip, deflate, br" \
            -H "DNT: 1" \
            -H "Connection: keep-alive" \
            -H "Upgrade-Insecure-Requests: 1" \
            -H "Sec-Fetch-Dest: empty" \
            -H "Sec-Fetch-Mode: cors" \
            -H "Sec-Fetch-Site: same-origin" \
            -H "Cache-Control: no-cache" \
            -H "Pragma: no-cache" \
            --compressed \
            -D "$temp_headers" \
            -o "$temp_file" \
            "$api_url"
        local curl_exit_code=$?
        
        if [[ $curl_exit_code -ne 0 ]]; then
            log_error "curl failed with exit code: $curl_exit_code"
            rm -f "$temp_file" "$temp_headers"
            return 1
        fi
    else
        log_error "curl is required but not found"
        return 1
    fi
    
    # Validate response
    if [[ ! -f "$temp_file" ]] || [[ ! -s "$temp_file" ]]; then
        log_error "API response is empty or file not created"
        rm -f "$temp_file" "$temp_headers"
        return 1
    fi
    
    local content_size=$(wc -c < "$temp_file")
    log_debug "API response size: $content_size bytes"
    
    # Check for Cloudflare challenge page
    if grep -q "Just a moment" "$temp_file" 2>/dev/null; then
        log_error "Cloudflare challenge detected. This API endpoint requires browser interaction."
        log_error "The Claude chat snapshot may not be publicly accessible via API, or requires authentication."
        log_error "Please ensure the chat snapshot is properly shared and publicly accessible."
        [[ "$DEBUG_MODE" == "true" ]] && head -n 10 "$temp_file" >&2
        rm -f "$temp_file" "$temp_headers"
        return 1
    fi
    
    # Check if valid JSON
    if ! jq empty "$temp_file" 2>/dev/null; then
        log_error "API response is not valid JSON"
        log_debug "Response may be HTML or other non-JSON content"
        [[ "$DEBUG_MODE" == "true" ]] && head -n 20 "$temp_file" >&2
        rm -f "$temp_file" "$temp_headers"
        return 1
    fi
    
    # Check if public share
    local is_public
    is_public=$(jq -r '.is_public // false' "$temp_file" 2>/dev/null)
    if [[ "$is_public" != "true" ]]; then
        log_error "Chat snapshot is not public or access denied"
        local error_detail=$(jq -r '.detail // empty' "$temp_file" 2>/dev/null)
        if [[ -n "$error_detail" && "$error_detail" != "null" ]]; then
            log_error "API error: $error_detail"
        fi
        rm -f "$temp_file" "$temp_headers"
        return 1
    fi
    
    log_success "Successfully fetched chat snapshot"
    rm -f "$temp_headers"
    
    # Return temp file path
    echo "$temp_file"
    return 0
}

# Extract questions from chat messages
# IMPORTANT: Avoid variable assignment contamination in command substitution!
# 
# BUG FIX NOTE: Previously used pattern like:
#   local sender
#   sender=$(jq -r ".chat_messages[$i].sender // empty" "$json_file" 2>/dev/null)
#   if [[ "$sender" == "human" ]]; then
# 
# This caused shell trace output "sender=human" to contaminate the function's
# return value through command substitution, resulting in markdown content like:
#   "sender=human\npython how to know..."
# 
# SOLUTION: Use jq directly in conditionals to avoid variable assignments:
#   if [[ "$(jq -r ".chat_messages[$i].sender // empty" "$json_file" 2>/dev/null)" == "human" ]]; then
#
# This pattern should be used in ALL similar provider implementations to prevent
# shell variable assignment trace contamination in command substitution contexts.
extract_questions() {
    local json_file="$1"
    
    log_debug "Extracting questions from chat messages"
    
    # Extract all human messages
    local questions=""
    local message_count
    message_count=$(jq '.chat_messages | length' "$json_file" 2>/dev/null || echo "0")
    
    for ((i=0; i<message_count; i++)); do
        if [[ "$(jq -r ".chat_messages[$i].sender // empty" "$json_file" 2>/dev/null)" == "human" ]]; then
            local message_text
            message_text=$(jq -r ".chat_messages[$i].text // empty" "$json_file" 2>/dev/null)
            
            if [[ -n "$message_text" && "$message_text" != "null" ]]; then
                if [[ -z "$questions" ]]; then
                    questions="$message_text"
                else
                    questions="$questions\n\n---\n\n$message_text"
                fi
            fi
        fi
    done
    
    if [[ -z "$questions" ]]; then
        # Use snapshot name as fallback
        questions=$(jq -r '.snapshot_name // "Claude Chat Conversation"' "$json_file" 2>/dev/null)
    fi
    
    echo "$questions"
}

# Extract answers from chat messages
# IMPORTANT: Same contamination fix as extract_questions() - see above comment
# Use jq directly in conditionals instead of variable assignments to prevent
# shell trace output from contaminating command substitution results.
extract_answers() {
    local json_file="$1"
    
    log_debug "Extracting answers from chat messages"
    
    # Extract all assistant messages
    local answers=""
    local message_count
    message_count=$(jq '.chat_messages | length' "$json_file" 2>/dev/null || echo "0")
    
    for ((i=0; i<message_count; i++)); do
        if [[ "$(jq -r ".chat_messages[$i].sender // empty" "$json_file" 2>/dev/null)" == "assistant" ]]; then
            local message_text
            message_text=$(jq -r ".chat_messages[$i].text // empty" "$json_file" 2>/dev/null)
            
            if [[ -n "$message_text" && "$message_text" != "null" ]]; then
                if [[ -z "$answers" ]]; then
                    answers="$message_text"
                else
                    answers="$answers\n\n$message_text"
                fi
            fi
        fi
    done
    
    if [[ -z "$answers" ]]; then
        answers="Answer content not available."
    fi
    
    echo "$answers"
}

# Extract creation date from chat snapshot
extract_creation_date() {
    local json_file="$1"
    
    log_debug "Extracting creation date from chat snapshot"
    
    # Use snapshot created_at first
    local snapshot_created_at
    snapshot_created_at=$(jq -r '.created_at // empty' "$json_file" 2>/dev/null)
    
    # Fallback to first message time if needed
    if [[ -z "$snapshot_created_at" || "$snapshot_created_at" == "null" ]]; then
        snapshot_created_at=$(jq -r '.chat_messages[0].created_at // empty' "$json_file" 2>/dev/null)
        log_debug "Using first message created_at: $snapshot_created_at"
    else
        log_debug "Using snapshot created_at: $snapshot_created_at"
    fi
    
    # Convert to Zola compatible format
    if [[ -n "$snapshot_created_at" && "$snapshot_created_at" != "null" ]]; then
        # Remove microseconds and ensure UTC format
        local formatted_date
        formatted_date=$(echo "$snapshot_created_at" | sed -E 's/\\.[0-9]+//' | sed 's/$/Z/' | sed 's/ZZ/Z/')
        
        # Validate and clean format
        if date -d "$formatted_date" >/dev/null 2>&1; then
            echo "$formatted_date"
        else
            # Fallback to current time
            log_warn "Invalid date format, using current time"
            date -u +"%Y-%m-%dT%H:%M:%SZ"
        fi
    else
        # Fallback to current time
        log_warn "No creation date found, using current time"
        date -u +"%Y-%m-%dT%H:%M:%SZ"
    fi
}

# Parse content from API response
parse_content() {
    local content_file="$1"
    local chat_uuid="$2"
    
    log_info "Parsing Claude chat content..."
    
    # Validate content file
    if [[ ! -f "$content_file" ]] || [[ ! -s "$content_file" ]]; then
        log_error "Content file is empty or does not exist"
        return 1
    fi
    
    # Create temp JSON file
    local json_file=$(mktemp)
    cp "$content_file" "$json_file"
    
    # Extract data
    EXTRACTED_QUESTION=$(extract_questions "$json_file")
    EXTRACTED_ANSWER=$(extract_answers "$json_file")
    EXTRACTED_REF_COUNT=0  # Claude chat snapshots typically don't include references
    EXTRACTED_CREATION_DATE=$(extract_creation_date "$json_file")
    EXTRACTED_JSON_FILE="$json_file"
    
    log_success "Content parsing completed"
    log_info "Questions extracted"
    log_info "Answer length: $(echo "$EXTRACTED_ANSWER" | wc -c) characters"
    log_info "Creation date: $EXTRACTED_CREATION_DATE"
    
    return 0
}

# Main content processing workflow
process_content_workflow() {
    local chat_uuid="$1"
    
    log_debug "Starting process_content_workflow with chat UUID: $chat_uuid"
    
    # Fetch API content
    local content_file
    content_file=$(fetch_api_content "$chat_uuid")
    local fetch_result=$?
    
    if [[ $fetch_result -ne 0 ]] || [[ ! -f "$content_file" ]]; then
        log_error "Failed to fetch chat content from API"
        return 1
    fi
    
    # Parse content
    if ! parse_content "$content_file" "$chat_uuid"; then
        log_error "Failed to parse chat content"
        rm -f "$content_file"
        return 1
    fi
    
    # Clean up temp file
    rm -f "$content_file"
    
    # Generate markdown file
    local original_url="https://claude.ai/share/${chat_uuid}"
    local provider_name="Claude"
    local assistant_speaker="claude"
    local with_ai_url="$original_url"
    
    generate_markdown_file "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$EXTRACTED_CREATION_DATE" "$provider_name" "$assistant_speaker" "$with_ai_url"
    
    return 0
}

# Test content processing workflow using mock data
test_content_workflow() {
    local chat_uuid="$1"
    
    log_debug "Starting test_content_workflow with chat UUID: $chat_uuid"
    
    # Use mock data file
    local content_file="/tmp/test-claude-response.json"
    
    if [[ ! -f "$content_file" ]]; then
        log_error "Test data file not found: $content_file"
        return 1
    fi
    
    # Parse content
    if ! parse_content "$content_file" "$chat_uuid"; then
        log_error "Failed to parse test chat content"
        return 1
    fi
    
    # Generate markdown file
    local original_url="https://claude.ai/share/${chat_uuid}"
    local provider_name="Claude"
    local assistant_speaker="claude"
    local with_ai_url="$original_url"
    
    generate_markdown_file "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$EXTRACTED_CREATION_DATE" "$provider_name" "$assistant_speaker" "$with_ai_url"
    
    return 0
}

# Prompt user for URL input
prompt_for_url() {
    log_info "Claude Chat Snapshots Parser"
    echo -e "\\nPlease enter the Claude chat share URL:" >&2
    echo -e "Template: ${GRAY}https://claude.ai/share/{uuid}${RESET}" >&2
    echo -n "URL: " >&2
    
    local url
    read -r url
    
    if [[ -z "$url" ]]; then
        log_error "No URL provided"
        return 1
    fi
    
    local chat_uuid
    chat_uuid=$(extract_chat_uuid_from_url "$url")
    if [[ $? -eq 0 ]]; then
        echo "$chat_uuid"
        return 0
    else
        return 1
    fi
}

# Get chat UUID from argument or prompt
get_chat_uuid() {
    local url_arg="$1"
    
    if [[ -n "$url_arg" ]]; then
        extract_chat_uuid_from_url "$url_arg"
    else
        prompt_for_url
    fi
}

# Main function
main() {
    # Process command line arguments
    local url_arg=""
    local test_mode=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --debug)
                DEBUG_MODE=true
                log_debug "Debug mode enabled"
                shift
                ;;
            --test)
                test_mode=true
                log_debug "Test mode enabled - using mock data"
                shift
                ;;
            https://claude.ai/share/*)
                url_arg="$1"
                log_debug "URL argument found: $url_arg"
                shift
                ;;
            -h|--help)
                echo "Usage: $0 [--debug] [--test] [URL]"
                echo "  URL: Claude chat share URL (https://claude.ai/share/{uuid})"
                echo "  --debug: Enable debug output"
                echo "  --test: Use mock data for testing"
                echo "  --help: Show this help message"
                exit 0
                ;;
            *)
                log_error "Unknown argument: $1"
                exit 1
                ;;
        esac
    done
    
    # Check dependencies
    if ! check_dependencies; then
        log_error "Missing required dependencies"
        exit 1
    fi
    
    # Get chat UUID
    local chat_uuid
    if [[ "$test_mode" == "true" ]]; then
        # Use test UUID for mock data
        chat_uuid="55718b5b-22de-4d58-96a3-f4718c9bea4a"
        log_info "Using test mode with UUID: $chat_uuid"
    else
        chat_uuid=$(get_chat_uuid "$url_arg")
        if [[ $? -ne 0 ]]; then
            log_error "Failed to get valid chat UUID"
            exit 1
        fi
    fi
    
    # Execute main workflow
    if [[ "$test_mode" == "true" ]]; then
        # Test workflow with mock data
        if test_content_workflow "$chat_uuid"; then
            log_success "Claude chat parsing test completed successfully!"
        else
            log_error "Claude chat parsing test failed"
            exit 1
        fi
    else
        if process_content_workflow "$chat_uuid"; then
            log_success "Claude chat parsing completed successfully!"
        else
            log_error "Claude chat parsing failed"
            exit 1
        fi
    fi
}

# Execute main function with early help handling - only if run directly, not sourced
# This detects if the script is being run directly vs sourced
if [[ "$0" == */claude-chat-parser.zsh ]]; then
    # Check for help flag first
    for arg in "$@"; do
        case "$arg" in
            -h|--help)
                echo "Usage: claude-chat-parser.zsh [OPTIONS] [URL]"
                echo "Options:"
                echo "  --debug    Enable debug logging"
                echo "  --test     Use mock data for testing"
                echo "  -h, --help Show this help message"
                echo ""
                echo "If URL is not provided, the script will prompt for input."
                echo ""
                echo "Example:"
                echo "  claude-chat-parser.zsh https://claude.ai/share/55718b5b-22de-4d58-96a3-f4718c9bea4a"
                echo "  claude-chat-parser.zsh --debug https://claude.ai/share/55718b5b-22de-4d58-96a3-f4718c9bea4a"
                echo "  claude-chat-parser.zsh --test  # Test with mock data"
                exit 0
            ;;
        esac
    done

    main "$@"
fi