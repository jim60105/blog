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
# - python3
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
    log_debug "Checking for required tools: curl, jq, grep, sed, python3"
    
    local missing_tools=()
    
    for tool in curl jq grep sed python3; do
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
    
    if ! curl -s -L --compressed \
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
    local python_debug="false"
    if [[ "$DEBUG_MODE" == "true" ]]; then
        local preview="$(head -c 120 "$html_file" | tr '\n' ' ')"
        log_debug "HTML preview: ${preview}"
        cp "$html_file" /tmp/chatgpt-parser-debug.html 2>/dev/null || true
        python_debug="true"
    fi
    
    if ! CHATGPT_PARSER_DEBUG="$python_debug" python3 - <<'PY' "$html_file" "$json_file"; then
import json
import re
import sys
import unicodedata
from functools import lru_cache
from pathlib import Path
import os

def clean_text(text):
    """Clean corrupted UTF-8 characters and normalize text"""
    if not text:
        return ""
    
    # Remove control characters except newlines and tabs
    text = ''.join(ch for ch in text if unicodedata.category(ch)[0] != 'C' or ch in '\n\t\r')
    
    # Fix common UTF-8 encoding issues
    text = text.encode('utf-8', errors='ignore').decode('utf-8', errors='ignore')
    
    # Replace common corrupted sequences
    text = re.sub(r'[^\x00-\x7F\u4e00-\u9fff\u3400-\u4dbf\uff00-\uffef]+', '', text)
    
    return text.strip()

html_path, json_path = sys.argv[1:3]

try:
    # Try UTF-8 first, then fallback to other encodings
    try:
        text = Path(html_path).read_text(encoding="utf-8")
    except UnicodeDecodeError:
        try:
            text = Path(html_path).read_text(encoding="utf-8", errors="replace")
        except Exception:
            # Final fallback - read as binary and decode carefully
            with open(html_path, "rb") as f:
                raw_bytes = f.read()
            text = raw_bytes.decode("utf-8", errors="replace")
except Exception as exc:  # pragma: no cover - defensive
    print(f"Failed to read HTML file: {exc}", file=sys.stderr)
    sys.exit(1)

pattern = re.compile(re.escape('window.__reactRouterContext.streamController.enqueue('))
chunks = []
for match in pattern.finditer(text):
    idx = match.end()
    if idx >= len(text) or text[idx] != '"':
        continue
    idx += 1
    chunk_chars = ['"']
    escaped = False
    while idx < len(text):
        ch = text[idx]
        chunk_chars.append(ch)
        if not escaped and ch == '"':
            break
        if escaped:
            escaped = False
        elif ch == '\\':
            escaped = True
        idx += 1
    if chunk_chars[-1] != '"':
        continue
    chunk = ''.join(chunk_chars)
    chunks.append(chunk)
if os.environ.get("CHATGPT_PARSER_DEBUG") == "true":
    print(f"HTML length: {len(text)} bytes", file=sys.stderr)
    print(f"Found {len(chunks)} stream chunks", file=sys.stderr)
if not chunks:
    print("No React Router stream data found in HTML", file=sys.stderr)
    sys.exit(1)

try:
    stream_payload = json.loads(json.loads(chunks[0]))
except json.JSONDecodeError as exc:
    print(f"Failed to decode stream payload: {exc}", file=sys.stderr)
    sys.exit(1)

length = len(stream_payload)
sentinels = {-5: None, -7: False}
resolving = set()


def decode(value):
    if isinstance(value, int):
        return decode_index(value)
    if isinstance(value, dict):
        result = {}
        for key, inner in value.items():
            if isinstance(key, str) and key.startswith("_") and key[1:].isdigit():
                resolved_key = decode_index(int(key[1:]))
            else:
                resolved_key = decode(key)
            result[resolved_key] = decode(inner)
        return result
    if isinstance(value, list):
        return [decode(item) for item in value]
    return value


@lru_cache(maxsize=None)
def decode_index(idx):
    if idx in sentinels:
        return sentinels[idx]
    if not (0 <= idx < length):
        return idx
    if idx in resolving:
        return None
    resolving.add(idx)
    try:
        result = decode(stream_payload[idx])
    finally:
        resolving.remove(idx)
    return result


conversation_data = None
for i in range(length):
    resolved = decode_index(i)
    if not isinstance(resolved, dict):
        continue
    server_resp = resolved.get("serverResponse")
    if not isinstance(server_resp, dict):
        continue
    data = server_resp.get("data")
    if isinstance(data, dict) and "mapping" in data:
        conversation_data = data
        break

if not conversation_data:
    print("Failed to locate conversation data in stream payload", file=sys.stderr)
    sys.exit(1)

simplified = {
    "title": clean_text(conversation_data.get("title", "")),
    "create_time": conversation_data.get("create_time"),
    "update_time": conversation_data.get("update_time"),
    "mapping": {},
}

# Apply aggressive cleaning to all string values in the conversation data
def deep_clean_object(obj):
    """Recursively clean all strings in a nested object structure"""
    if isinstance(obj, dict):
        return {k: deep_clean_object(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [deep_clean_object(item) for item in obj]
    elif isinstance(obj, str):
        # Aggressive cleaning for JSON safety
        cleaned = clean_text(obj)
        # Remove all control characters
        cleaned = ''.join(char for char in cleaned if ord(char) >= 32 or char in '\n\t\r')
        return cleaned
    else:
        return obj

conversation_data = deep_clean_object(conversation_data)

mapping = conversation_data.get("mapping", {})
if not isinstance(mapping, dict):
    print("Conversation mapping structure is invalid", file=sys.stderr)
    sys.exit(1)

for key, node in mapping.items():
    if not isinstance(node, dict):
        continue
    entry = {}
    for field in ("id", "message", "parent", "children"):
        if field in node:
            entry[field] = node[field]
    simplified["mapping"][key] = entry

# Build ordered messages list with reference metadata
messages_list = []
for key, node in mapping.items():
    if not isinstance(node, dict):
        continue
    message = node.get("message")
    if not isinstance(message, dict):
        continue
    author = message.get("author") or {}
    role = author.get("role")
    if role not in ("user", "assistant"):
        continue

    content_obj = message.get("content") or {}
    parts = content_obj.get("parts")
    if isinstance(parts, list):
        content = "".join(
            part if isinstance(part, str) else json.dumps(part, ensure_ascii=False)
            for part in parts
        )
    else:
        content = ""

    metadata = message.get("metadata") or {}
    raw_refs = metadata.get("content_references") or []
    references = []
    if raw_refs:
        ref_map = {}
        for ref in raw_refs:
            if not isinstance(ref, dict):
                continue
            matched_text = ref.get("matched_text") or ""
            match = re.search(r"【(\d+)", matched_text)
            if match:
                number = int(match.group(1))
            else:
                # Try new format: 27L49-L57
                match = re.search(r"(\d+)L\d+", matched_text)
                if not match:
                    continue
                number = int(match.group(1))
            title = clean_text(ref.get("title") or ref.get("source") or "")
            url = ref.get("url") or ref.get("link") or ""
            if not url:
                continue
            info = ref_map.setdefault(number, {
                "number": number,
                "title": title,
                "url": url,
                "attribution": clean_text(ref.get("attribution") or ""),
                "matched_texts": set(),
            })
            if not info["title"] and title:
                info["title"] = title
            if not info["url"] and url:
                info["url"] = url
            if matched_text:
                info["matched_texts"].add(matched_text)

        for number in sorted(ref_map):
            info = ref_map[number]
            matched_texts = sorted(info["matched_texts"])
            for matched_text in matched_texts:
                content = content.replace(matched_text, f"[{number}]")
            # Collapse consecutive duplicate references like [27][27]
            content = re.sub(r"\[(\d+)\](\[\1\])+", r"[\1]", content)
            references.append({
                "number": number,
                "title": clean_text(info["title"]),
                "url": info["url"],
                "matched_text": clean_text(matched_texts[0] if matched_texts else ""),
                "matched_texts": [clean_text(t) for t in matched_texts],
                "attribution": clean_text(info["attribution"]),
            })

    # Clean corrupted UTF-8 characters and normalize content
    content = clean_text(content)
    
    # Apply clean_text to the entire content to ensure no control characters remain
    if content:
        # Additional cleaning for JSON safety
        content = content.replace('\x00', '').replace('\x01', '').replace('\x02', '')
        content = content.replace('\x03', '').replace('\x04', '').replace('\x05', '')
        content = content.replace('\x06', '').replace('\x07', '').replace('\x08', '')
        content = content.replace('\x0B', '').replace('\x0C', '').replace('\x0E', '')
        content = content.replace('\x0F', '').replace('\x10', '').replace('\x11', '')
        content = content.replace('\x12', '').replace('\x13', '').replace('\x14', '')
        content = content.replace('\x15', '').replace('\x16', '').replace('\x17', '')
        content = content.replace('\x18', '').replace('\x19', '').replace('\x1A', '')
        content = content.replace('\x1B', '').replace('\x1C', '').replace('\x1D', '')
        content = content.replace('\x1E', '').replace('\x1F', '')
    
    normalized_content = content.strip()
    if normalized_content.lower() == "original custom instructions no longer available":
        continue

    messages_list.append({
        "id": node.get("id") or key,
        "role": role,
        "content": content,
        "create_time": message.get("create_time"),
        "parent": node.get("parent"),
        "references": references,
    })

def _sort_key(entry):
    create_time = entry.get("create_time")
    try:
        return (0, float(create_time))
    except (TypeError, ValueError):
        return (1, 0.0)

messages_list.sort(key=_sort_key)
simplified["messages"] = messages_list

try:
    Path(json_path).write_text(json.dumps(simplified, ensure_ascii=False), encoding="utf-8")
except Exception as exc:  # pragma: no cover - defensive
    print(f"Failed to write JSON file: {exc}", file=sys.stderr)
    sys.exit(1)
PY
        log_error "Failed to extract JSON data from HTML"
        return 1
    fi

    if [[ ! -s "$json_file" ]]; then
        log_error "No conversation data extracted from HTML"
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
                mapping: .mapping,
                messages: (.messages // empty)
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
                    mapping: .mapping,
                    messages: (.messages // empty)
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
        if has("messages") then
            .messages
        else
            .mapping
            | to_entries
            | map(select(.value | has("message")))
            | map({
                id: (.value.id // .key),
                role: (.value.message.author.role // ""),
                content: ((.value.message.content.parts // [])
                    | map(if type == "string" then . else tostring end)
                    | join("")
                ),
                create_time: (.value.message.create_time // null),
                parent: (.value.parent // null),
                references: []
            })
            | sort_by(.create_time)
        end |
        map(select((.role == "user" or .role == "assistant") and (.content | length > 0))) |
        map({
            id: .id,
            role: .role,
            content: .content,
            create_time: .create_time,
            parent: (.parent // null),
            references: (.references // [])
        })
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
    
    # Get the first substantial user message as the main question (skip very short ones)
    echo "$messages" | jq -r '
        [.[] | select(.role == "user" and (.content | length) > 10)] | 
        if length > 0 then .[0].content else empty end
    ' 2>/dev/null || echo "ChatGPT Conversation"
}

# Extract answers from conversation data
extract_answers() {
    local json_file="$1"
    
    log_debug "Extracting answers from conversation data"
    
    # Use jq to extract and format all messages instead of Python
    # Handle potential control character issues by using --raw-input with pre-filtering
    local chat_blocks
    if command -v rg >/dev/null 2>&1; then
        # Use ripgrep to pre-filter out control characters if available
        chat_blocks=$(cat "$json_file" | rg -v '[\x00-\x08\x0B\x0C\x0E-\x1F]' | jq -r '
            .messages[]? |
            select(.role == "user" or .role == "assistant") |
            select(.content | length > 10) |
            select(.content | startswith("{") and contains("task_violates_safety_guidelines") | not) |
            (if .role == "user" then "user" else "chatgpt" end) as $speaker |
            "{% chat(speaker=\"\($speaker)\") %}\n\(.content)\n{% end %}"
        ' 2>/dev/null | paste -sd '\n\n' -)
    else
        # Fallback to tr for basic control character filtering
        chat_blocks=$(tr -d '\000-\010\013\014\016-\037' < "$json_file" | jq -r '
            .messages[]? |
            select(.role == "user" or .role == "assistant") |
            select(.content | length > 10) |
            select(.content | startswith("{") and contains("task_violates_safety_guidelines") | not) |
            (if .role == "user" then "user" else "chatgpt" end) as $speaker |
            "{% chat(speaker=\"\($speaker)\") %}\n\(.content)\n{% end %}"
        ' 2>/dev/null | paste -sd '\n\n' -)
    fi
    
    if [[ -n "$chat_blocks" ]]; then
        echo "$chat_blocks"
    else
        echo "Answer content not available."
    fi
}

# Extract creation date from JSON file
extract_creation_date() {
    local json_file="$1"
    
    log_debug "Extracting creation date from JSON file"
    
    # Extract create_time directly from the JSON file using jq instead of Python
    # This avoids potential issues with string escaping and control characters
    local create_time
    create_time=$(jq -r '.create_time | if . then (. | floor | tostring) else empty end' "$json_file" 2>/dev/null)
    
    if [[ "$DEBUG_MODE" == "true" ]]; then
        log_debug "Extracted create_time value: '$create_time'"
    fi
    
    # Convert to Zola compatible format
    if [[ -n "$create_time" && "$create_time" != "null" && "$create_time" != "" ]]; then
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
    local ref_count
    ref_count=$(jq '[.messages[]? | (.references // [])[]? | .number] | unique | length' "$json_file" 2>/dev/null || echo "0")
    if [[ -z "$ref_count" || "$ref_count" == "null" ]]; then
        ref_count=0
    fi
    EXTRACTED_REF_COUNT="$ref_count"
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
if [[ "${(%):-%N}" == "${0}" ]]; then
    main "$@"
fi
