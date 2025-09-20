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
# ChatGPT Conversation Parser
# Parses ChatGPT conversation from share URLs and converts them to markdown format
# similar to the provided template file.
#
# This script uses search-markdown-generator.zsh as a library for markdown
# generation functionality including AI-powered metadata generation.
#
# Usage: ./chatgpt-parser.zsh [URL]
# The script will extract share ID from the URL and fetch data from HTML.
#
# Example URL: https://chatgpt.com/share/68ce7802-f13c-8005-99de-7e232493e0d0
# Data is embedded in HTML via streamController.enqueue() calls.
#
# Dependencies:
# - curl
# - jq
# - grep, sed
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
    log_debug "Checking for required tools: curl, jq, grep, sed"
    
    local missing_tools=()
    
    for tool in curl jq grep sed; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_tools+=("$tool")
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

# Extract share ID from ChatGPT URL
extract_share_id_from_url() {
    local url="$1"
    
    log_debug "Extracting share ID from URL: $url"
    
    # Validate URL format
    if [[ ! "$url" =~ ^https://chatgpt\.com/share/[a-f0-9\-]+$ ]]; then
        log_error "Invalid ChatGPT share URL format"
        log_error "Expected format: https://chatgpt.com/share/{share_id}"
        return 1
    fi
    
    # Extract share ID using parameter expansion
    local share_id="${url##*/}"
    log_debug "Extracted share ID: $share_id"
    echo "$share_id"
    return 0
}

# Fetch HTML content from ChatGPT
fetch_html_content() {
    local url="$1"
    local temp_file="$2"
    
    log_info "Fetching ChatGPT conversation..."
    log_debug "Fetching HTML from: $url"
    
    # Use curl with proper headers to fetch the HTML
    local user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    
    if ! curl -s -L \
        -H "User-Agent: $user_agent" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" \
        -H "Accept-Language: en-US,en;q=0.5" \
        -H "Accept-Encoding: gzip, deflate, br" \
        -H "DNT: 1" \
        -H "Connection: keep-alive" \
        -H "Upgrade-Insecure-Requests: 1" \
        "$url" -o "$temp_file"; then
        log_error "Failed to fetch ChatGPT conversation"
        return 1
    fi
    
    # Check if the response contains conversation data
    if ! grep -q "streamController\.enqueue" "$temp_file"; then
        log_error "No conversation data found in response"
        log_error "This might be a private conversation or the URL is invalid"
        return 1
    fi
    
    # Additional check for content length
    local file_size=$(wc -c < "$temp_file")
    if [[ $file_size -lt 1000 ]]; then
        log_error "Response too small (${file_size} bytes), likely an error page"
        return 1
    fi
    
    log_success "Successfully fetched conversation data"
    return 0
}

# Extract JSON data from HTML
extract_json_from_html() {
    local html_file="$1"
    local json_file="$2"
    
    log_info "Extracting conversation data from HTML..."
    log_debug "Processing HTML file: $html_file"
    
    # Extract all streamController.enqueue calls and combine the JSON strings
    # These calls contain the serialized conversation data
    grep -o "window\.__reactRouterContext\.streamController\.enqueue([^)]*)" "$html_file" | \
    sed -E 's/window\.__reactRouterContext\.streamController\.enqueue\(//' | \
    sed -E 's/\)$//' | \
    # Combine all JSON chunks into a single array
    jq -s '.' > "$json_file" 2>/dev/null
    
    if [[ ! -s "$json_file" ]]; then
        log_error "Failed to extract JSON data from HTML"
        return 1
    fi
    
    log_success "Successfully extracted JSON data"
    return 0
}

# Parse conversation data from JSON
parse_conversation_data() {
    local json_file="$1"
    
    log_info "Parsing conversation data..."
    log_debug "Processing JSON file: $json_file"
    
    # The JSON structure is complex with reference-based serialization
    # We need to find the main conversation object containing title, create_time, mapping, etc.
    local conversation_data
    
    # First try to see if the JSON is directly the conversation object
    conversation_data=$(jq -r '
        if type == "object" and has("title") and has("create_time") and has("mapping") then
            {
                title: .title,
                create_time: .create_time,
                update_time: .update_time,
                mapping: .mapping
            }
        else empty end
    ' "$json_file" 2>/dev/null)
    
    # If not found, try looking in arrays or nested structures
    if [[ -z "$conversation_data" || "$conversation_data" == "null" ]]; then
        conversation_data=$(jq -r '
            # Flatten all arrays and find objects with conversation-like structure
            .[] | if type == "array" then .[] else . end |
            if type == "object" and has("title") and has("create_time") and has("mapping") then
                {
                    title: .title,
                    create_time: .create_time,
                    update_time: .update_time,
                    mapping: .mapping
                }
            else empty end
        ' "$json_file" 2>/dev/null | head -1)
    fi
    
    if [[ -z "$conversation_data" || "$conversation_data" == "null" ]]; then
        log_error "Could not find conversation data in JSON"
        return 1
    fi
    
    log_success "Successfully parsed conversation data"
    echo "$conversation_data"
    return 0
}

# Extract messages from conversation mapping
extract_messages() {
    local conversation_data="$1"
    
    log_debug "Extracting messages from conversation mapping"
    
    # Extract messages from the mapping structure
    # The mapping contains message IDs as keys and message objects as values
    echo "$conversation_data" | jq -r '
        .mapping | to_entries | 
        # Filter for actual messages (not empty objects)
        map(select(.value | has("message"))) |
        # Extract message details
        map({
            id: .key,
            role: .value.message.author.role,
            content: (.value.message.content.parts // []) | join(""),
            create_time: .value.message.create_time,
            parent: .value.parent
        }) |
        # Sort by create_time to get chronological order
        sort_by(.create_time) |
        # Filter out system messages and empty content
        map(select(.role != "system" and (.content | length > 0)))
    '
}

# Format timestamp
format_timestamp() {
    local timestamp="$1"
    
    log_debug "Formatting timestamp: $timestamp"
    
    # Convert Unix timestamp to readable format
    if command -v gdate >/dev/null 2>&1; then
        gdate -d "@$timestamp" '+%Y-%m-%d %H:%M:%S UTC'
    else
        date -d "@$timestamp" '+%Y-%m-%d %H:%M:%S UTC' 2>/dev/null || \
        date -r "$timestamp" '+%Y-%m-%d %H:%M:%S UTC' 2>/dev/null || \
        echo "$timestamp"
    fi
}

# Extract questions from conversation data
extract_questions() {
    local json_file="$1"
    
    log_debug "Extracting questions from conversation data"
    
    # Parse conversation data and get the first user message
    local conversation_data
    conversation_data=$(parse_conversation_data "$json_file")
    
    if [[ -z "$conversation_data" ]]; then
        echo "ChatGPT Conversation"
        return
    fi
    
    local messages
    messages=$(extract_messages "$conversation_data")
    
    # Get the first user message as the main question
    echo "$messages" | jq -r '
        .[] | select(.role == "user") | .content
    ' | head -1 || echo "ChatGPT Conversation"
}

# Extract answers from conversation data
extract_answers() {
    local json_file="$1"
    
    log_debug "Extracting answers from conversation data"
    
    # Parse conversation data
    local conversation_data
    conversation_data=$(parse_conversation_data "$json_file")
    
    if [[ -z "$conversation_data" ]]; then
        echo "Answer content not available."
        return
    fi
    
    local messages
    messages=$(extract_messages "$conversation_data")
    
    # Generate chat blocks for all messages
    local all_answers=""
    local temp_result=$(mktemp)
    
    echo "$messages" | jq -c '.[]' | while IFS= read -r message; do
        local role=$(echo "$message" | jq -r '.role')
        local content=$(echo "$message" | jq -r '.content')
        local create_time=$(echo "$message" | jq -r '.create_time')
        
        if [[ -n "$content" && "$content" != "null" ]]; then
            local formatted_time=""
            if [[ -n "$create_time" && "$create_time" != "null" ]]; then
                formatted_time=$(format_timestamp "${create_time%.*}")  # Remove decimal part
            fi
            
            local speaker=""
            if [[ "$role" == "user" ]]; then
                speaker="user"
            elif [[ "$role" == "assistant" ]]; then
                speaker="chatgpt"
            else
                continue
            fi
            
            # Add message with chat block format
            local chat_block="{% chat(speaker=\"$speaker\") %}${formatted_time:+ ($formatted_time)}
$content
{% end %}"
            
            # Append to temp file to avoid subshell variable issues
            if [[ -s "$temp_result" ]]; then
                echo "" >> "$temp_result"
                echo "" >> "$temp_result"
            fi
            echo "$chat_block" >> "$temp_result"
        fi
    done
    
    if [[ -s "$temp_result" ]]; then
        cat "$temp_result"
    else
        echo "Answer content not available."
    fi
    
    rm -f "$temp_result"
}

# Extract creation date from conversation data
extract_creation_date() {
    local json_file="$1"
    
    log_debug "Extracting creation date from conversation data"
    
    # Parse conversation data
    local conversation_data
    conversation_data=$(parse_conversation_data "$json_file")
    
    if [[ -z "$conversation_data" ]]; then
        # Fallback to current time
        log_warn "No conversation data found, using current time"
        date -u +"%Y-%m-%dT%H:%M:%SZ"
        return
    fi
    
    # Extract create_time from conversation data
    local create_time
    create_time=$(echo "$conversation_data" | jq -r '.create_time // empty')
    
    # Convert to Zola compatible format
    if [[ -n "$create_time" && "$create_time" != "null" ]]; then
        # Convert Unix timestamp to ISO format
        local formatted_date
        if command -v gdate >/dev/null 2>&1; then
            formatted_date=$(gdate -d "@$create_time" -u +"%Y-%m-%dT%H:%M:%SZ")
        else
            formatted_date=$(date -d "@$create_time" -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || \
                           date -r "$create_time" -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null)
        fi
        
        if [[ -n "$formatted_date" ]]; then
            echo "$formatted_date"
        else
            # Fallback to current time
            log_warn "Invalid timestamp format, using current time"
            date -u +"%Y-%m-%dT%H:%M:%SZ"
        fi
    else
        # Fallback to current time
        log_warn "No creation date found, using current time"
        date -u +"%Y-%m-%dT%H:%M:%SZ"
    fi
}

# Parse content from HTML response
parse_content() {
    local content_file="$1"
    local share_id="$2"
    
    log_info "Parsing ChatGPT conversation content..."
    
    # Validate content file
    if [[ ! -f "$content_file" ]] || [[ ! -s "$content_file" ]]; then
        log_error "Content file is empty or does not exist"
        return 1
    fi
    
    # Create temp JSON file
    local json_file=$(mktemp)
    
    # Extract JSON from HTML
    if ! extract_json_from_html "$content_file" "$json_file"; then
        rm -f "$json_file"
        return 1
    fi
    
    # Extract data
    EXTRACTED_QUESTION=$(extract_questions "$json_file")
    EXTRACTED_ANSWER=$(extract_answers "$json_file")
    EXTRACTED_REF_COUNT=0  # ChatGPT conversations typically don't include references
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
    local share_id="$1"
    
    log_debug "Starting process_content_workflow with share ID: $share_id"
    
    # Construct URL
    local url="https://chatgpt.com/share/${share_id}"
    
    # Fetch HTML content
    local content_file=$(mktemp)
    if ! fetch_html_content "$url" "$content_file"; then
        log_error "Failed to fetch conversation content from URL"
        rm -f "$content_file"
        return 1
    fi
    
    # Parse content
    if ! parse_content "$content_file" "$share_id"; then
        log_error "Failed to parse conversation content"
        rm -f "$content_file"
        return 1
    fi
    
    # Clean up temp file
    rm -f "$content_file"
    
    # Generate markdown file
    local original_url="https://chatgpt.com/share/${share_id}"
    local provider_name="ChatGPT"
    local assistant_speaker="chatgpt"
    local with_ai_url="$original_url"
    
    generate_markdown_file "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$EXTRACTED_CREATION_DATE" "$provider_name" "$assistant_speaker" "$with_ai_url"
    
    return 0
}

# Test mode with mock data
run_test_mode() {
    log_info "Running in test mode with mock data"
    
    # Create mock JSON data that simulates ChatGPT conversation structure
    local test_json=$(mktemp)
    cat > "$test_json" << 'EOJSON'
{
  "title": "Ready 金屬卡介紹",
  "create_time": 1737530602,
  "update_time": 1737531688,
  "mapping": {
    "msg1": {
      "message": {
        "author": { "role": "user" },
        "content": { "parts": ["Introducing the Ready (formerly Argent) metal card and its relative Starknet ecosystem. How does Ready's metal card work, and what are the features that make it unique in the crypto debit card space?"] },
        "create_time": 1737530539
      },
      "parent": null
    },
    "msg2": {
      "message": {
        "author": { "role": "assistant" },
        "content": { "parts": ["為了更完整地協助你，請問你希望我針對哪些方面深入說明 Ready 金屬卡與 Starknet 生態系？我可以從以下角度來分析：\n\n## Ready 金屬卡的核心特色\n\n**技術架構**\n- 基於 Starknet Layer 2 解決方案運行\n- 採用零知識證明技術確保交易隱私與安全\n- 支援多種加密貨幣的即時兌換與支付\n\n**實用功能**\n- 全球 ATM 提款支援\n- 線上線下商家消費無縫體驗\n- 即時匯率轉換，無隱藏手續費\n- 完整的消費記錄與分析工具\n\n**獨特優勢**\n- 整合 DeFi 協議，可直接使用 DeFi 收益進行日常消費\n- 支援 Starknet 生態內的 dApp 互動\n- 提供流動性挖礦回饋機制\n\n請讓我知道你最感興趣的是哪個面向，我會提供更詳細的說明！"] },
        "create_time": 1737530539
      },
      "parent": "msg1"
    }
  }
}
EOJSON
    
    # Set up test data
    EXTRACTED_QUESTION=$(extract_questions "$test_json")
    EXTRACTED_ANSWER=$(extract_answers "$test_json")
    EXTRACTED_REF_COUNT=0
    EXTRACTED_CREATION_DATE=$(extract_creation_date "$test_json")
    EXTRACTED_JSON_FILE="$test_json"
    
    log_success "Test data prepared successfully"
    log_info "Question: $(echo "$EXTRACTED_QUESTION" | head -c 100)..."
    log_info "Answer length: $(echo "$EXTRACTED_ANSWER" | wc -c) characters"
    log_info "Creation date: $EXTRACTED_CREATION_DATE"
    
    # Generate markdown file
    local original_url="https://chatgpt.com/share/test-68ce7802-f13c-8005-99de-7e232493e0d0"
    local provider_name="ChatGPT"
    local assistant_speaker="chatgpt"
    local with_ai_url="$original_url"
    
    generate_markdown_file "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$EXTRACTED_CREATION_DATE" "$provider_name" "$assistant_speaker" "$with_ai_url"
    
    log_success "Test completed successfully!"
}
prompt_for_url() {
    log_info "ChatGPT Conversation Parser"
    echo -e "\nPlease enter the ChatGPT share URL:" >&2
    echo -e "Template: ${GRAY}https://chatgpt.com/share/{share_id}${RESET}" >&2
    echo -n "URL: " >&2
    
    local url
    read -r url
    
    if [[ -z "$url" ]]; then
        log_error "No URL provided"
        return 1
    fi
    
    local share_id
    share_id=$(extract_share_id_from_url "$url")
    if [[ $? -eq 0 ]]; then
        echo "$url"
        return 0
    else
        return 1
    fi
}

# Main function
main() {
    # Parse command line arguments first
    local url_arg=""
    local test_mode=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --debug)
                DEBUG_MODE=true
                log_debug "Debug mode enabled in main"
                shift
            ;;
            --test)
                test_mode=true
                log_debug "Test mode enabled"
                shift
            ;;
            https://*|http://*)
                url_arg="$1"
                log_debug "URL argument found: $url_arg"
                shift
            ;;
            -h|--help)
                echo "Usage: chatgpt-parser.zsh [OPTIONS] [URL]"
                echo "Options:"
                echo "  --debug    Enable debug logging"
                echo "  --test     Use test/mock mode"
                echo "  -h, --help Show this help message"
                echo ""
                echo "If URL is not provided, the script will prompt for input."
                echo ""
                echo "Example:"
                echo "  chatgpt-parser.zsh https://chatgpt.com/share/68ce7802-f13c-8005-99de-7e232493e0d0"
                echo "  chatgpt-parser.zsh --debug https://chatgpt.com/share/68ce7802-f13c-8005-99de-7e232493e0d0"
                echo "  chatgpt-parser.zsh --test  # Test with mock data"
                exit 0
            ;;
            *)
                log_error "Unknown option: $1"
                exit 1
            ;;
        esac
    done
    
    # Check dependencies
    if ! check_dependencies; then
        exit 1
    fi
    
    # Test mode for development
    if [[ "$test_mode" == "true" ]]; then
        run_test_mode
        exit 0
    fi
    
    # Get URL
    local url
    if [[ -n "$url_arg" ]]; then
        url="$url_arg"
        log_debug "Using URL from command line: $url"
    else
        url=$(prompt_for_url)
        if [[ $? -ne 0 ]] || [[ -z "$url" ]]; then
            log_error "Failed to get valid URL"
            exit 1
        fi
    fi
    
    # Extract share ID and process
    local share_id
    share_id=$(extract_share_id_from_url "$url")
    if [[ $? -ne 0 ]] || [[ -z "$share_id" ]]; then
        log_error "Failed to extract share ID from URL"
        exit 1
    fi
    
    log_info "Processing ChatGPT conversation: $share_id"
    
    # Process the conversation
    if process_content_workflow "$share_id"; then
        log_success "ChatGPT conversation parsed successfully!"
        exit 0
    else
        log_error "Failed to process ChatGPT conversation"
        exit 1
    fi
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi