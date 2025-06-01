# Blog [琳.tw](https://琳.tw)

![Health Check](https://cronitor.io/badges/iZnpfC/production/Q90Ln0QlxPPwcWipMHw3TrKN8Bw.svg) ![Website](https://img.shields.io/website?url=https%3A%2F%2Fxn--jgy.tw%2F) ![GitHub branch check runs](https://img.shields.io/github/check-runs/jim60105/blog/master?label=Deploy)

## Introduction

This is the blog [琳.tw](https://琳.tw), created with [Zola](https://www.getzola.org/), a modern static site generator, and the impressive Zola theme [Duckquill](https://duckquill.daudix.one/). The content of this blog is stored separately in the [jim60105/blog-content repository](https://github.com/jim60105/blog-content).

## Dependencies

This blog requires [Zola](https://www.getzola.org/) 0.20.0 or higher. Please follow the [official installation guide](https://www.getzola.org/documentation/getting-started/installation/) to install Zola on your system.

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
| `article.html` | - Add likecoin iframe `partials/likecoin.html`<br>- Add iscn badge<br>- Use `config.extra.toc` to always display the in-page TOC. The default template only uses `page.extra.toc`, which must be defined in each article.<br>- Add `partials/sections.html` at the end of the article list.<br>- Add made with AI badge. |
| └`partials/toc.html` | - Use `config.extra.toc` to always display the toc. |
| └`partials/likecoin.html` (new) | Add [liker land WritingNFT badge](https://xn--jgy.tw/Blockchain/likecoin-writing-nft-widget-on-blogger/) to the end of the article. |
| └`partials/with_ai.html` (new) | Add [made with AI badge](https://aibadge.org/) to the right bottom corner. |
| └`partials/preview_image.html` (new) | Add preview image with AI badge support. |
| `base.html` | - Use `config.extra.toc_sidebar` to always display sidebar toc. |
| `taxonomy_single.html` | Add display of detailed content for this taxonomy. |
| `sitemap.xml` | - Remove <lastmod> date that is 0000-01-01 which I used for non-article content. |
| `partials/articles.html` | - Make different taxonomies list together<br>- Remove blur thumbnail |
| `partials/head.html` | - Rearrange the order of meta tags and extract them to `partials/open_graph.html`. According to best practices, all meta og tags should be placed at the very beginning of the webpage, sorted by importance, while `<style>` and `<script>` should be placed later. This is because og parsers only read a fixed length (not very long) and discard any content after encountering any error.<br>-  Add link preconnect.<br>- Add my fonts from CDN.<br>- Add Google Analytics and Microsoft Clarity tracking code and remove goat counter for clarity.<br>- Bust cache with timestamp query for style.css loading. |
| └`partials/open_graph.html` (new) | - Extracted og tags from `partials/head.html`<br>- Add twitter meta tags.<br>- Add ld+json script tags. |
| `partials/nav.html` | Change the Feed button to copy to clipboard. |
| `partials/sections.html` (new) | List all the sections just like tags. (Copy from `taxonomy_list.html`) |
| `partials/prompt-injection.html` (new) | Injecting prompt to AI search engine. Not really sure if it works, but it's worth a try.😎 |
| `shortcodes/image.html` | Generate `srcset` to support responsive images. |
| `shortcodes/youtube.html` |  Add credentialless, sandbox, and title property to youtube embed. |
| `scss/fonts.scss` | Use my own fonts. |
<!-- prettier-ignore-end -->

## Shortcodes

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

1. Update the version in `.devcontainer/devcontainer.json`.
2. Update Cloudflare Workers settings:
   - [Go to Settings → Build → Variables and Secrets](https://dash.cloudflare.com/6489b5132bc0104a8348d01f728a0bed/workers/services/view/blog/production/settings#builds)
   - Update `ZOLA_VERSION` to the new version
3. Update GitHub Actions variables for `blog-content` repository:
   - [Go to Settings → Secrets and variables → Actions → Variables](https://github.com/jim60105/blog-content/settings/variables/actions)
   - Update `ZOLA_VERSION` to the new version
4. Check the [Zola changelog](https://github.com/getzola/zola/blob/master/CHANGELOG.md) for any new features.
5. Update the version number [in this `README.md` file.](#dependencies)

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
