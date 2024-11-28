+++
title = "[Koikatu] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) 個人插件介紹匯整"
description = "[Koikatu] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) 個人插件介紹匯整"
date = 2020-07-28T19:44:00.072Z
updated = 2023-05-19T14:01:59.489Z
draft = false
aliases = ["/2020/05/personal-koikatu-plugin.html"]

[taxonomies]
tags = ["Koikatu", "C#"]

[extra]
banner = "https://img.maki0419.com/blog/preview/CharaStudio-2019-12-22-14-45-35-Render.JPG"
+++
[![](https://img.maki0419.com/blog/preview/CharaStudio-2019-12-22-14-45-35-Render.JPG)](https://img.maki0419.com/blog/preview/CharaStudio-2019-12-22-14-45-35-Render.JPG)

(角色是我家的，但是原始Scene不是我做的)

> ※注意※
>
> 以下所有插件皆為BepInEx 5插件，且以Darkness為基準程式碼開發
>
>  
> 如果遇到安裝問題，請參考這篇  
> [ コイカツ! 插件安裝方式、問題判斷及排除指南](/2019/07/koikatu-install-and-debug-guide.html)  
>  
> 更新記錄請見  
> アップデートログはこちら  
> Click here for update logs  
> [\>> コイカツ！ 個人插件更新記錄 <<](/2020/05/koikatu-update-log.html)  

中文 日本語 English

## [服裝卡選擇性載入插件](/2019/03/koikatu-studio-coordinate-load-option.html)

載入服裝卡片時，可以選擇要載入的細項，包括飾品個別選擇  

## [Studio跨性別讀取](/2019/04/koikatu-studio-all-girls-plugin.html)

實現Studio跨性別替換角色功能  

[![](https://img.maki0419.com/blog/demo2.gif)](https://img.maki0419.com/blog/demo2.gif)

## [Studio女體單色化插件](/2019/04/koikatu-studio-simple-color-on-girls.html)

使女性支持單色化功能  

[![](https://img.maki0419.com/blog/demo3.gif)](https://img.maki0419.com/blog/demo3.gif)

## [Studio換人插件](/2019/05/koikatu-studio-chara-only-load-body.html)

保留衣服和飾品，只替換人物  

[![image](https://img.maki0419.com/blog/demo4.gif)](https://img.maki0419.com/blog/demo4.gif)

## [Studio IK→FK修正插件](/2019/05/koikatu-studio-reflect-fk-fix.html)

修正「IK→FK」功能會重置手勢和脖子的問題，並增加了一個複製當前脖子方向到FK「→FK(首)」的功能  

## [Studio文字插件](/2019/06/koikatu-studio-text-plugin.html)

在Studio內添加文字物件  

## [Studio自動關閉Scene載入視窗](/2019/07/koikatu-studio-auto-close-loading-scene-window.html)

Studio Load Scene視窗處，在Import或Load後可以自動關閉視窗  

[![image](https://img.maki0419.com/blog/demo7.png)](https://img.maki0419.com/blog/demo7.png)

## [插件清單工具](/2020/01/koikatubepinex-v5x-plugin-list-tool.html)

導出當前遊戲中**已加載的**BepInEx插件和IPA插件清單  

[![image](https://img.maki0419.com/blog/demo8.png)](https://img.maki0419.com/blog/demo8.png)

## [開門查水表！](/2020/01/koikatu-fbi-open-up.html)

此插件可依照原始角色，將她們向模板角色轉變。預設為蘿化，也可以用來做三頭身化。  

## [角色Overlay隨服裝變換](/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html)

讓所有角色Overlay(Iris、Face、Body Overlay)隨著服裝變更，反映在人物存檔和服裝存檔上  

## [PNG存檔尺寸調整工具](/2020/02/koikatubepinex-v5x-png-capture-size.html)

可調所有PNG存檔的拍照尺寸、調整Maker中的檔案選擇器顯示列數、放大Studio SceneData選擇器的選中預覧、給PNG存檔加上浮水印角標  

[![](https://img.maki0419.com/blog/demo11.png)](https://img.maki0419.com/blog/demo11.png)

[![](https://img.maki0419.com/blog/demo11-1.png)](https://img.maki0419.com/blog/demo11-1.png)

## [Studio千佳替換器](/2020/02/koikatubepinex-v5x-studio-studio-chika.html)

一鍵把Studio內的所有女角色都換成千佳(預設角色)，並保留原始人物的身形數據  

[![](https://img.maki0419.com/blog/demo12.gif)](https://img.maki0419.com/blog/demo12.gif)

## [Studio角色光綁定視角](/2020/03/koikatubepinex-v5x-studio-studio-chara.html)

將Studio角色光和視角間之旋轉值連動，詳見預覧對比  

## [Studio雙螢幕](/2020/03/koikatubepinex-v5x-studio-studio-dual.html)

啟用Studio的第二顯示器功能，**必需要有實體雙顯示器才能使用**
  
  
## [Studio儲存工作區順序修正](/2020/05/koikatubepinex-v5x-studio-studio-save.html)

以Studio的存檔邏輯，工作區中，在第一層之物件排序是以加入順序儲存 → 修改為以實際順序儲存  

[![](https://img.maki0419.com/blog/demo16.png)](https://img.maki0419.com/blog/demo16.png)

## [Studio角色覆寫腳本](/2020/05/koikatubepinex-v5x-studio-studio-body.html)

一鍵覆寫角色身體  

## [透明背景](/2020/05/koikatubepinex-v5x-transparent.html)

透明視窗和背景，可顯示和點擊視窗下的東西  

## [存檔壓縮](/2020/06/koikatubepinex-v5x-save-load-compression.html)

使用LZMA對CharaFile、CoordinateFile、Studio SceneData存檔做壓縮  

[![](https://img.maki0419.com/blog/demo18.png)](https://img.maki0419.com/blog/demo18.png)

## [服裝拍攝姿勢解鎖](/2020/06/koikatubepinex-v5x-coordinate-capture.html)

解除拍照服裝存檔時的姿勢限制  

[![](https://img.maki0419.com/blog/demo19.jpg)](https://img.maki0419.com/blog/demo19.jpg)

## [Studio選單跑馬燈](/2020/09/koikatu-studio-menu-scrolling-text.html)

在Studio的添加物品清單添加滾動顯示功能，並在分類清單顯示自訂文字  

## [りしれ供さ小](/2020/09/koikatu-what-are-you-saying.html)

本年度最無用作品，核心功能是讓你看不懂他們在說啥  

[![](https://img.maki0419.com/blog/demo21.png)](https://img.maki0419.com/blog/demo21.png)

## [Coordinate Load Option](/2019/03/koikatu-studio-coordinate-load-option.html)

衣裝データをロードするとき、アクセサリーの個別の選択を含む、ロードする詳細を選択できます。  

## [Studio Transgender Loading](/2019/04/koikatu-studio-all-girls-plugin.html)

これにより、Studio内のトランスジェンダーの役割置換機能を実現します。  

[![](https://img.maki0419.com/blog/demo2.gif)](https://img.maki0419.com/blog/demo2.gif)

## [Studio Simple Color On Girls](/2019/04/koikatu-studio-simple-color-on-girls.html)

女性がモノクロ機能をサポートできるようにします。   

[![](https://img.maki0419.com/blog/demo3.gif)](https://img.maki0419.com/blog/demo3.gif)

## [Studio Chara Only Load Body](/2019/05/koikatu-studio-chara-only-load-body.html)

服とアクセサリーをそのまま、キャラクターのみを変更できる  

[![image](https://img.maki0419.com/blog/demo4.gif)](https://img.maki0419.com/blog/demo4.gif)

## [Studio Reflect FK Fix](/2019/05/koikatu-studio-reflect-fk-fix.html)

「IK→FK」機能がジェスチャーと首をリセットする問題を修正しました、現在の首の方向をFK「→FK（首）」にコピーする機能を追加した。  

## [Studio Text Plugin](/2019/06/koikatu-studio-text-plugin.html)

Studioでテキストオブジェクトを追加します。  

## [Studio Auto Close Loading Scene Window](/2019/07/koikatu-studio-auto-close-loading-scene-window.html)

Studio Load Sceneウィンドウでは、インポートまたはロード後にウィンドウを自動的に閉じることができます。  

[![image](https://img.maki0419.com/blog/demo7.png)](https://img.maki0419.com/blog/demo7.png)

## [Plugin List Tool](/2020/01/koikatubepinex-v5x-plugin-list-tool.html)

導出當前遊戲中**已加載的**BepInEx插件和IPA插件清單  
現在のゲームに**読み込まれて**いるBepInExプラグインとIPAプラグインのリストをエクスポートします。  

[![image](https://img.maki0419.com/blog/demo8.png)](https://img.maki0419.com/blog/demo8.png)

## [FBI Open Up](/2020/01/koikatubepinex-v5x-fbi-open-up.html)

このプラグインは、元のキャラクターに合わせてテンプレートキャラクターに変更。 デフォルトはロリ化です。これは三頭身化を作成するためにも使用できます。  

## [Chara Overlays Based On Coordinate](/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html)

すべてのキャラクターオーバーレイ（アイリス、フェイス、ボディオーバーレイ）を衣装で変更し、キャラクターカードや衣装カードに反映させます  

## [PNG Capture Size Modifier](/2020/02/koikatubepinex-v5x-png-capture-size.html)

すべてのPNGアーカイブの写真サイズを調整し、Makerのファイルセレクターに表示される列の数を調整し、Studio SceneDataセレクターの選択したプレビューを拡大し、PNGアーカイブに透かしを追加します  

[![](https://img.maki0419.com/blog/demo11.png)](https://img.maki0419.com/blog/demo11.png)

[![](https://img.maki0419.com/blog/demo11-1.png)](https://img.maki0419.com/blog/demo11-1.png)

## [Studio Chika Replacer](/2020/02/koikatubepinex-v5x-studio-studio-chika.html)

ワンクリックでStudioのすべての女性キャラクターを千佳（デフォルトキャラクター）に変更し、オリジナルのフィギュアデータを保持します。  

[![](https://img.maki0419.com/blog/demo12.gif)](https://img.maki0419.com/blog/demo12.gif)

## [Studio Chara Light Linked To Camera](/2020/03/koikatubepinex-v5x-studio-studio-chara.html)

Studioキャラクターライトと視野角の間の回転値をリンクします。詳細については、プレビューの比較を参照してください。  

## [Studio Dual Screen](/2020/03/koikatubepinex-v5x-studio-studio-dual.html)

Studioのデュアルモニター機能を有効にします。 **使用するには2つのモニターが必要です。**
  
  
## [Studio Save Workspace Order Fix](/2020/05/koikatubepinex-v5x-studio-studio-save.html)

Studioのアーカイブロジックに基づいて、ワークスペースの最初のレイヤーのオブジェクトの順序は、追加の順序で格納されます→実際の順序で格納されるように変更されます。  

[![](https://img.maki0419.com/blog/demo16.png)](https://img.maki0419.com/blog/demo16.png)

## [Studio Body Overwrite Script](/2020/05/koikatubepinex-v5x-studio-studio-body.html)

ワンクリックでキャラクターのボディを上書き。  

## [Transparent Background](/2020/05/koikatubepinex-v5x-transparent.html)

透明なウィンドウと背景、ウィンドウの下にあるものを表示してクリックできます  

## [Save Load Compression](/2020/06/koikatubepinex-v5x-save-load-compression.html)

LZMAを使用して、CharaFile、CoordinateFile、Studio SceneDataアーカイブを圧縮します。  

[![](https://img.maki0419.com/blog/demo18.png)](https://img.maki0419.com/blog/demo18.png)

## [Coordinate Capture Pose Unlock](/2020/06/koikatubepinex-v5x-coordinate-capture.html)

衣装カード保存ファイルをキャプチャするときの姿勢制限を削除します。  

[![](https://img.maki0419.com/blog/demo19.jpg)](https://img.maki0419.com/blog/demo19.jpg)

## [Studio Menu Scrolling Text](/2020/09/koikatu-studio-menu-scrolling-text.html)

Studioでアイテムリストにスクロール表示機能と文字入力機能を実現しています。  

## [What are you saying?](/2020/09/koikatu-what-are-you-saying.html)

今年で最も役に立たないMOD、文字を読まないようにするだけ  

[![](https://img.maki0419.com/blog/demo21.png)](https://img.maki0419.com/blog/demo21.png)

## [Coordinate Load Option](/2019/03/koikatu-studio-coordinate-load-option.html)

When loads the coordinate card, you can select the details to be loaded, including the individual selection of accessories.  

## [Studio Transgender Loading](/2019/04/koikatu-studio-all-girls-plugin.html)

This will enable Studio transgender character replacement function.  

[![](https://img.maki0419.com/blog/demo2.gif)](https://img.maki0419.com/blog/demo2.gif)

## [Studio Simple Color On Girls](/2019/04/koikatu-studio-simple-color-on-girls.html)

To enable female to support the simple color function.  

[![](https://img.maki0419.com/blog/demo3.gif)](https://img.maki0419.com/blog/demo3.gif)

## [Studio Chara Only Load Body](/2019/05/koikatu-studio-chara-only-load-body.html)

Keep clothes and accessories and only replace characters.  

[![image](https://img.maki0419.com/blog/demo4.gif)](https://img.maki0419.com/blog/demo4.gif)

## [Studio Reflect FK Fix](/2019/05/koikatu-studio-reflect-fk-fix.html)

Fix the problem that the "IK→FK" function will reset gestures and neck, and add a function to copy the current neck direction to FK.  

## [Studio Text Plugin](/2019/06/koikatu-studio-text-plugin.html)

Add text objects in Studio.  

## [Studio Auto Close Loading Scene Window](/2019/07/koikatu-studio-auto-close-loading-scene-window.html)

In the Studio Load Scene window, the window can be automatically closed after Import or Load.  

[![image](https://img.maki0419.com/blog/demo7.png)](https://img.maki0419.com/blog/demo7.png)

## [Plugin List Tool](/2020/01/koikatubepinex-v5x-plugin-list-tool.html)

Export the **loaded** BepInEx plugin and IPA plugin list in the current game.  

[![image](https://img.maki0419.com/blog/demo8.png)](https://img.maki0419.com/blog/demo8.png)

## [FBI Open Up](/2020/01/koikatubepinex-v5x-fbi-open-up.html)

This plugin can change body to template chara according to the original chara. The default behavior is lolify, which can also be used to chibify.  

## [Chara Overlays Based On Coordinate](/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html)

Make all character's Overlay (Iris, Face, Body Overlay) change with the costume. Can be saved with character file and coordinate file.  

## [PNG Capture Size Modifier](/2020/02/koikatubepinex-v5x-png-capture-size.html)

You can adjust the capture size of save files, adjust the number of rows displayed by the file selector in Maker, enlarge the selected preview of the Studio SceneData selector, and add watermarks at corners.  

[![](https://img.maki0419.com/blog/demo11.png)](https://img.maki0419.com/blog/demo11.png)

[![](https://img.maki0419.com/blog/demo11-1.png)](https://img.maki0419.com/blog/demo11-1.png)

## [Studio Chika Replacer](/2020/02/koikatubepinex-v5x-studio-studio-chika.html)

One click to change all female characters to Chika (default chan) in Studio, and retain the original body data.  

[![](https://img.maki0419.com/blog/demo12.gif)](https://img.maki0419.com/blog/demo12.gif)

## [Studio Chara Light Linked To Camera](/2020/03/koikatubepinex-v5x-studio-studio-chara.html)

Link the rotation value between the Studio chara light and the viewing angle, see the preview comparison for details.

## [Studio Dual Screen](/2020/03/koikatubepinex-v5x-studio-studio-dual.html)

To enable Studio's second monitor function, **you must have two physical monitors to use it.**
  
  
## [Studio Save Workspace Order Fix](/2020/05/koikatubepinex-v5x-studio-studio-save.html)

Based on Studio's save file logic, the order of objects in the first layer in the workspace is stored in the order of addition → modified to be stored in the actual order.  

[![](https://img.maki0419.com/blog/demo16.png)](https://img.maki0419.com/blog/demo16.png)

## [Studio Body Overwrite Script](/2020/05/koikatubepinex-v5x-studio-studio-body.html)

Overwrite the character's body with one click.  

## [Transparent Background](/2020/05/koikatubepinex-v5x-transparent.html)

Transparent windows and backgrounds, can display and click things under the windows.  

## [Save Load Compression](/2020/06/koikatubepinex-v5x-save-load-compression.html)

Use LZMA to compress CharaFile, CoordinateFile, Studio SceneData save files.  

[![](https://img.maki0419.com/blog/demo18.png)](https://img.maki0419.com/blog/demo18.png)

## [Coordinate Capture Pose Unlock](/2020/06/koikatubepinex-v5x-coordinate-capture.html)

Remove the pose restriction when capturing the coordinate save file.  

[![](https://img.maki0419.com/blog/demo19.jpg)](https://img.maki0419.com/blog/demo19.jpg)

## [Studio Menu Scrolling Text](/2020/09/koikatu-studio-menu-scrolling-text.html)

Add scrolling display function to the list of add>>items in Studio, and display custom text in the category list.  

## [What are you saying?](/2020/09/koikatu-what-are-you-saying.html)

The most useless work of the year. The core function is to make you unable to read what they are saying.  

[![](https://img.maki0419.com/blog/demo21.png)](https://img.maki0419.com/blog/demo21.png)

中文 日本語 English