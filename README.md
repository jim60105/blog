# Blog [琳.tw](https://琳.tw)

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
| `base.html` | - Add Google Analytics and Microsoft Clarity tracking code |
| `article.html` | - Add likecoin iframe<br>- Add iscn badge |
| `taxonomy_list.html` | Make it work with different taxonomies |
| `taxonomy_single.html` | Make it work with different taxonomies |
| `partials/articles.html` | Make different taxonomies list together |
| `partials/nav.html` | Change the Feed button to copy to clipboard: Add onclick event |

## LICENSE

Since this repository contains two different aspects of content, "blog articles" and "blog website," it is licensed in two ways with three methods:

- Article content (text and image files located in the `content` and `static` folders, excluding script files)
  - Articles marked with GFDL-1.3 are licensed under GFDL-1.3
  - All rights reserved for other article content
- Non-article content (including but not limited to scripts, configuration files, styles, templates that make up this blog):
  - Licensed under GPL-3.0

Configuration files, styles, templates of the blog website are licensed under GPL-3.0 to practice the spirit of free software; while technical introductions and documents within article content are licensed under GFDL-1.3 to allow readers to freely use, modify, and share these contents; as for other article contents that I deem unsuitable for further sharing all rights are reserved.

---

由於此儲存庫包含「部落格文章」以及「部落格網站」兩種不同面向的內容，此儲存連以兩種許可證；三種方式授權：

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
