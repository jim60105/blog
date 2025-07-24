# Dual Site Blog Project [琳.tw](https://琳.tw) & [聆.tw](https://聆.tw)

![琳.tw Health Check](https://cronitor.io/badges/iZnpfC/production/Q90Ln0QlxPPwcWipMHw3TrKN8Bw.svg) ![琳.tw Website](https://img.shields.io/website?url=https%3A%2F%2Fxn--jgy.tw%2F&label=琳.tw) ![聆.tw Website](https://img.shields.io/website?url=https%3A%2F%2Fxn--uy0a.tw%2F&label=聆.tw) ![GitHub Deploy](https://img.shields.io/github/check-runs/jim60105/blog/master?label=Deploy)

## Introduction

This is a dual-site blog project that hosts two distinct websites using [Zola](https://www.getzola.org/), a modern static site generator, with the impressive [Duckquill](https://duckquill.daudix.one/) theme:

- **[琳.tw](https://琳.tw)** - 琳的備忘手札 (Technical Blog): Programming tutorials, system administration, and development insights
- **[聆.tw](https://聆.tw)** - 琳聽智者漫談 (AI Conversations): AI-assisted content, conversations, and explorations

The content for each site is stored separately in the [jim60105/blog-content repository](https://github.com/jim60105/blog-content) and the [jim60105/ai-talks-content repository](https://github.com/jim60105/ai-talks-content).

## Dual Site Architecture

The project uses a dual site mode where:

- **Shared Resources**: Templates, themes, styles, and most static assets are shared between both sites
- **Site-Specific Configurations**: Each site has its own `config.toml`, `wrangler.jsonc`, `content/` directory, and site-specific static files stored in dedicated folders:
  - `琳.tw/` - Configuration and content for the technical blog
  - `聆.tw/` - Configuration and content for the AI conversations site

### Static Folder Handling

When switching sites, the `static/` folder is processed **file by file**:

- **Common static files** (e.g. `copy-to-clipboard.js`) are always preserved and never deleted.
- **Site-specific static files** (e.g. `favicon.svg`, `apple-touch-icon.png`) are hard linked from the selected site folder to the project root, overwriting only those files.
- The script will only remove hard links for site-specific files during cleanup, so shared files remain untouched.

This ensures that switching between sites will not accidentally delete or overwrite shared static assets.

### Site Switching

Use the provided `switch-site.sh` script to switch between development modes:

```bash
# Switch to technical blog mode (琳.tw)
./switch-site.sh 琳.tw

# Switch to AI conversations mode (聆.tw)
./switch-site.sh 聆.tw

# Check current site status
./switch-site.sh status

# Clean up and restore original state
./switch-site.sh clean
```

The script creates hard links for site-specific files to the project root:

- `config.toml` - Site configuration
- `wrangler.jsonc` - Cloudflare deployment configuration
- `content/` - Site content directory
- Site-specific files in `static/` (e.g. favicons, banners)

## Development Workflow

1. **Choose your site**: Run `./switch-site.sh 琳.tw` or `./switch-site.sh 聆.tw`
2. **Start development**: Run `zola serve --drafts` to start the development server
3. **Make changes**: Edit content, templates, or styles as needed
4. **Switch sites**: Use the script to switch between sites during development
5. **Clean up**: Run `./switch-site.sh clean` when finished to restore the original state

## Dependencies

This blog requires [Zola](https://www.getzola.org/) 0.20.0 or higher. Please follow the [official installation guide](https://www.getzola.org/documentation/getting-started/installation/) to install Zola on your system.

## Site Configuration Differences

### 琳.tw (Technical Blog)

- **Focus**: Programming tutorials, system administration, development insights
- **Base URL**: `https://琳.tw`
- **Title**: 琳的備忘手札

### 聆.tw (AI Conversations)

- **Focus**: AI-assisted content, conversations, and explorations
- **Base URL**: `https://聆.tw`
- **Title**: 琳聽智者漫談

## Hotlink Protection

Hotlink protection is setting at Cloudflare level. Put the following terms in the url path to bypass the hotlink protection:

- `preview`
- `cover`
- `banner`
- `favicon`

## Theme Overwrite

<!-- prettier-ignore-start -->
| File | Description |
| --- | --- |
| `article_list.html` | - Remove `Filter by tag`<br>- Add `partials/sections.html` at the end of the article list.  |
| `article.html` | - Add likecoin iframe `partials/likecoin.html`<br>- Add iscn badge<br>- Add `partials/sections.html` at the end of the article list.<br>- Add made with AI badge. |
| └`partials/likecoin.html` (new) | Add [liker land WritingNFT badge](https://xn--jgy.tw/Blockchain/likecoin-writing-nft-widget-on-blogger/) to the end of the article. |
| └`partials/with_ai.html` (new) | Add [made with AI badge](https://aibadge.org/) to the right bottom corner. |
| └`partials/preview_image.html` (new) | Add preview image with AI badge support. |
| `base.html` | - Add my custom head tags.<br>- Add Google Analytics and Microsoft Clarity tracking code. |
| `sitemap.xml` | - Remove <lastmod> date that is 0000-01-01 which I used for non-article content. |
| `partials/articles.html` | - Make different taxonomies list together<br>- Remove blur thumbnail |
| `partials/nav.html` | Change the Feed button to copy to clipboard. |
| `partials/sections.html` (new) | List all the sections just like tags. (Copy from `taxonomy_list.html`) |
| `partials/prompt-injection.html` (new) | Injecting prompt to AI search engine. Not really sure if it works, but it's worth a try.😎 |
| `shortcodes/image.html` | Generate `srcset` to support responsive images. |
| `scss/fonts.scss` | Use my own fonts. |
<!-- prettier-ignore-end -->

## Shortcodes

### chat (Chat Dialogue Box)

Display a chat-style dialogue box between different speakers, ideal for showcasing conversations with AI tools (e.g., ChatGPT, Claude, Gemini, Copilot) or users. This shortcode provides clear speaker identification, avatar, and responsive message bubbles, fully styled to match the site theme and supporting both light/dark modes.

**Usage Example:**

```markdown
{% chat(speaker="chatgpt") %}
Hello! I am ChatGPT, happy to help. What would you like to ask?
{% end %}

{% chat(speaker="user") %}
Can you explain what machine learning is?
{% end %}

{% chat(speaker="claude") %}
Machine learning is a branch of AI that enables computer systems to learn and improve from data...
{% end %}
```

**Speaker Options:**

- `chatgpt` — ChatGPT (OpenAI logo)
- `claude` — Claude (Anthropic logo)
- `gemini` — Gemini (Google logo)
- `copilot` — GitHub Copilot (GitHub logo)
- `felo` - Felo Search (Felo logo)
- `user` — Generic user (default avatar)
- `jim` — Blog author (custom avatar)

**Customization:**

- Avatars are stored in `static/avatars/`
- Styles are defined in `sass/chat.scss`

### editor_note (Editorial Note)

Display an editorial note or remark from the editor, useful for data update notices, version change notes, or editorial supplements. The shortcode displays a fixed "編按" (Editorial Note) label in Chinese, making it clear that this is an editorial remark.

**Usage Example:**

```markdown
{% editor_note() %}
This article is based on 2024 data, some information may have changed.
{% end %}

{% editor_note() %}
The code examples in this section have been updated to the latest API version.
{% end %}
```

**Customization:**

- Styles are defined in `sass/editor-note.scss`
- Uses CSS custom properties for theming

### color

Wrap the content with a element tag with a color attribute. The default element is `span`.

```markdown
{{ color(body="some text", color="orange", element="p") }}
```

```markdown
{% color(color="orange", element="div") %}
Some orange text in a div element
{% end %}
```

### cr (color red)

```markdown
{{ cr(body="some red text") }}
```

```markdown
{% cr() %}
Some red text
{% end %}
```

### cg (color green)

```markdown
{{ cg(body="some green text") }}
```

```markdown
{% cg() %}
Some green text
{% end %}
```

### ch (Hide content with spoiler)

```markdown
{{ ch(body="some hidden text") }}
```

```markdown
{% ch() %}
Some hidden text
{% end %}
```

### image (Overwrite Duckquill)

> [!NOTE]  
> Differences to the original `image` in Duckquill:
>
> - Discard `url-min` design.
> - Generate `srcset` for responsive images.

- `url`: URL to an image.
- ~~`url_min`: URL to compressed version of an image, original can be opened by clicking on the image.~~
- `alt`: Alt text, same as if the text were inside square brackets in Markdown.
- `full`: Forces image to be full-width.
- `full_bleed`: Forces image to fill all the available screen width. Removes shadow, rounded corners and zoom on hover.
- `start`: Float image to the start of paragraph and scale it down.
- `end`: Float image to the end of paragraph and scale it down.
- `pixels`: Uses nearest neighbor algorithm for scaling, useful for keeping pixel-art sharp.
- `transparent`: Removes rounded corners and shadow, useful for images with transparency.
- `no_hover`: Removes zoom on hover.
- `spoiler`: Blurs image until hovered over/pressed on, useful for plot rich game screenshots.
- `spoiler` with `solid`: Ditto, but makes the image completely hidden.
- `no_srcset`: Passing `no_srcset=true` will not generate `srcset`.

> [!WARNING]
> Since the [zola built-in resize_image()](https://www.getzola.org/documentation/content/image-processing/) does not seems to support resizing animated images, the `no_srcset` parameter _SHOULD_ be used to bypass the image processing.

```
{{ image(url="preview.jpg", alt="Some preview image", no_hover=true) }}
```

## Upgrading Zola

When upgrading Zola version, remember to follow these steps:

1. Check the [Zola changelog](https://github.com/getzola/zola/blob/master/CHANGELOG.md) for any new features.
2. Update the version number in `.devcontainer/devcontainer.json`.
3. Update GitHub Actions variables for both `blog` and `blog-content` repositories:
   - Go to Settings → Secrets and variables → Actions → Variables
     - [Blog](https://github.com/jim60105/blog/settings/variables/actions)
     - [Blog Content](https://github.com/jim60105/blog-content/settings/variables/actions)
   - Update `ZOLA_VERSION` to the new version
4. Update the version number in [this `README.md` file.](#dependencies)

## Links

- [Zola Documentation](https://www.getzola.org/documentation)
- [Duckquill](https://duckquill.daudix.one/)
- [Tera documentation](https://keats.github.io/tera/docs/)
- [Zola built-in templates](https://github.com/getzola/zola/tree/master/components/templates/src/builtins)

## LICENSE

### GNU GENERAL PUBLIC LICENSE Version 3

<img src="https://github.com/user-attachments/assets/eea56a30-33d8-4dce-983b-10becb4304e0" alt="gplv3" width="300" />

[GNU GENERAL PUBLIC LICENSE Version 3](LICENSE)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

### Special Authorization

I, 陳鈞, hereby grant explicit permission for anyone to submit the content of this project to the upstream project [Duckquill](https://codeberg.org/daudix/duckquill) without the need to change the MIT license of Duckquill.
