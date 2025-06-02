# 琳的備忘手札 (琳.tw) - GitHub Copilot 專案指南

## 專案概述

這是一個使用 **Zola** (靜態網站產生器) 建構的個人技術部落格，採用 **Duckquill** 主題。網站託管在 Cloudflare Workers 上，提供正體中文的技術文章分享。專案的文章內容儲存在 [jim60105/blog-content](https://github.com/jim60105/blog-content) 獨立儲存庫中。

### 技術架構

- **靜態網站產生器**: Zola (需要 0.20.0+)
- **主題**: Duckquill (基於 MIT 授權)
- **樣式系統**: Sass/SCSS
- **範本引擎**: Tera (類似 Jinja2)
- **託管平台**: Cloudflare Workers
- **部署配置**: `wrangler.jsonc`
- **建構程式碼**: `zola build`

## 程式碼風格與約定

### 語言使用指南

- **程式碼註解**: 使用英文撰寫
- **Commit 訊息**: 使用英文撰寫
- **文件**: 使用正體中文 (zh-TW)
- **程式碼中的變數名稱**: 使用英文

### HTML 範本 (Tera)

- 使用 Tera 範本語法 (類似 Jinja2)
- 範本檔案位於 `templates/` 目錄
- 主要繼承自 `duckquill/templates/base.html`
- 自訂 partials 放在 `templates/partials/`

### CSS/SCSS 約定

- 主要樣式檔案: `sass/style.scss`
- 使用模組化導入: `@import "module-name"`
- CSS 變數命名: `--kebab-case`
- 支援響應式設計 (RWD)
- 使用 CSS Variables 和現代 CSS 功能

### 檔案組織結構

```
├── content/          # 文章內容 (來自 blog-content 儲存庫)
├── templates/        # Tera 範本檔案
├── sass/            # SCSS 樣式檔案
├── static/          # 靜態資源
├── public/          # 建構輸出目錄
├── config.toml      # Zola 主要配置
└── wrangler.jsonc   # Cloudflare Pages 部署配置
```

## 主題自訂與覆寫

此專案大量自訂了 Duckquill 主題，主要覆寫檔案包括：

### 重要的自訂檔案

- `templates/article.html` - 文章頁面範本 (加入 LikeCoin、AI 標章支援)
- `templates/partials/head.html` - 重新安排 meta 標籤順序，加入 SEO 優化
- `templates/partials/open_graph.html` - 獨立的 Open Graph 標籤管理
- `templates/partials/nav.html` - 修改 Feed 按鈕為複製功能
- `templates/shortcodes/image.html` - 響應式圖片支援 (srcset)

### 新增的功能性檔案

- `templates/partials/likecoin.html` - LikeCoin WritingNFT 整合
- `templates/partials/with_ai.html` - AI 輔助創作標章
- `templates/partials/preview_image.html` - 預覽圖片與 AI 標章
- `templates/partials/prompt_injection.html` - SEO 優化的提示注入

### 樣式模組

- `sass/fonts.scss` - 自訂字型 (Iansui + Noto Sans)
- `sass/color.scss` - 顏色系統 (success, danger, warning 等)
- `sass/likecoin.scss` - LikeCoin iframe 樣式
- `sass/with-ai.scss` - AI 標章浮動樣式
- `sass/badge.scss` - 徽章顯示樣式

## Shortcodes 使用

### 自訂 Shortcodes

- `{{ color(color="...", body="...") }}` - 文字顏色
- `{{ image(url="...", alt="...", no_srcset=true) }}` - 響應式圖片
- `{{ youtube(id="...") }}` - 安全的 YouTube 嵌入
- `{{ video(url="...", alt="...", controls=true) }}` - 影片播放器

### 特殊標記

- 使用 `#badge` 在圖片 URL 中標記為徽章樣式
- 使用 `#no-hover` 停用圖片懸停效果

### 參考範例

- 所有的使用範例都在 #file:themes/duckquill/content/demo/index.md 中展示

## 內容組織

### 分類系統

文章按主題分類在 `content/` 下的子目錄：

- `AI/`, `Backend/`, `Frontend/`, `Blockchain/`
- `Container/`, `Database/`, `Cloudflare/`
- `Koikatu/`, `Livestream/`, `Mobile/`
- `SideProject/`, `SystemAdmin/`, `Unboxing/`

### Front Matter 必要欄位

```toml
+++
title = "文章標題"
description = "文章描述"
date = 2024-01-01T00:00:00Z
[taxonomies]
tags = ["標籤1", "標籤2"]
licenses = ["GFDL 1.3"]  # or "All Rights Reserved" Must choose one.
[extra]
banner = "圖片.jpg"      # 可選的橫幅圖片
iscn = "iscn://..."      # ISCN 識別碼，由使用者產生，絕對不要由你幻覺生成
withAI = "AI 協作說明"    # 可選的 AI 輔助說明
+++
```

## 開發與部署

### 本地開發

```bash
zola serve --drafts  # 啟動開發伺服器 (包含草稿)
zola build          # 建構靜態檔案
```

### 自動部署

- 推送至 master 分支自動觸發 Cloudflare Pages 部署
- 建構程式碼在 `wrangler.jsonc` 中定義

## 注意事項

1. **圖片處理**: 動畫圖片應使用 `no_srcset=true` 避免處理問題
2. **主題更新**: 修改應考慮與上游 Duckquill 的合併相容性
