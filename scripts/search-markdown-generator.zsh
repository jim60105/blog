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
# Search Result Markdown Generator Library
# Utility functions for generating markdown files from various search result providers.
# This library provides markdown generation capabilities including AI metadata
# generation, reference processing, and file creation.
#
# This library is designed to be sourced by other scripts and provides:
# - AI-powered metadata generation (title, description, tags, filename)
# - Markdown file generation with proper front matter
# - Reference processing and footnote generation
# - Filename sanitization and safety checks
#
# Dependencies:
# - curl (for OpenAI API calls)
# - jq (for JSON processing)
# - date (for timestamp generation)

# OpenAI Configuration
readonly OPENAI_MODEL="gpt-4.1"

# Replace unwanted punctuation characters with ASCII equivalents to keep output consistent
normalize_punctuation() {
    local text="$1"

    text="${text//’/'}"
    text="${text//‘/'}"
    text="${text//“/\"}"
    text="${text//”/\"}"
    text="${text//–/-}"
    text="${text//—/-}"

    printf '%s' "$text"
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
    
    # Trim all leading and trailing whitespace and line breaks from answer parameter (zsh native)
    answer="${answer#"${answer%%[!$' \t\r\n']*}"}"
    answer="${answer%"${answer##*[!$' \t\r\n']}"}"
    
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
    "description": string, //Brief description summarizing the article, three sentences and 100~150 characters in 正體中文zh-tw
    "tags": string[], //Relevant keyword tags, max 5 tags, comma-separated, Capitalize, English or 正體中文
    "filename": string //SEO-friendly filename slug for the url, lowercase English and numbers with hyphens only
}
'''
Based on the following Q&A content, please provide:
1. An Title of this article. Please come up with an eye-catching but not overly exaggerated title. (in 正體中文zh-tw)
2. A Brief Description Summarizing This Article. Addresses a particular subject while withholding the primary conclusion. The description will be visible to readers before they click the link, thus it must be compelling enough to encourage them to click and delve into the full content of the article. (three sentences in 正體中文zh-tw, max 150 characters)
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

# Generate safe filename from question
generate_safe_filename() {
    local question="$1"
    local safe_filename
    
    safe_filename=$(echo "$question" | tr -cd '[:alnum:][:space:]' | sed 's/[[:space:]]\+/-/g' | head -c 50)
    if [[ -z "$safe_filename" ]]; then
        safe_filename="search-result"
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
        sanitized="search-result"
        log_debug "Filename too short or empty, using default: $sanitized"
        elif [[ ${#sanitized} -gt 50 ]]; then
        # Truncate to 50 characters and remove incomplete word at the end
        sanitized=$(echo "$sanitized" | head -c 50)
        # Remove trailing partial word if it ends with a hyphen or incomplete word
        sanitized=$(echo "$sanitized" | sed 's/-[^-]*$//' | sed 's/-$//')
        # Ensure we still have a valid filename after truncation
        if [[ -z "$sanitized" || ${#sanitized} -lt 3 ]]; then
            sanitized="search-result"
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
    local provider_name="$8"
    local assistant_speaker="$9"
    local creation_date="${10}"
    local with_ai_url="${11}"
    
    log_debug "Creating basic markdown content for multiple Q&A"
    local sanitized_ai_title
    local sanitized_ai_description
    local sanitized_ai_tags
    local sanitized_answers

    sanitized_ai_title=$(normalize_punctuation "$ai_title")
    sanitized_ai_description=$(normalize_punctuation "$ai_description")
    sanitized_ai_tags=$(normalize_punctuation "$ai_tags")
    sanitized_answers=$(normalize_punctuation "$answers")

    log_debug "AI title: '$sanitized_ai_title'"
    log_debug "AI description: '$sanitized_ai_description'"
    log_debug "AI tags: '$sanitized_ai_tags'"
    log_debug "Provider: '$provider_name'"
    log_debug "Assistant speaker: '$assistant_speaker'"

    # Format tags for TOML array
    local formatted_tags=""
    if [[ -n "$sanitized_ai_tags" ]]; then
        # Convert comma-separated tags to TOML array format
        formatted_tags=$(echo "$sanitized_ai_tags" | sed 's/,/, /g' | sed 's/^/[ "/' | sed 's/$/" ]/' | sed 's/, /", "/g')
        log_debug "Formatted tags: $formatted_tags"
    else
        formatted_tags="[ ]"
    fi
    
    # Get the first question for the initial chat block (all lines from first message)
    local first_question="$questions"
    
    # No need for complex filtering since we now return clean question text directly
    
    # Use answers directly
    local clean_answers="$sanitized_answers"

    cat > "$output_file" << EOFMD
+++
title = "$sanitized_ai_title"
description = "$sanitized_ai_description"
date = "$creation_date"
updated = "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
draft = false

[taxonomies]
tags = $formatted_tags
providers = [ "$provider_name" ]

[extra]
withAI = "<$with_ai_url>"
+++
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
    
    log_debug "Adding reference data to markdown file"
    
    local added_count=0
    local modern_ref_count
    modern_ref_count=$(jq '[.messages[]? | (.references // [])[]?] | length' "$json_file" 2>/dev/null || echo "0")
    
    if [[ "$modern_ref_count" -gt 0 ]]; then
        log_debug "Detected modern reference format with explicit citation metadata"
        typeset -A seen_refs
        while IFS=$'\t' read -r ref_num ref_title ref_url; do
            [[ -z "$ref_num" ]] && continue
            if ! grep -q "^${ref_num}$" "$used_refs_file" 2>/dev/null; then
                continue
            fi
            if [[ -n "${seen_refs[$ref_num]}" ]]; then
                continue
            fi
            if [[ -z "$ref_title" || "$ref_title" == "null" || -z "$ref_url" || "$ref_url" == "null" ]]; then
                log_warn "Reference $ref_num is missing title or url"
                continue
            fi
            ref_title=$(normalize_punctuation "$ref_title")
            echo "[^${ref_num}]: [$ref_title]($ref_url)" >> "$output_file"
            log_debug "Added reference $ref_num: $ref_title"
            seen_refs[$ref_num]=1
            ((added_count++))
            done < <(jq -r '
            .messages[]? as $msg |
            ($msg.references // [])[]? |
            select(.number != null) |
            [ (.number | tostring), (.title // ""), ((.url // .link) // "") ] | @tsv
        ' "$json_file")
    else
        log_debug "Falling back to legacy reference extraction"
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
                        ref_title=$(normalize_punctuation "$ref_title")
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
    fi
    
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
    local provider_name="${10}"
    local assistant_speaker="${11}"
    local creation_date="${12}"
    local with_ai_url="${13}"
    
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
        create_basic_markdown "$output_file" "$original_url" "$questions" "$fixed_answers" "$ai_title" "$ai_description" "$ai_tags" "$provider_name" "$assistant_speaker" "$creation_date" "$with_ai_url"
        
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
    local extracted_question="$2"
    local extracted_answer="$3"
    local extracted_json_file="$4"
    local extracted_ref_count="$5"
    local extracted_creation_date="$6"
    local provider_name="$7"
    local assistant_speaker="$8"
    local with_ai_url="$9"
    
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
        ai_response=$(call_openai_api "$extracted_question" "$extracted_answer")
        
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
    
    ai_title=$(normalize_punctuation "$ai_title")
    ai_description=$(normalize_punctuation "$ai_description")
    ai_tags=$(normalize_punctuation "$ai_tags")
    ai_filename=$(normalize_punctuation "$ai_filename")
    extracted_question=$(normalize_punctuation "$extracted_question")
    extracted_answer=$(normalize_punctuation "$extracted_answer")

    # Generate filename with AI-generated filename or fallback
    local safe_filename
    if [[ -n "$ai_filename" ]]; then
        log_info "Using AI-generated filename: $ai_filename"
        safe_filename=$(sanitize_filename "$ai_filename")
        log_debug "Sanitized AI filename: $safe_filename"
    else
        log_info "AI filename not available, using fallback method"
        safe_filename=$(generate_safe_filename "$extracted_question")
        log_debug "Fallback filename: $safe_filename"
    fi
    
    local output_file="${safe_filename}.md"
    log_info "Generating markdown file: $output_file"
    log_debug "Output file path: $output_file"
    
    # Create basic markdown content with AI metadata
    create_basic_markdown "$output_file" "$original_url" "$extracted_question" "$extracted_answer" "$ai_title" "$ai_description" "$ai_tags" "$provider_name" "$assistant_speaker" "$extracted_creation_date" "$with_ai_url"
    
    # Process and add references
    process_references "$output_file" "$original_url" "$extracted_question" "$extracted_answer" "$extracted_json_file" "$extracted_ref_count" "$ai_title" "$ai_description" "$ai_tags" "$provider_name" "$assistant_speaker" "$extracted_creation_date" "$with_ai_url"
    
    log_success "Markdown file generated successfully!"
    
    # Final summary
    log_success "Processing completed successfully!"
    log_info "Output file: $output_file"
    log_info "Question: $extracted_question"
    log_info "References: $extracted_ref_count found"
    if [[ -n "$ai_title" ]]; then
        log_info "AI-generated title: $ai_title"
    fi
    if [[ -n "$ai_filename" ]]; then
        log_info "AI-generated filename: $ai_filename (sanitized: $safe_filename)"
    fi
    
    # Clean up JSON file
    # DEBUG: Keep JSON file for debugging - don't clean up
    if [[ "$DEBUG_MODE" != "true" ]]; then
        [[ -n "$extracted_json_file" && -f "$extracted_json_file" ]] && rm -f "$extracted_json_file"
    else
        log_debug "JSON file preserved for debugging: $extracted_json_file"
    fi
    
    return 0
}
