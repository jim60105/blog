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

# Global variables
DEBUG_MODE=false

# OpenAI Configuration
readonly OPENAI_MODEL="moonshotai/kimi-k2"

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

# Check OpenAI environment variables
check_openai_config() {
    log_debug "Checking OpenAI configuration..."
    
    if [[ -z "$OPENAI_BASE_URL" ]]; then
        log_warn "OPENAI_BASE_URL environment variable is not set"
        log_warn "AI-generated title, description, and tags will be skipped"
        return 1
    fi
    
    if [[ -z "$OPENAI_API_KEY" ]]; then
        log_warn "OPENAI_API_KEY environment variable is not set"
        log_warn "AI-generated title, description, and tags will be skipped"
        return 1
    fi
    
    log_debug "OpenAI configuration found:"
    log_debug "  Base URL: $OPENAI_BASE_URL"
    log_debug "  API Key: ${OPENAI_API_KEY:0:8}..."
    log_debug "  Model: $OPENAI_MODEL"
    
    return 0
}

# Call OpenAI API to generate title, description, and tags
call_openai_api() {
    local question="$1"
    local answer="$2"
    
    log_info "Calling OpenAI API to generate metadata..."
    log_debug "Question length: ${#question} characters"
    log_debug "Answer length: ${#answer} characters"
    
    # Create prompt for OpenAI
    local system_prompt=""
    local user_prompt=""
    read -r -d '' system_prompt << EOSYSTEMPROMPT
- Carefully consider the user's question to ensure your answer is logical and makes sense.
- Make sure your explanation is concise and easy to understand, not verbose.
- Strictly return the answer in json format.
- Strictly Ensure that the following answer is in a valid JSON format.
- The output should be formatted as a JSON instance that conforms to the JSON schema below and do not add comments.

Here is the output schema:
'''
{
    "thinking": string, //Your thought process, deep into the reasoning behind the answer, Tell me how you would answer and explain why
    "title": string, //Title of the article, should be concise and eye-catching in 正體中文zh-tw
    "description": string, //Brief description summarizing the article, max 150 characters in 正體中文zh-tw
    "tags": string[], //Relevant keyword tags, max 5 tags, comma-separated, Capitalize, English or 正體中文
    "filename": string //SEO-friendly filename slug for the url, lowercase English and numbers with hyphens only
}
'''
Based on the following Q&A content, please provide:
1. An Title of this article. Please come up with an eye-catching but not overly exaggerated title. (in 正體中文zh-tw)
2. A Brief Description Summarizing This Article. Addresses a particular subject while withholding the primary conclusion. The description will be visible to readers before they click the link, thus it must be compelling enough to encourage them to click and delve into the full content of the article. (in 正體中文zh-tw, max 150 characters)
3. Relevant keyword tags (in English, max 5 tags, comma-separated)
4. An SEO-friendly filename slug. Will be used in part of the url. (in English, lowercase letters, numbers, and hyphens only, 20-50 characters, describing the main topic)

Use full-width punctuation marks for Chinese, and use single-width punctuation marks for other languages.
Always put a whitespace between Chinese words and English words.
Your response will be used as meta tags for a webpage, so please follow good SEO practices.
EOSYSTEMPROMPT
    
    read -r -d '' user_prompt << EOUSERPROMPT
<Q&A_Content>
Question: $question

Answer: $answer
</Q&A_Content>

[Restriction]
- Strictly return the answer in json format.
- Strictly Ensure that the following answer is in a valid JSON format.
- The output should be formatted as a JSON instance that conforms to the JSON schema below and do not add comments.
EOUSERPROMPT
    
    # Create temporary file for API request
    local request_file=$(mktemp)
    local response_file=$(mktemp)
    
    # Prepare JSON payload (o4-mini doesn't support system role, use only user role)
    cat > "$request_file" << EOJSON
{
  "model": "$OPENAI_MODEL",
  "messages": [
    {
      "role": "system",
      "content": $(echo "$system_prompt" | jq -Rs .)
    },
    {
      "role": "user",
      "content": $(echo "$user_prompt" | jq -Rs .)
    }
  ],
  "temperature": 0.3,
  "max_tokens": 20000
}
EOJSON
    
    log_debug "API request payload created: $request_file"
    [[ "$DEBUG_MODE" == "true" ]] && echo "DEBUG: Request payload preview: $(head -c 200 "$request_file")..." >&2
    
    # Make API call
    local api_url="${OPENAI_BASE_URL%/}/chat/completions"
    log_debug "Making API call to: $api_url"
    
    if command -v curl >/dev/null 2>&1; then
        curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d @"$request_file" \
        -o "$response_file"
        local curl_exit_code=$?
        
        if [[ $curl_exit_code -ne 0 ]]; then
            log_error "OpenAI API call failed with curl exit code: $curl_exit_code"
            rm -f "$request_file" "$response_file"
            return 1
        fi
    else
        log_error "curl is required for OpenAI API calls"
        rm -f "$request_file" "$response_file"
        return 1
    fi
    
    # Check response
    local response_size=$(wc -c < "$response_file")
    log_debug "API response size: $response_size bytes"
    
    if [[ "$response_size" -lt 10 ]]; then
        log_error "API response too small or empty"
        rm -f "$request_file" "$response_file"
        return 1
    fi
    
    [[ "$DEBUG_MODE" == "true" ]] && echo "DEBUG: API response preview: $(head -c 200 "$response_file")..." >&2
    
    # Extract content from response
    local content
    content=$(jq -r '.choices[0].message.content // empty' "$response_file" 2>/dev/null)
    
    if [[ -z "$content" || "$content" == "null" || "$content" == "" ]]; then
        log_error "Could not extract content from OpenAI response"
        log_debug "Response file content: $(cat "$response_file")"
        
        # Check if it's a length issue
        local finish_reason=$(jq -r '.choices[0].finish_reason // empty' "$response_file" 2>/dev/null)
        if [[ "$finish_reason" == "length" ]]; then
            log_warn "OpenAI response was truncated due to token limit"
        fi
        
        rm -f "$request_file" "$response_file"
        return 1
    fi
    
    log_debug "Extracted content from API response: $content"
    
    # Clean up temporary files
    rm -f "$request_file" "$response_file"
    
    # Output the content for processing by caller
    echo "$content"
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
    
    # Create temporary file to store content
    local temp_file=$(mktemp)
    local user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    
    log_debug "Created temporary file: $temp_file"
    
    # Use curl first, fallback to wget
    if command -v curl >/dev/null 2>&1; then
        log_debug "Using curl to fetch API content"
        curl -s -L -A "$user_agent" "$api_url" -o "$temp_file"
        local curl_exit_code=$?
        log_debug "curl exit code: $curl_exit_code"
        
        if [[ $curl_exit_code -ne 0 ]]; then
            log_error "curl failed with exit code: $curl_exit_code"
            rm -f "$temp_file"
            return 1
        fi
        elif command -v wget >/dev/null 2>&1; then
        log_debug "Using wget to fetch API content"
        wget -q -U "$user_agent" "$api_url" -O "$temp_file" 2>/dev/null
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
            log_success "API content fetched successfully ($content_length bytes)"
            log_debug "Content preview (first 200 chars): $(head -c 200 "$temp_file")..."
            printf '%s' "$temp_file"
            return 0
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
        return 1
    fi
}

# Prompt user for URL
prompt_for_url() {
    log_info "Felo Search Parser"
    log_debug "Entering interactive mode for URL input"
    echo -e "\nPlease enter the Felo.ai search URL:"
    echo -e "Template: ${GRAY}https://felo.ai/search/mbHKVG9UzZisrxkaHHnSxU?invite=dOLYGeJyZJqVX${RESET}"
    echo -n "URL: "
    
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
    
    # Extract all answers and combine them with offset reference numbering
    local all_answers=""
    for ((i=0; i<questions_count; i++)); do
        # Use jq directly to avoid variable assignment in command substitution
        local query_text=$(jq -r ".messages[$i].query // empty" "$json_file" 2>/dev/null)
        local response_text=$(jq -r ".messages[$i].answer // empty" "$json_file" 2>/dev/null)
        
        # Clean up the question: remove any shell quoting artifacts and normalize whitespace
        query_text=$(echo "$query_text" | tr '\n' ' ')
        query_text=$(echo "$query_text" | sed 's/[[:space:]]\+/ /g' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        
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
            
            if [[ -n "$all_answers" ]]; then
                read -r -d '' all_answers_part << EOM

{% chat(speaker="jim") %}
$query_text
{% end %}

{% chat(speaker="felo") %}
根據搜尋結果，我將詳細分析相關問題。
{% end %}

$adjusted_answer
EOM
                all_answers="$all_answers$all_answers_part"
            else
                all_answers="$adjusted_answer"
            fi
        fi
    done
    
    if [[ -z "$all_answers" ]]; then
        all_answers="Answer content not available."
    fi
    
    exec 2>&4  # Restore stderr
    printf '%s\n' "$all_answers"
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
    
    # Basic URL validation
    if [[ ! "$url" =~ ^https://felo\.ai/search/ ]]; then
        log_error "Invalid URL format. Please provide a valid Felo.ai search URL."
        log_debug "URL validation failed for: $url"
        return 1
    fi
    
    log_debug "URL validation passed"
    
    # Extract thread ID from URL pattern: https://felo.ai/search/{threadId}?...
    local thread_id
    thread_id=$(echo "$url" | sed -E 's|^https://felo\.ai/search/([^?]+).*|\1|')
    
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
    generate_markdown_file "$original_url"
    
    return 0
}

# Generate safe filename from question
generate_safe_filename() {
    local question="$1"
    local safe_filename
    
    safe_filename=$(echo "$question" | tr -cd '[:alnum:][:space:]' | sed 's/[[:space:]]\+/-/g' | head -c 50)
    if [[ -z "$safe_filename" ]]; then
        safe_filename="felo-search-result"
    fi
    
    log_debug "Safe filename generated: $safe_filename"
    echo "$safe_filename"
}

# Sanitize filename to ensure it only contains safe characters
sanitize_filename() {
    local filename="$1"
    local sanitized
    
    log_debug "Sanitizing filename: $filename"
    
    # Remove any path separators and dots
    sanitized=$(echo "$filename" | sed 's/[\/\.]//g')
    
    # Convert to lowercase
    sanitized=$(echo "$sanitized" | tr '[:upper:]' '[:lower:]')
    
    # Keep only alphanumeric characters and hyphens
    sanitized=$(echo "$sanitized" | tr -cd '[:alnum:]-')
    
    # Replace multiple consecutive hyphens with single hyphen
    sanitized=$(echo "$sanitized" | sed 's/-\+/-/g')
    
    # Remove leading and trailing hyphens
    sanitized=$(echo "$sanitized" | sed 's/^-\+//;s/-\+$//')
    
    # Ensure filename is not empty and has reasonable length
    if [[ -z "$sanitized" || ${#sanitized} -lt 3 ]]; then
        sanitized="felo-search-result"
        log_debug "Filename too short or empty, using default: $sanitized"
        elif [[ ${#sanitized} -gt 50 ]]; then
        # Truncate to 50 characters and remove incomplete word at the end
        sanitized=$(echo "$sanitized" | head -c 50)
        # Remove trailing partial word if it ends with a hyphen or incomplete word
        sanitized=$(echo "$sanitized" | sed 's/-[^-]*$//' | sed 's/-$//')
        # Ensure we still have a valid filename after truncation
        if [[ -z "$sanitized" || ${#sanitized} -lt 3 ]]; then
            sanitized="felo-search-result"
        fi
        log_debug "Filename too long, truncated to: $sanitized"
    fi
    
    log_debug "Sanitized filename: $sanitized"
    echo "$sanitized"
}

# Create basic markdown content for multiple Q&A
create_basic_markdown() {
    local output_file="$1"
    local original_url="$2"
    local questions="$3"
    local answers="$4"
    local ai_title="$5"
    local ai_description="$6"
    local ai_tags="$7"
    
    log_debug "Creating basic markdown content for multiple Q&A"
    log_debug "AI title: '$ai_title'"
    log_debug "AI description: '$ai_description'"
    log_debug "AI tags: '$ai_tags'"
    
    # Format tags for TOML array
    local formatted_tags=""
    if [[ -n "$ai_tags" ]]; then
        # Convert comma-separated tags to TOML array format
        formatted_tags=$(echo "$ai_tags" | sed 's/,/, /g' | sed 's/^/[ "/' | sed 's/$/" ]/' | sed 's/, /", "/g')
        log_debug "Formatted tags: $formatted_tags"
    else
        formatted_tags="[ ]"
    fi
    
    # Get the first question for the initial chat block (all lines from first message)
    local first_question="$questions"
    
    # No need for complex filtering since we now return clean question text directly
    
    # Use answers directly
    local clean_answers="$answers"
    
    cat > "$output_file" << EOFMD
+++
title = "$ai_title"
description = "$ai_description"
date = "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
updated = "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
draft = false

[taxonomies]
tags = $formatted_tags
providers = [ "Felo Search" ]
licenses = [ "GFDL 1.3" ]

[extra]
withAI = "<$original_url>"
+++
{% chat(speaker="jim") %}
$first_question
{% end %}

{% chat(speaker="felo") %}
根據搜尋結果，我將詳細分析相關問題。
{% end %}

$clean_answers

EOFMD
    
    log_debug "Basic markdown content written for multiple Q&A"
}

# Extract used reference numbers from answer
extract_used_references() {
    local answer="$1"
    local used_refs_file="$2"
    
    log_debug "Extracting used reference numbers from answer (supports offset numbering)"
    
    # Extract reference numbers used in the answer content (including offset numbers like 1001, 2001, etc.)
    # Look for patterns like [1], [2], [1001], [2001], etc. in the answer
    # Use -a flag to force text processing and avoid binary file issues
    echo "$answer" | grep -ao '\[[0-9]\+\]' | sed 's/\[\([0-9]\+\)\]/\1/' | sort -un > "$used_refs_file"
    
    local used_count=$(wc -l < "$used_refs_file")
    log_debug "Found $used_count used references in content (supports offset numbering)"
    
    echo "$used_count"
}

# Fix reference format in answer content (supports offset numbering)
fix_reference_format() {
    local answer="$1"
    local used_refs_file="$2"
    
    log_debug "Fixing reference format in answer content (supports offset numbering)"
    
    local fixed_answer="$answer"
    while read -r ref_num; do
        if [[ -n "$ref_num" ]]; then
            fixed_answer=$(echo "$fixed_answer" | sed "s/\[${ref_num}\]/[^${ref_num}]/g")
            log_debug "Fixed reference format: [$ref_num] -> [^$ref_num] (supports offset numbering)"
        fi
    done < "$used_refs_file"
    
    echo "$fixed_answer"
}

# Add reference data to markdown file from all messages with offset numbering
add_reference_data() {
    local output_file="$1"
    local used_refs_file="$2"
    local json_file="$3"
    
    log_debug "Adding reference data to markdown file from all messages with offset numbering"
    
    echo "" >> "$output_file"
    
    local added_count=0
    local questions_count
    questions_count=$(jq '.messages | length' "$json_file" 2>/dev/null || echo "0")
    
    # Process references from all messages with offset numbering
    for ((i=0; i<questions_count; i++)); do
        local msg_ref_count
        msg_ref_count=$(jq ".messages[$i].recall_contexts | length" "$json_file" 2>/dev/null || echo "0")
        local offset=$((i * 1000))  # Offset for this message
        
        for ((j=0; j<msg_ref_count; j++)); do
            local original_ref_num=$((j + 1))  # Original reference number (1-based)
            local offset_ref_num=$((original_ref_num + offset))  # Offset reference number
            
            # Check if this offset reference number is used
            if grep -q "^${offset_ref_num}$" "$used_refs_file" 2>/dev/null; then
                local ref_title=$(jq -r ".messages[$i].recall_contexts[$j].title // empty" "$json_file" 2>/dev/null)
                local ref_url=$(jq -r ".messages[$i].recall_contexts[$j].link // empty" "$json_file" 2>/dev/null)
                
                if [[ -n "$ref_title" && "$ref_title" != "null" && -n "$ref_url" && "$ref_url" != "null" ]]; then
                    echo "[^${offset_ref_num}]: [$ref_title]($ref_url)" >> "$output_file"
                    log_debug "Added reference $offset_ref_num: $ref_title (message $i, original ref $original_ref_num)"
                    ((added_count++))
                else
                    log_warn "Could not extract reference data for message $i, reference $j"
                fi
            fi
        done
        
        log_success "Added msg_ref_count=$msg_ref_count"
    done
    
    echo "$added_count"
}

# Process references and add them to markdown for multiple Q&A
process_references() {
    local output_file="$1"
    local original_url="$2"
    local questions="$3"
    local answers="$4"
    local json_file="$5"
    local ref_count="$6"
    local ai_title="$7"
    local ai_description="$8"
    local ai_tags="$9"
    
    if [[ "$ref_count" -le 0 ]]; then
        log_debug "No references to add"
        return 0
    fi
    
    log_info "Processing and fixing reference formats for multiple Q&A..."
    log_debug "Processing references from JSON file: $json_file"
    
    # Create temporary file to store used reference numbers
    local used_refs_file=$(mktemp)
    
    # Extract used references from all answers
    local used_count
    used_count=$(extract_used_references "$answers" "$used_refs_file")
    
    if [[ "$used_count" -gt 0 ]]; then
        # Fix reference format
        local fixed_answers
        fixed_answers=$(fix_reference_format "$answers" "$used_refs_file")
        
        # Recreate markdown file with fixed content
        create_basic_markdown "$output_file" "$original_url" "$questions" "$fixed_answers" "$ai_title" "$ai_description" "$ai_tags"
        
        # Add reference data
        local added_count
        added_count=$(add_reference_data "$output_file" "$used_refs_file" "$json_file")
        
        log_success "Added $added_count footnote references (only used ones)"
    else
        log_warn "No references found in content"
    fi
    
    # Clean up temporary file
    rm -f "$used_refs_file"
    
    return 0
}

# Generate markdown file from extracted data
generate_markdown_file() {
    local original_url="$1"
    
    log_debug "Starting markdown file generation"
    
    # Initialize default metadata
    local ai_title=""
    local ai_description=""
    local ai_tags=""
    local ai_filename=""
    
    # Try to get AI-generated metadata if OpenAI is configured
    if check_openai_config; then
        log_info "Generating AI metadata..."
        local ai_response
        ai_response=$(call_openai_api "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER")
        
        if [[ $? -eq 0 && -n "$ai_response" ]]; then
            log_debug "Successfully received AI response"
            
            # Parse JSON response
            ai_title=$(echo "$ai_response" | jq -r '.title // empty' 2>/dev/null)
            ai_description=$(echo "$ai_response" | jq -r '.description // empty' 2>/dev/null)
            ai_tags=$(echo "$ai_response" | jq -r '.tags[]? // empty' 2>/dev/null | tr '\n' ',' | sed 's/,$//')
            ai_filename=$(echo "$ai_response" | jq -r '.filename // empty' 2>/dev/null)
            
            log_debug "Extracted AI metadata:"
            log_debug "  Title: $ai_title"
            log_debug "  Description: $ai_description"
            log_debug "  Tags: $ai_tags"
            log_debug "  Filename: $ai_filename"
        else
            log_warn "Failed to get AI response, using default metadata"
        fi
    else
        log_info "OpenAI not configured, using default metadata"
    fi
    
    # Generate filename with AI-generated filename or fallback
    local safe_filename
    if [[ -n "$ai_filename" ]]; then
        log_info "Using AI-generated filename: $ai_filename"
        safe_filename=$(sanitize_filename "$ai_filename")
        log_debug "Sanitized AI filename: $safe_filename"
    else
        log_info "AI filename not available, using fallback method"
        safe_filename=$(generate_safe_filename "$EXTRACTED_QUESTION")
        log_debug "Fallback filename: $safe_filename"
    fi
    
    local output_file="${safe_filename}.md"
    log_info "Generating markdown file: $output_file"
    log_debug "Output file path: $output_file"
    
    # Create basic markdown content with AI metadata
    create_basic_markdown "$output_file" "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$ai_title" "$ai_description" "$ai_tags"
    
    # Process and add references
    process_references "$output_file" "$original_url" "$EXTRACTED_QUESTION" "$EXTRACTED_ANSWER" "$EXTRACTED_JSON_FILE" "$EXTRACTED_REF_COUNT" "$ai_title" "$ai_description" "$ai_tags"
    
    log_success "Markdown file generated successfully!"
    
    # Final summary
    log_success "Processing completed successfully!"
    log_info "Output file: $output_file"
    log_info "Question: $EXTRACTED_QUESTION"
    log_info "References: $EXTRACTED_REF_COUNT found"
    if [[ -n "$ai_title" ]]; then
        log_info "AI-generated title: $ai_title"
    fi
    if [[ -n "$ai_filename" ]]; then
        log_info "AI-generated filename: $ai_filename (sanitized: $safe_filename)"
    fi
    
    # Clean up JSON file
    # DEBUG: Keep JSON file for debugging - don't clean up
    if [[ "$DEBUG_MODE" != "true" ]]; then
        [[ -n "$EXTRACTED_JSON_FILE" && -f "$EXTRACTED_JSON_FILE" ]] && rm -f "$EXTRACTED_JSON_FILE"
    else
        log_debug "JSON file preserved for debugging: $EXTRACTED_JSON_FILE"
    fi
    
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
