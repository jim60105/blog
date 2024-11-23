+++
title = "Cloudflare Workers進階 ─ wrangler簡介和GitHub Action串接"
description = "Cloudflare Workers進階 ─ wrangler簡介和GitHub Action串接"
date = 2021-10-31T11:01:00.000Z
updated = 2024-01-04T04:02:39.168Z
draft = true
aliases = [ ]

[taxonomies]
tags = [ "JavaScript", "Cloudflare" ]

[extra]
+++

## 簡介wrangler

wrangler是Cloudflare Workers專用的CLI工具。

它讓你可以用你慣用的編輯器寫code，在線下做開發、測試、部屬、收log。  
除此之外，它也支援以webpack打包，**讓你可以用上ES6、讓你可以寫TypeScript**。

## 安裝

安裝方式有兩種，npm或手動  
強烈建議使用npm，只要一行指令完成  
如果你不使用npm再選擇手動安裝

### npm安裝

npm install -g @cloudflare/wrangler

### 手動安裝

在wrangler的發佈頁取得最新的發佈  
<https://github.com/cloudflare/wrangler/releases>  
將下載檔案存在某處，並把路徑加入系統環境變數PATH  

### 安裝完成測試

能以指令印出版本號，即是安裝成功

wrangler --version

## 帳號登入

wrangler提供很簡單的方式登入你的cloudflare帳號  
使用login指令會開啟瀏覧器，無腦登入

wrangler login

登入完成後使用whoami查看當前登入帳號

wrangler whoami

> 另外它可以讀取環境變數登入，此方式使用在CI  
> 請見[官方文件](https://developers.cloudflare.com/workers/cli-wrangler/authentication#using-environment-variables)

## Command

> 完整Command清單請見官方文件  
> <https://developers.cloudflare.com/workers/cli-wrangler/commands>

此處我列出幾個會用到的指令，詳細用法請見官方文件

### 初始化、建構

* init: 由現有專案初始化為Cloudflare Workers專案  
**應該在專案目錄下執行**，主要用於產生_wrangler.toml_
* generate: 由GitHub repo範本架構出Cloudflare Workers專案，我把它視為`git clone` \+ `wrangler init`  
你可以在[這裡](https://developers.cloudflare.com/workers/get-started/quickstarts#templates)找到幾個官方範本，或是[在GitHub中搜尋](https://github.com/topics/cloudflare-workers?q=template)  
後面我們會用到此範本: <https://github.com/jim60105/worker-ts%5Ftemplate>

### 編譯、偵錯

這些指令要**在專案目錄下執行**

* build: 編譯專案，這會檢查你的_wrangler.toml_檔案，並執行編譯、打包
* dev: 在本機上啟動一個server，並在HTTP request傳入時執行Worker  
它可以將request轉發到Cloudflare的服務器、你的網域、或其它定義的主機用做測試
* log: 監聽**已部屬**的Worker log

### 部屬

* publish: 把你的專案部屬至Cloudflare。詳細部屬設定都寫在_wrangler.toml_

## 讓我們寫個範例專案——隨機路由

這個範例我們來做一個隨機路由功能:
訪問 `https://img.example.com/random.png` 時，隨機由一堆圖片中選一張回傳

## Workers Sites

> Workers Sites使開發人員可以將靜態應用程序直接部署到Workers。  
> 非常適合部署由靜態網站生成器（如Hugo和Gatsby）或前端框架（如Vue和React）構建的應用程序。  
>
> ──譯自[官方文件](https://developers.cloudflare.com/workers/platform/sites)

沒錯，Cloudflare它教你怎麼把整個網站搬上workers  
但是記得回頭看一下Plan，[官方文件](https://developers.cloudflare.com/workers/platform/sites)提到了會套用KV用量限制，你很可能會用爆它  

## 簡介GitHub Action

### GitHub Repo Secrets

## 範例專案說明

### 環境變數傳遞

### 整個CD流程

### Commit推送至GitHub

### github action觸發: wangler打包並推送至cloudflare
