# Claude Chat Snapshots Parser

A tool for parsing Claude AI chat snapshots from share URLs and converting them to Markdown format for blog posts.

## Usage

```bash
# Basic usage with URL
./scripts/claude-chat-parser.zsh https://claude.ai/share/55718b5b-22de-4d58-96a3-f4718c9bea4a

# Debug mode
./scripts/claude-chat-parser.zsh --debug https://claude.ai/share/55718b5b-22de-4d58-96a3-f4718c9bea4a

# Test mode with mock data
./scripts/claude-chat-parser.zsh --test

# Interactive mode (prompts for URL)
./scripts/claude-chat-parser.zsh

# Help
./scripts/claude-chat-parser.zsh --help
```

## Features

- **URL Parsing**: Extracts UUID from Claude share URLs
- **JSON Processing**: Parses Claude's chat snapshot API format
- **Content Extraction**: Separates human questions from Claude responses
- **Markdown Generation**: Creates properly formatted blog posts
- **AI Integration**: Includes AI collaboration metadata
- **Error Handling**: Comprehensive validation and user-friendly messages

## Requirements

- zsh
- curl
- jq
- search-markdown-generator.zsh (included)

## Notes

- Claude's API is protected by Cloudflare and requires browser interaction for real URLs
- Use `--test` mode to verify functionality with mock data
- Generated markdown files use Zola format with chat shortcodes
- Integrates with existing blog infrastructure (same as felo-search-parser.zsh)

## Output Format

The parser generates markdown files with:
- Proper front matter (title, date, tags, licenses)
- AI collaboration metadata (`withAI` field)
- Chat format using `{% chat(speaker="...") %}` shortcodes
- Human questions and Claude responses properly separated