+++
title = "[Koikatu] 透明背景 (Transparent Background)"
description = "使 Koikatu 變為透明視窗和背景，可顯示和點擊視窗下的東西"
date = 2020-05-23T16:15:00.015Z
updated = 2021-10-31T11:11:57.159Z
draft = false
aliases = [ "/2020/05/koikatu-transparent-background.html" ]

[taxonomies]
tags = [ "Koikatu" ]

[extra]
banner = "../demo17.jpg"
+++

{{ youtube(id="1ooTUL_F4_s") }}

* 透明視窗和背景，可顯示和點擊視窗下的東西 (Click Through 功能)
* 可以在 Maker、H Scene、MainGame 和 Studio 使用
* 有 Coinfig 選項可以禁用「Click Through」功能，用在像捏人對照這種只需要看的場合。
* 會隱藏不在 CharaLayer 的東西 (像官方 Map 和某些 Studio 中的家具)
* 可調的 UI 透明功能
<!--more-->
## 注意

* **預設快捷鍵為「未設定」**，到 Config 設定後才能使用
* 限制:
  * 必須在**顯示卡設定**中禁用 MFAA 和 FXAA 功能，否則會導致黑背景
  * 不能在 Studio 中啟用「被写界深度」(景深) 功能
  * Graphics Settings Config 中，此兩項必須如此設定:  
    * Optimize in background: Disabled  
    * Run in background: Enabled
  * 在啟用插件功能後，**將遮罩非 CharaLayer (10) 層**。  
    也就是說，像內建 Map 和某些傢俱將會隱藏

## 小技巧

* 在點擊前**請注意滑鼠之狀態**
* 在按鍵盤前**先在遊戲內點擊一次**
* 因為遊戲的高負載，不建議讓其常駐桌面
* 若遇到視窗調整錯誤，請重啟遊戲
* 推薦搭配 **HideAllUI** 插件使用
* 使用遊戲外程式來拍攝截圖，像是 <kbd>PrtScn</kbd> 或其它螢幕攝影程式  
  (F9 和 F11 只會給你黑背景)
* 在創作時請多加儲存，我沒有辦法為遊戲的異常負責

## 其它提醒

* Studio:
  * 多數的「画面効果」都會導致問題，請小心啟用
  * 「2D 効果」中有一部份的物件不會運作
  * 某些不在 CharaLayer (10) 層的物品會被隱藏 (多數是傢俱)
* Maker:
  * Outline 邊線無法正常顯示出來
  * **不保證所有的顯示效果都會和平常的表現相同**

## 銘謝

**kirurobo** @ GitHub:  
感謝他的 **UniWinApi** 和 **CSharpWinApi** 專案  
這些是透明視窗所用到的核心技術  
<https://github.com/kirurobo/UniWinApiAsset>  
<https://github.com/kirurobo/CSharpWinApi>

一位 **2ch** 的匿名者:  
將這個酷炫的主意帶進 Koikatu 的人，透過 GOL 將此制作為了デスクトップマスコット (桌面寵物)

**サバカン**:  
編輯了前述的 script 為 DesktopMascot (桌面寵物) 並在 Discord 公開  
我是因他而受到了啟發

## Slide

<iframe src="https://www.slideshare.net/slideshow/embed_code/key/fpeD6d1EkPKe4N?startSlide=1" width="597" height="486" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px;max-width: 100%;" allowfullscreen></iframe>

## 需求依賴

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* **BepInEx v5.1 (不支援 v5.0.X)**
* BepisPlugins r15

## 安裝方式

* 將 \*.dll 放至「BepInEx/plugins/jim60105」資料夾之下

## 下載位置

<https://cloud.maki0419.com/s/wGJqAmqQACsfGk9>
