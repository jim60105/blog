+++
title = "WSL、PowerShell 設定備忘"
description = "WSL、PowerShell 設定備忘"
date = 2020-12-03T18:25:00.031Z
updated = 2022-09-29T04:54:20.744Z
draft = false
aliases = [ "/2020/12/wsl.html" ]

[taxonomies]
tags = [ ]

[extra]
banner = ""
+++
## 前言   

這篇是寫給自己看的，設定WSL時遇到的幾個坑

## 安裝相關

### 指南

**做完:** <https://learn.microsoft.com/zh-tw/windows/wsl/install-manual>

### 設定預設WSL

如果是從Docker安裝的WSL，那麼預設下`wsl`command時會進入Docker WSL中

列出所有WSL，確認預設

wsl -l

修改預設WSL

wsl -s

## 在Windows↔WSL間傳檔


### 由Windows中存取WSL檔案  


  在Explorer中開啟:
  \\wsl$\即可  
DistroName由`wsl -l`查詢 

### 由WSL存取Windows檔案 


直接存取 /mnt/


  Ref:
  <https://blog.miniasp.com/post/2020/07/26/Multiple-Linux-Dev-Environment-build-on-WSL-2>


##
  新版Powershell


### 安裝


  下載 `PowerShell-XXX-win-x64.msi`  
<https://github.com/PowerShell/PowerShell/releases/latest>


#### 取代Win + X的Windows Powershell  


  1. 在開始列搜尋 `Powershell` (原來的舊版)，開啟檔案位置，找到舊版捷徑路徑

  2. 在開始列搜尋 `pwsh` (新版)，找到新版的捷徑

  3. 將舊版的捷徑重命名為`Windows PowerShell v1.0`

  4. 將新版的捷徑複製到舊版捷徑路徑，重命名為`Windows PowerShell`


#### 取代檔案總管中「Shift+右鍵」→「在這裡開啟Powershell視窗」


> 免責  
> 我對這塊並沒有熟悉到能擔保不會改出問題  
> 請自行斟酌


  1. Win + R 開啟`regedit`

  2. 找到路徑 `\HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command`

  3. 取得權限修改它
   1. 「編輯」→「使用權限」→「進階」

     2. 擁有者修改為 `Administrators`

     3. 權限頁籤→新增

          1. 主體: 輸入你的Windows帳號

          2. 基本權限: 完全控制
   4. 確定退出

  
  4. 回到regedit，修改第二步之下的(預設值)  
將開頭的 `powershell.exe` 修改為 `pwsh.exe`，後方參數不改它
5. 確定，離開


## 字體相關 


  ### Powershell的字體設定方法


  * Win+X→Windows Powershell (系統管理員)

  * 在PS視窗標題上右鍵→「預設值」

  * 在PS視窗標題上右鍵→「內容」  
這兩個都要修改


###
  修改後字體在Loading時會瞬間改變、閃礫；由WSL使用vim時，字體會跳掉


修改登錄檔:

Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage]
"ACP"="1252"
"MACCP"="10000"
"OEMCP"="437"


  **然後重新啟動**   


  Ref:
  <https://github.com/microsoft/Terminal/issues/177#issuecomment-464416055>