+++
title = "WSL、PowerShell 設定備忘"
description = "WSL、PowerShell 設定備忘"
date = 2020-12-03T18:25:00.031Z
updated = 2022-09-29T04:54:20.744Z
draft = false
aliases = [ "/2020/12/wsl.html" ]

[taxonomies]
tags = [ "System Admin" ]

[extra]
poor = true
+++

## 前言

這篇是寫給自己看的，設定 WSL 時遇到的幾個坑

## 安裝相關

### 指南

**做完:** <https://learn.microsoft.com/zh-tw/windows/wsl/install-manual>

### 設定預設 WSL

如果是從 Docker 安裝的 WSL，那麼預設下 `wsl` command 時會進入 Docker WSL 中

列出所有 WSL，確認預設

```powershell
wsl -l
```

修改預設 WSL

```powershell
wsl -s
```

## 在 Windows↔WSL 間傳檔

### 由 Windows 中存取 WSL 檔案

在 Explorer 中開啟: `\\wsl$\<DistroName>` 即可

DistroName 由 `wsl -l` 查詢

### 由 WSL 存取 Windows 檔案

直接存取 `/mnt/<DRIVE>`

Ref:
<https://blog.miniasp.com/post/2020/07/26/Multiple-Linux-Dev-Environment-build-on-WSL-2>

## 新版 Powershell

### 安裝

下載 `PowerShell-XXX-win-x64.msi`  
<https://github.com/PowerShell/PowerShell/releases/latest>

#### 取代 Win + X 的 Windows Powershell

1. 在開始列搜尋 `Powershell` (原來的舊版)，開啟檔案位置，找到舊版捷徑路徑

2. 在開始列搜尋 `pwsh` (新版)，找到新版的捷徑

3. 將舊版的捷徑重命名為 `Windows PowerShell v1.0`

4. 將新版的捷徑複製到舊版捷徑路徑，重命名為 `Windows PowerShell`

#### 取代檔案總管中「Shift + 右鍵」→「在這裡開啟 Powershell 視窗」

{% alert(caution=true) %}
我對這塊並沒有熟悉到能擔保不會改出問題  
請自行斟酌
{% end %}

1. Win + R 開啟 `regedit`
2. 找到路徑 `\HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command`
3. 取得權限修改它
    1. 「編輯」→「使用權限」→「進階」
    2. 擁有者修改為 `Administrators`
    3. 權限頁籤→新增
        1. 主體: 輸入你的Windows帳號
        2. 基本權限: 完全控制
    4. 確定退出
4. 回到 regedit，修改第二步之下的 (預設值)  
   將開頭的 `powershell.exe` 修改為 `pwsh.exe`，後方參數不改它
5. 確定，離開

## 字體相關

### Powershell 的字體設定方法

* Win+X→Windows Powershell **(系統管理員)**
* 在 PS 視窗標題上右鍵→「預設值」
* 在 PS 視窗標題上右鍵→「內容」  
  這兩個都要修改

### 修改後字體在 Loading 時會瞬間改變、閃礫；由 WSL 使用 vim 時，字體會跳掉

修改登錄檔:

```
Windows Registry Editor Version 5.00
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage]
"ACP"="1252"
"MACCP"="10000"
"OEMCP"="437"
```

然後**重新啟動**

Ref:
<https://github.com/microsoft/Terminal/issues/177#issuecomment-464416055>
