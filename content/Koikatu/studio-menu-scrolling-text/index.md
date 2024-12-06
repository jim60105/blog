+++
title = "[Koikatu] Studio 選單跑馬燈 (Studio Menu Scrolling Text)"
description = "Studio 物品清單新增跑馬燈功能；可在分類清單下顯示自訂文字，此功能設計讓 moder 顯示自訂訊息。"
date = 2020-09-05T15:51:00.019Z
updated = 2021-10-31T11:07:35.342Z
draft = false
aliases = [ "/2020/09/koikatu-studio-menu-scrolling-text.html" ]

[taxonomies]
tags = [ "Koikatu" ]

[extra]
card = "../preview/demo20.png"
+++

{{ video(url="/Koikatu/preview/demo20.mp4", alt="Studio Menu Scrolling Text video", controls=true, loop=true, autoplay=true, muted=true) }}

* 在 Studio 的添加物品內，群組清單和分類清單文字添加滾動顯示功能
* 滾動速度可在 Config 調節
* 可在分類清單前後顯示自訂文字，此功能設計讓 modder 顯示自訂訊息

## 自訂文字之說明

[![](/Koikatu/preview/demo20-1.png)](/Koikatu/preview/demo20-1.png)

* 撰寫 `.csv` 文件，名稱隨意
* 預設存放在 `根目錄\BepInEx\plugins\jim60105\KK_StudioMenuScrollingText` 之下，此路徑可在 Config 更改
* 此文件夾內的所有 \*.csv 文件都會讀入，不限單一文件的設定數量
* 格式和範例如下:  

  | 位置     | Group Number | 文字                                |  
  | ------ | ------------ | --------------------------------- |  
  | Before | 0            | !123123!                          |  
  | After  | 5555         | Some text or long long sentences. |

  * 位置: 控制此項顯示在清單首或是清單尾，填入「Before」或「After」
  * Group Number: 此文字之上層群組編號
  * 文字: 要顯示的文字內容
* 每個 Group 最多只能設定一組顯示文字
* 文字會是橘色，且無法點擊

## 需求依賴

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* **BepInEx v5.3 (不支援 v5.0.X)**

## 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下

## 下載位置

<https://cloud.maki0419.com/s/JMMy9EQf2G5gJDE>
