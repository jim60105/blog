# Blog [琳.tw](https://琳.tw)

![Health Check](https://cronitor.io/badges/iZnpfC/production/Q90Ln0QlxPPwcWipMHw3TrKN8Bw.svg) ![Website](https://img.shields.io/website?url=https%3A%2F%2Fxn--jgy.tw%2F)
 ![GitHub branch check runs](https://img.shields.io/github/check-runs/jim60105/blog/master?label=Deploy)

## Introduction

This is the blog [琳.tw](https://琳.tw), created with [Zola](https://www.getzola.org/), a modern static site generator, and the impressive Zola theme [Duckquill](https://duckquill.daudix.one/).

## Hotlink Protection

Hotlink protection is setting at Cloudflare level. Put the following terms in the url path to bypass the hotlink protection:

- `preview`
- `cover`
- `banner`
- `favicon`

## Theme Overwrite

| File | Description |
| --- | --- |
| `article_list.html` | - Bug fix: `number_of_posts` can be zero.<br>- Remove `Filter by tag`<br>- Add `partials/sections.html` at the end of the article list.  |
| `article.html` | - Add likecoin iframe `partials/likecoin.html`<br>- Add iscn badge<br>- Use `config.extra.toc` to always display the in-page TOC. The default template only uses `page.extra.toc`, which must be defined in each article.<br>- Add `partials/sections.html` at the end of the article list. |
| └`partials/toc.html` | - Use `config.extra.toc` to always display the toc. |
| └`partials/likecoin.html` | Add [liker land WritingNFT badge](https://xn--jgy.tw/Blockchain/likecoin-writing-nft-widget-on-blogger/) to the end of the article. |
| `base.html` | - Use `config.extra.toc_sidebar` to always display sidebar toc. |
| `taxonomy_list.html` | Make it work with different taxonomies |
| `taxonomy_single.html` | Make it work with different taxonomies |
| `sitemap.xml` | - Filter non-canonical pages<br>- Remove <lastmod> date that is 0000-01-01 which I used for non-article content. |
| `partials/articles.html` | - Make different taxonomies list together<br>- Remove blur thumbnail |
| `partials/default_theme.html` | Use dark theme (The intention of not using `config.extra.default_theme` is to use the dark theme and not enable the theme switcher.) |
| `partials/head.html` | - Rearrange the order of meta tags and extract them to `partials/open_graph.html`. According to best practices, all meta og tags should be placed at the very beginning of the webpage, sorted by importance, while `<style>` and `<script>` should be placed later. This is because og parsers only read a fixed length (not very long) and discard any content after encountering any error.<br>-  Add link preconnect.<br>- Add my fonts from CDN.<br>- Add Google Analytics and Microsoft Clarity tracking code. |
| └`partials/open_graph.html` (new) | - Extracted og tags from `partials/head.html`<br>- Add twitter meta tags.<br>- Add ld+json script tags. |
| `partials/nav.html` | Change the Feed button to copy to clipboard. |
| `partials/sections.html` (new) | List all the sections just like tags. (Copy from `taxonomy_list.html`) |
| `shortcodes/image.html` | Generate `srcset` to support responsive images. |
| `shortcodes/youtube.html` |  Add credentialless, sandbox, and title property to youtube embed. |

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

## Notes

A workaround in the `sitemap.xml` that filters out non-canonical pages has been fixed in Zola (see <https://github.com/getzola/zola/issues/2527>), but it hasn't been released yet. This workaround should be removed when upgrading to the next Zola release. It's 0.19.2 now.

## Links

- [Zola Documentation](https://www.getzola.org/documentation)
- [Duckquill](https://duckquill.daudix.one/)
- [Tera documentation](https://keats.github.io/tera/docs/)
- [Zola built-in templates](https://github.com/getzola/zola/tree/master/components/templates/src/builtins)

## LICENSE

Since this repository contains two different aspects of content, "blog articles" and "blog website," it is licensed under two types of licenses in three ways:

- Article content (text and image files located in the `content` and `static` folders, excluding script files)
  - Articles marked with GFDL-1.3 are licensed under GFDL-1.3
  - All rights reserved for other article content
- Non-article content (including but not limited to scripts, configuration files, styles, templates that make up this blog):
  - Licensed under GPL-3.0

Configuration files, styles, templates of the blog website are licensed under GPL-3.0 to practice the spirit of free software; while technical introductions and documents within article content are licensed under GFDL-1.3 to allow readers to freely use, modify, and share these contents; as for other article contents that I deem unsuitable for further sharing all rights are reserved.

---

由於此儲存庫包含「部落格文章」以及「部落格網站」兩種不同面向的內容，此儲存庫以兩種授權條款；三種方式授權：

- 文章內容 (位於 `content`, `static` 資料夾內的文字和圖片檔案且不包含腳本檔案)
  - 以 GFDL-1.3 標示者以 GFDL-1.3 授權
  - 其他文章內容保留所有權利
- 非文章內容 (包括但不限於構成此部落格的腳本、設定檔、樣式、範本等等)：
  - 以 GPL-3.0 授權

部落格網站的設定檔、樣式、範本等等以 GPL-3.0 授權，實踐自由軟體的精神；而文章內容中關於技術介紹、文件等部分，則以 GFDL-1.3 授權，讓讀者可以自由地使用、修改、分享這些內容；至於其他我認為不適合再被分享的文章內容則保留所有權利。

### GNU GENERAL PUBLIC LICENSE Version 3

<img src="https://github.com/user-attachments/assets/eea56a30-33d8-4dce-983b-10becb4304e0" alt="gplv3" width="300" />

[GNU GENERAL PUBLIC LICENSE Version 3](LICENSE)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

### GNU Free Documentation License 1.3

<img src="https://github.com/user-attachments/assets/b887d7d0-d101-42ad-a2f2-7e38e96a9a7f" alt="gfdlv1.3" width="300" />

[GNU Free Documentation License 1.3](content/LICENSE-GFDL-1.3.md)

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.

A copy of the license is included in the section entitled "GNU Free Documentation License".
