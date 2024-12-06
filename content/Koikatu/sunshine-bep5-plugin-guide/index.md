+++
title = "[Koikatsu Sunshine] コイカツ！サンシャイン 中文安裝指南"
description = "此篇文章旨在列出所有Koikatsu Sunshine插件清單，並簡單點上注意事項。(コイカツ！サンシャイン / 戀愛活動！陽光 / KKS / KKSunshine / Koikatu Sunshine)"
date = 2021-10-30T17:57:00.044Z
updated = 2021-10-30T17:57:00.044Z
draft = false
aliases = [ "/2021/08/koikatsu-sunshine-bep5-plugin-guide.html" ]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]

[extra]
card = "preview.png"
iscn = "iscn://likecoin-chain/rtxrL8i4xKTDgZw8blO709mJWa-KdzDxwEkVnG1xpIM/1"
trigger = "由於 イリュージョン 收攤，本文的官網連結已全數死去"
archive = """
本文已停更多年且不計劃再更新<br>
就結論來說，前作 <a href="@/Koikatu/bep5-plugin-guide/index.md">《コイカツ！》</a> 的熱度明顯高於本作品<br>
請優先考慮體驗前作"""
featured = true
hot = true
+++

<figure>
{{ image(url="preview.png", alt="官圖") }}
<figcaption>(官圖)</figcaption>
</figure>

## 序言

此篇文章旨在列出所有 Koikatsu Sunshine 的插件清單  
文章最後更新時間: 2021/10/31

安裝順序簡述如下:

1. 安裝主程式
2. 安裝所有免費、付費 DLC
3. 安裝所有必裝外掛
4. 安裝所需之其它外掛

官方 DLC 的模組基本上都沒有順序問題，設計上是分離檔案；程式部份可能會有覆寫狀況  
目前來說，Sunshine 各 DLC 在安裝順序上沒有區別

其它外掛我會盡量寫上前置依賴，除了列在必裝清單上的東西  
就是被太多東西依賴我才會列為必裝  
我就不再贅述，反正都給我必裝上去<!--more-->

## 主程式 + 各式 DLC 介紹

> 以下 DLC 都需要主程式才能遊玩
>
> 免費更新請在 CharaStudio 和 VR 之後覆蓋套用

* 主程式 + 付費 DLC: [DLsite](https://www.dlsite.com/pro/work/=/product%5Fid/VJ015725.html) (下載版、數位版)
* 免費 DLC:  
  官網：(要日本 IP)  
  <http://www.illusion.jp/preview/koikatsu%5Fsunshine/download.php>  
  <http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/download.php>  
  <http://www.illusion.jp/preview/charastudio/index.php#download>  
  <http://www.illusion.jp/preview/koikatsu%5Fsunshine/download%5Fvr.php>  
  分流: (免費更新: 2022/02/10；CharaStudio: 2021/09/21；VR: 2021/10/29)  
  <https://mega.nz/folder/98YkVTpa#6tzx99sDwQbcTw929uLG1w>  

  <figure>
  {{ image(url="UNInhXC.jpg", alt="使用方法") }}
  <figcaption>使用方法，圖片點擊放大</figcaption>
  </figure>

* 其他官方特典包:
  * コイカツ！サンシャイン 相關特典
    * [全ショップ共通予約特典 追加衣装 「乙姫 セット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine/yoyaku.php) (龍宮公主)
    * [オフィシャル予約特典 追加衣装 「妖精 セット」](https://www.illu-member.jp/shop/img/products/koikatu%5Fsun/fairy.jpg) (妖精)
    * [オフィシャル予約早期特典 「ケモミミセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun/yoyakucam/yoyakucam%5Fkoikatu%5Fsun02.jpg) (獸耳)
    * 非売品 コイカツ! サンシャイン 主題歌マキシ シングル CD 「青白コントラスト \ 榊原ゆい」 (音樂)
  * コイカツ！ サンシャイン エクステンション！相關特典
    * [全ショップ共通予約特典「マジックアカデミーセット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/yoyaku.php) (魔法學院制服?)
    * [オフィシャル予約特典 追加衣装「キョンシーセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun%5Fex/jiangshi.jpg) (中式殭屍)
    * [オフィシャル予約早期特典「わんこセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun%5Fex/yoyakucam/yoyakucam%5Fkoikatu%5Fsun%5Fex02.jpg) (狗狗)
    * [発売記念無料追加データ「桜満開セット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/download%5Fsc.php#c2) (櫻花主題的小裙子)

## 必裝外掛介紹

> 如果遇到安裝問題，請參考這篇  
> [コイカツ! 插件安裝方式、問題判斷及排除指南](@/Koikatu/install-and-debug-guide/index.md)

* [BepInEx v5.4.15](https://github.com/BepInEx/BepInEx/releases/tag/v5.4.15): 這是最基礎的外掛框架，有了它其他東西才會生效  
  這裡下載 BepInEx\_x64\_5.\*.zip 回來，把所有東西解壓進遊戲根目錄  
  然後在遊戲根目錄新增一個資料夾叫做 "mods"，裡面放後述的 sideloader mod

  [![image](/Koikatu/bep5-plugin-guide/2019-12-01%2016%2002%2032.png)](/Koikatu/bep5-plugin-guide/2019-12-01%2016%2002%2032.png)

  [![image](/Koikatu/bep5-plugin-guide/38600782_2052356328117301_4461874492536258560_o.jpg)](/Koikatu/bep5-plugin-guide/38600782%5F2052356328117301%5F4461874492536258560%5Fo.jpg)

* [BepisPlugins.r16.9](https://github.com/IllusionMods/BepisPlugins/releases/tag/r16.9): 搭配上面這個的基礎外掛包  
  下載 KKS\_BepisPlugins\_r\*.zip 回來後整個解壓進遊戲根目錄，建議參考壓縮檔資料夾結構放置，依賴後面提到的 XUnity.AutoTranslator  
  [![image](/Koikatu/bep5-plugin-guide/2019-11-03%2020%2019%2006.png)](/Koikatu/bep5-plugin-guide/2019-11-03%2020%2019%2006.png)
* [BepInEx.MessageCenter v1.1.1](https://github.com/BepInEx/BepInEx.Utility/releases/tag/r7): 將重要度為「Message」的訊息顯示在遊戲畫面頂端  
  將 BepInEx.MessageCenter\_v\*.zip 載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置
* [BepInEx.ConfigurationManager v16.3](https://github.com/BepInEx/BepInEx.ConfigurationManager/releases/tag/v16.3): 遊戲內設定修改器  
  將 BepInEx.ConfigurationManager\_v\*.zip 載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置
* Sideloader modpack: ~~由 DeathWeasel 整理~~ 改由 ScrewThisNoise 整理的 sideload mod 包

  > KKManager 中，「Sideloader Modpack」資料夾是 Koikatu 和 Koikatsu Sunshine 共用，其內容是相同的  
  > 可以由 Koikatu 將此資料夾拷貝過來 (或 mklink junction) 後再使用 KKManager 做更新，以節省時間、減輕伺服器負載

  1. 使用 [KKManager](#other_tools) 來做自動更新
  2. 由這個下載站取得:<https://sideload.betterrepack.com/>  
     此站內容 (作者說) 會和 KKManager 同步，這裡適合用來尋找單一 mod

  sideloader modpack 裡所有 mod 都是 sideloader mod (又稱 zipmod)  
  他可以是「.zipmod」或「.zip」格式，並可以被各種壓縮軟體打開  
  如果這個壓縮檔裡包含了 manifest.xml，那他就是一個 zipmod，把他放到 mods 文件夾下，不要解開  
  直接放置如圖左，可使用子資料夾  
  [![image](/Koikatu/bep5-plugin-guide/2019-01-06%2021%2006%2008.png)](/Koikatu/bep5-plugin-guide/2019-01-06%2021%2006%2008.png)

* [KKSAPI v1.28](https://github.com/IllusionMods/IllusionModdingAPI/releases/tag/v1.28): 超級多插件的依賴，他是一個遊戲的 API 介面，方便其它插件的開發作業  
  將 KKSAPI.v\*.zip 載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置  
  [![image](/Koikatu/bep5-plugin-guide/2019-11-03%2020%2025%2037.png)](/Koikatu/bep5-plugin-guide/2019-11-03%2020%2025%2037.png)
* [XUnity.AutoTranslator 4.20.0](https://github.com/bbepis/XUnity.AutoTranslator/releases/tag/v4.20.0) 機器翻譯  
  **就算不啟用也一定要安裝**，BepisPlugins/Sideloader 對他有依賴  
  下載 XUnity. AutoTranslator-BepIn-5x-\*.zip，解壓縮丟進遊戲根目錄  
  可依照以下步驟關閉機器翻譯:
  1. 啟動一次遊戲，讓插件產生 ini 設定檔案，進到主畫面後再關閉遊戲
  2. 用文字編輯器開啟「根目錄 \BepInEx\config\AutoTranslatorConfig.ini」
  3. 找到 \[TextFrameworks] 段落，將其下的選項全部改成 False  
     [![image](/Koikatu/bep5-plugin-guide/2019-11-03%2021%2035%2052.png)](/Koikatu/bep5-plugin-guide/2019-11-03%2021%2035%2052.png)
* [MoreAccessories\_v2.0.19](https://github.com/jalil49/MoreAccessories/releases/tag/2.0.19) 增加無限多的裝飾品洞  
  這是 jalil49 搬運並修改了 Joan6694 的插件所做出的新版本，它的目標是「翻修」並取代所有遊戲中舊的 MoreAccessories  
  它讓儲存架構變得更直覺，但也弄壞了不少東西，尤其是在和舊版本的兼容上  
  但既然 KKSAPI 依賴於它，你別無選擇  
  {{ch(body="順便說一句，這違反 Joan 的 License，請避免這麼做")}}

## 其他外掛介紹

> ※標有 ☆ 符號者為推薦外掛，如果想要正常讀別人的存檔，你最好安裝他們  
> (請善用 Ctrl+F 搜尋 ☆ 符號)

* [jim60105/KK](@/Koikatu/personal-koikatu-plugin/index.md) {{ch(body="對，這些是我寫 der")}}

  > 請到 [\[Koikatu\] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) 個人插件介紹匯整](@/Koikatu/personal-koikatu-plugin/index.md)  
  > 閱讀專門介紹頁
  
  * [Coordinate Load Option v1.3.1](@/Koikatu/coordinate-load-option/index.md)  
    載入服裝卡片時，可以選擇要載入的細項，包括飾品個別選擇
  * [Studio Transgender Loading v1.1.0](@/Koikatu/studio-transgender-loading/index.md)  
    實現 Studio 跨性別替換角色功能
  * ☆[Studio Simple Color On Girls v1.3.0](@/Koikatu/studio-simple-color-on-girls/index.md)  
    使女性支持單色化功能
  * [Studio Chara Only Load Body v1.4.2](@/Koikatu/studio-chara-only-load-body/index.md)  
    保留衣服和飾品，只替換人物
  * [Studio Reflect FK Fix v1.1.0](@/Koikatu/studio-reflect-fk-fix/index.md)  
    修正「IK→FK」功能會重置手勢和脖子的問題，並增加了一個複製當前脖子方向到 FK「→FK (首)」的功能
  * ☆[Studio Text Plugin v1.2.0](@/Koikatu/studio-text-plugin/index.md)  
    在 Studio 內添加文字物件
  * [Studio Auto Close Loading Scene Window v1.1.1](@/Koikatu/studio-auto-close-loading-scene-window/index.md)  
    Studio Load Scene 視窗處，在 Import 或 Load 後可以自動關閉視窗
  * [Plugin List Tool v1.1.0](@/Koikatu/plugin-list-tool/index.md)  
    導出當前遊戲中**已加載的** BepInEx 插件和 IPA 插件清單
  * [FBI Open Up v1.2.1](@/Koikatu/fbi-open-up/index.md)  
    此插件可依照原始角色，將她們向模板角色轉變。預設為蘿化，也可以用來做三頭身化。
  * [PNG Capture Size Modifier v1.6.1](@/Koikatu/png-capture-size-modifier/index.md)  
    可調所有 PNG 存檔的拍照尺寸、調整 Maker 中的檔案選擇器顯示列數、放大 Studio SceneData 選擇器的選中預覧、給 PNG 存檔加上浮水印角標
  * [Studio Chika Replacer v1.2.0](@/Koikatu/studio-chika-replacer/index.md)  
    一鍵把 Studio 內的所有女角色都換成千佳 (預設角色)，並保留原始人物的身形數據
  * [Studio Chara Light Linked To Camera v1.2.0](@/Koikatu/studio-chara-light-linked-to-camera/index.md)  
    將 Studio 角色光和視角間之旋轉值連動，詳見[預覧](@/Koikatu/studio-chara-light-linked-to-camera/index.md)對比
  * [Studio Dual Screen v1.2.0](@/Koikatu/studio-dual-screen/index.md)  
    啟用 Studio 的第二顯示器功能，**必需要有實體雙顯示器才能使用**
  * [Studio Save Workspace Order Fix v1.1.0](@/Koikatu/studio-save-workspace-order-fix/index.md)  
    以 Studio 的存檔邏輯，工作區中，在第一層之物件排序是以加入順序儲存 → 修改為以實際順序儲存
  * ☆[Save Load Compression v1.5.0](@/Koikatu/save-load-compression/index.md)  
    使用 LZMA 對 CharaFile、CoordinateFile、Studio SceneData 存檔做壓縮  
    提供網頁版壓縮 / 解壓縮工具:<https://slcweb.maki0419.com>
  * [Coordinate Capture Pose Unlock v1.1.0](@/Koikatu/coordinate-capture-pose-unlock/index.md)  
    解除拍照服裝存檔時的姿勢限制
* ☆[KKS\_UncensorSelector v3.11.4](https://github.com/IllusionMods/KK%5FPlugins#uncensorselector)
  (立體步兵補丁): 騎兵有馬，步兵 (ry)，和 kPlug 衝突
  * 安裝 [Koikatsu Overlay Mods 最新版本](https://github.com/ManlyMarco/Illusion-Overlay-Mods/releases/latest)
  * 下載 KKS\_UncensorSelector，解壓縮後整個丟進遊戲根目錄下
  * 由 [Sideloader Modpack] 中，將「Sideloader Modpack - KK\_UncensorSelector」資料夾下載下來，丟進「根目錄 \mods\」之下  
    [![image](/Koikatu/bep5-plugin-guide/uncensor.png)](/Koikatu/bep5-plugin-guide/uncensor.png)
  * 在 CharaMaker 裡的「身體 > 全體」選單下方可以選擇模組，設定完記得儲存卡片
  * 在 F1 裡可以設定「當角色 Uncensor 未設定」時要顯示的預設模組，也可以選擇「隨機 (Random)」選項  
    [![image](/Koikatu/bep5-plugin-guide/2019-03-16%2018%2051%2040.png)](/Koikatu/bep5-plugin-guide/2019-03-16%2018%2051%2040.png)
* [DeathWeasel1337/KK\_Plugins](https://github.com/DeathWeasel1337/KK%5FPlugins#kk%5Fplugins): 請下載 [2021/08/30 釋出的 KKS\_Plugins port](https://github.com/IllusionMods/KK%5FPlugins/releases/download/v201/KKS%5FPlugins.batch.zip)，然後再更新以下加了連結的更新版插件
  * [CharaMakerLoadedSound v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v210) Maker 載入完成時跳音效
  * [StudioSceneLoadedSound v1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) Studio Scene 載入完成時跳音效
  * ☆ForceHighPoly v1.2.2 強制遊戲全程使用高模。增加模型精細度，但是同時增加運行附載  
    ※正篇遊戲也會強制高模，**注意電腦附載**※
  * ReloadCharaListOnChange v1.5.2 在角色卡 / 衣服卡變更的時候重整遊戲內瀏覽器
  * ☆InvisibleBody v1.4 讓人透明，用來顯示沒人穿的衣服、配件，可以隨著存檔儲存隱形狀態
  * ☆[UncensorSelector v3.11.4](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 前面裝過的步兵外掛，可以為不同的角色選擇不同的步兵補丁，需要 KCOX
  * [Subtitles v2.3.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) H 場景和說話場景顯示字幕
  * [AnimationController v2.3](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 可以把 IK 節點綁定到運動物體，讓角色做非預設的動作~~建議改用 NodeConstraints~~ KKS 目前沒有 NodeConstraints
  * ☆[ClothingUnlocker v2.0.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 讓衣服男女通穿，以及解除某些不能同時穿的上下衣限制
  * EyeShaking v1.2 處女 H 中會視線顫抖
  * [PoseFolders v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 只要在「userdata/studio/pose」內新增資料夾，並把 pose 檔放進去，就會以資料夾顯示在 Studio 的 Pose 讀取清單
  * ☆[HairAccessoryCustomizer v1.1.6](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) CharaMaker 的頭髮飾品處，新增更多方便的調整功能
  * FreeHRandom v1.2 在 Free H 選項那裏新增隨機挑選按鈕
  * ☆Colliders v1.2 對地板、奶子、手和裙子添加碰撞器
  * ☆[MaterialEditor v3.1.10](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v208) 讓你可以編輯模型材質的細部屬性
  * [StudioObjectMoveHotkeys v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 以快捷鍵在 Studio 內移動物品，使用 Y/U/I 改變 X/Y/Z 軸數值，縮放時按 T 同時變更三軸
  * ☆[FKIK v1.1.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 可以同時啟動一部份的 FK 和 IK
  * [AnimationOverdrive v1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) Studio 裡的動作速度輸入框，支援輸入小於 1000 的數字
  * Character Export v1.0 可將遊戲內已載入的角色導出，例如 Studio 已載入的 Scene、主遊戲的學校內人物，快捷鍵是 Ctrl+E (和 Studio 提取工具的差別為，這是在遊戲內運作的插件，需要先成功載入角色才能導出)
  * HCharaAdjustment v2.0 H 戰鬥時微調角色位置，可以手動解決 % 蘿莉時縮雞雞問題，快捷鍵: O 第一女角、P 第二女角、I 男角、右 Ctrl 加上述按鍵重置位置 (可至 F1 更改熱鍵設定)
  * [StudioSceneSettings 1.3.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 隱藏擋在鏡頭和人物之間的地圖牆壁
  * ☆[Pushup v1.3.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 可以在穿奶罩時改變女性胸型
  * [PoseQuickLoad v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 在點選 Studio 的 Pose 時直接讀取，省去一個點 Load 按鈕的動作
  * ☆[StudioImageEmbed v1.0.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 將存檔中使用到的 bg、pattern、pattern\_thumb、frame 之圖片帶入存檔中，解決「必須有同一張圖片在該資料夾中才能讀取」的問題
  * MakerDefaults v1.0.1 設定進入 Maker 時的預設值，省去每次開啟 Maker 都要調一次姿勢、表情等
  * [StudioCustomMasking v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 可以將 MapMask 功能套用在以 Items 拼出的場景物件上，需要 StudioSceneSettings v1.2
  * ItemBlacklist v1.1 對捏人中的 item 縮圖按右鍵，將其從列表中隱藏
  * Profile v1.0.1 捏人中的加一個大文字框，讓你可以在其中編寫角色描述
  * [Autosave v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 每過幾分鐘就自動儲存
  * EyeControl v1.0.1 在角色上設定最大張眼數值，設定為零就會是個閉眼角色
  * ☆[AccessoryClothes v1.0.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 配合此插件做的飾品能像一般衣服，隨著身體彎曲，隨角色的滑塊變化而縮放等。也就是說，modder 現在能把衣服做成飾品了
  * [AccessoryQuickRemove v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v191) Maker 中按下 Delete 鍵刪除飾品
  * [DynamicBoneEditor v1.0.4](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 在 Maker 中修改飾品的 DynamicBone
  * [LightingTweaks v1.0.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 提高陰影分辨率以提高畫質，修復主遊戲和 Studio 之間陰影強度不匹配的問題  
    注意，個案出現把顯卡的 3D 運算效能炸到 100%，導致遊戲 FPS 剩下個位數，並拖垮整台電腦。
  * [MoreOutfits v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v215) 增加角色身上的服裝數量 (KKS 預設只有四套) 它可能跟任何會動到服裝的插件衝突
  * ~~[PoseUnlocker v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v197) Removes the gender restriction on saved Studio poses.~~ 這是 Studio Transgender Loading 已經內含的功能，如果你裝了就別裝這個。
  * [TwoLut v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v205) 讓你自由選擇 Studio 中的應用的兩個濾鏡 (原始設計中永遠有一個是昼)。並在濾鏡選單旁加「上一個 / 下一個」按鈕
* ☆[IllusionFixes v18.1](https://www.patreon.com/posts/illusionfixes-0-41216761)
  * CameraMaskResize
  * HairShadows 修正啟用「眼睛穿透前髮顯示」時，前髮無法照上影子的問題
  * Heterochromia 可以加載有不同類型的瞳孔，而不會重置它
  * MakerOptimizations 角色編輯器效能優化
  * ManifestCorrector 避免某些製作錯誤的 sideloader mod manifest 在故事模式造成的崩潰
  * NullChecks 移除程式內的部分錯誤 Null 值 (頭部飾品相關)
  * ResourceUnloadOptimizations 大幅度減少 Studio Scene 讀取時間，增進校園模式載入效能。如果 RAM 大於 16G 時，可以斟酌至設定關閉自動卸載資源功能 (以 RAM 空間換取讀取時間)
  * SettingsVerifier 啟動時檢查遊戲啟動器設定 (分辨率、全螢幕 / 視窗化等)
* [GraphicsSettings v1.2.1](https://github.com/BepInEx/BepInEx.GraphicsSettings/releases/tag/v1.2.1) 開啟更多的詳細畫面設定
* [BepInEx Utility r7](https://github.com/BepInEx/BepInEx.Utility/releases/tag/r7)
  * EnableFullScreenToggle v1.0 以 Alt+Enter 切換全螢幕
  * EnableResize v1.5 可以直接透過拖曳畫面邊角改變視窗大小
  * InputHotkeyBlock v1.4 打字時不會觸發快捷鍵
  * MessageCenter v1.1.1 將重要度為「Message」的訊息顯示在遊戲畫面頂端
  * MuteInBackground v1.1 在視窗失焦時自動靜音遊戲，功能需要在 Config 中啟用
  * CatchUnityEventExceptions v1.0 在常用之 UnityEngine events 上若發生 event handlers 報錯，也不會影響其它 hook 在同一個 event 上的 handler
  * SuppressGetTypesErrorsPatcher v1.0 處理在 Assembly.GetTypes () 上的 ReflectionTypeLoadException
  * OptimizeIMGUI v1.0 減少 Unity IMGUI (OnGUI) 顯示介面的不必要 GC 分配
* [KK\_BrowserFolders v2.6](https://www.patreon.com/posts/browserfolders-2-40644638) 讓選擇器支援子資料夾讀取
* [HideAllUI v2.3.2](https://github.com/IllusionMods/HideAllUI/releases/tag/v2.3.2) 隱藏 UI 介面 (預設: 空白鍵)
* ☆[DragAndDrop v1.2.6](https://github.com/IllusionMods/DragAndDrop/releases/tag/v1.2.6) 在載入圖檔時可以用視窗外拖曳檔案的方式。
  * 支援在 Studio、Maker、FreeH 拖入角色卡、場景卡、衣裝卡
  * 支援 Studio 拖入 Pose 存檔
  * Studio 中按著 Shift 拖入可為 import 功能  
    (Need to focus the game, hold shift, and drag a scene in. Doesn't work if you click outside of the game and then drag in!)
* ☆[Illusion Overlay Mods v6.0.4](https://www.patreon.com/posts/illusion-overlay-37785162) 在身體、衣服、眼睛上套用圖片，做客制化服裝者之必備插件
* ☆[ABMX V4.4.5](https://www.patreon.com/posts/37819916) 增加更多的捏角選項
* ☆[KK\_SkinEffects v2.0.1](https://www.patreon.com/posts/31646040) 增加幾個皮膚上效果 (流汗、流水、流血)，需要 Overlay Mods
* [KK\_ExpandMaleMaker v1.2](https://github.com/Kokaiinum/ExpandMaleMaker/releases/tag/1.2) 給男角色增加某些原本被限定在女編輯器才有的調整項，像是身高和 X 毛，需注意若大幅調整身高會導致 H 時錯位問題
* [QuickAccessBox v2.4.4](https://www.patreon.com/posts/quickaccessbox-2-38060886) Studio 中可以用關鍵字快速檢索 item
  * Left Control + Space 打開介面 (可至 F1 更改熱鍵設定)
  * 請閱讀[縮圖產生說明](https://github.com/ManlyMarco/QuickAccessBox#how-to-add-thumbnails-for-your-items)
  * 為使英文搜尋生效，請按以下步驟安裝:
    1. 請下載 [IllusionMods/KKS-Translation](https://github.com/IllusionMods/KKS-Translation/releases/latest) 最新 Release 的 KKS-Translation\_Release\_(日期).zip
    2. 此檔案解壓縮後，將其中位於「BepInEx\Translation\en\Text」之下的檔案複製至遊戲資料夾內相對位置
    3. 開啟 Studio 後靜待數秒讓第一次的自動翻譯完成 (請注意 Console Log)
* ☆[KKS\_MoreAccessoryParents v2.0](https://www.patreon.com/posts/24129495) 更多的裝飾品安裝基準點，需要 More\_Accessories v1.1.0
* [StudioAccessoryNames v1.1.1](https://www.patreon.com/posts/57369363) Studio 中，讓角色身上帶的飾品顯示具體名稱
* [MakerSearch v1.5](https://www.patreon.com/posts/55475679) 在 Maker 中可以做輸入搜尋
* [MakerRandomPicker v1.2.0](https://www.patreon.com/posts/55538871) 在 Maker 中每個類別窗上增加「Random」按鈕，可以做隨機套用
* [Better Color Picker v2.0.2](https://www.patreon.com/posts/33587860) 顏色設定時，選取調色盤外的顏色，可以直接去點其他衣服部位做同步
* [RemoveToRecycleBin v1.1.1](https://www.patreon.com/posts/33827361) 遊戲內刪除 \ 覆蓋角色卡、服裝卡、場景卡時會送入資源回收桶，避免瞬間丟失數據
* [Gameplay Mod v2.2](https://www.patreon.com/posts/39605273) 對主遊戲增加以下功能，和 kPlug 不相容
  * 上學人數上限由 38 升到 99
  * 能強上，但會讓她生氣
  * H Scene 用手時，可以不隱藏男角色的身體
  * [→其它](https://github.com/ManlyMarco/Koikatu-Gameplay-Mod/tree/master#some-of-the-features)
* [SliderHighlight v2.1.1](https://www.patreon.com/posts/44119450) 在捏人中高亮現正調整的滑桿位置，能清楚的知道你正在調整什麼部位。需要 ABMX
* [OrthographicCamera v1.1.2](https://www.patreon.com/posts/31909622) 按鍵 I 切換至平行視角相機
* [CharacterReplacer v1.6.3](https://github.com/IllusionMods/CharacterReplacer/releases/tag/1.6.3) 可以變更 Maker 預設角色，在 F1 裡頭設定
* [FPS Counter v3.1](https://www.patreon.com/posts/fps-counter-v3-0-35397322) 顯示遊戲 FPS
* [RimRemover v1.2](https://github.com/IllusionMods/RimRemover/releases/tag/v1.2) 移除遊戲中所有的輪廓光 (Rim Light)，需在 Config 啟用
* ☆[ModBoneImplantor v1.1.1](https://github.com/IllusionMods/ModBoneImplantor/releases/tag/v1.1.1) 對一些 mod 衣服添加骨骼
* ☆[ClothColliders v1.1](https://www.patreon.com/posts/35139324) 對一些 mod 衣服添加碰撞器
* [Koikatu ClothingStateMenu v3.1](https://www.patreon.com/posts/37378336) CharaMaker 中加上服裝狀態操作選單，可以半脫、隱藏身體，右下角可以勾選啟閉功能。和 ClothingStateMenuX 選一個用就好
* [AdvIKPlugin v1.6.5](https://github.com/OrangeSpork/AdvIKPlugin/releases/tag/1.6.5) 讓角色在 Studio IK 模式可以旋轉肩膀，做出更自然的動作
* ☆[VN\_Game\_Engine(VNGE) v32](https://mega.nz/#F!oiB2wAQK!ojGIzlAN-1B-263uUDEalQ!Jm5xAIbA)  VN 引擎，用來做文字選項遊戲和寫 Script，語言是 Python。  
  相關插件: 將相關插件檔案 (應為 \*.py 和一些附加內容) 放入 VNGE 的「Console\Lib\」目錄下
  * Scene Save State ([使用教學](https://mega.nz/#F!U2wADQRD!7Qzfk4D3qoU%5FZ0P26cgLLg)) 在 Scene 裡儲存角色狀態，讓你 \*\*\*\* 用同一個人物去改變動作、位置等，取代複數的同一人物，以減輕電腦負擔 \*\*。
  * VNText 這是 [Studio Text Plugin](@/Koikatu/studio-text-plugin/index.md) 的 VN Port
  * VNAnime 制作關鍵幀動畫
  * VNScene 制作 VN (Virtual Novel)
  * Pose, Face, Status, Hands libraries 以標籤、群組分類保存 Pose 等等
  * Body and Face sliders 可以在 Studio 中簡單的修改角色身型數值  
    \== 以上內建在 VNGE 中 ==
  * [MMD Director v2.2.1](https://mega.nz/folder/NQhG3IjA#rwyaVwE0O1t3pJe5Fefv2Q) ([ZOD 發布帖和說明、教學](https://zodgame.xyz/forum.php?mod=viewthread\&tid=235560)) 定位為 MMD 製作工具，不僅是播放 VMD 動作，而且能夠編輯關鍵幀並協調場景內的其他道具
* [BepInEx Debug tools r9](https://github.com/BepInEx/BepInEx.Debug/releases/tag/r9) 插件開發工具，絕對只有開發者會需要這些。務必閱讀[詳細說明](https://github.com/BepInEx/BepInEx.Debug#tools-in-this-repo)
  * DemystifyExceptions 將錯誤日誌改為易讀的格式
  * ScriptEngine 從「BepInEx\scripts」文件夾中加載和重新加載 BepInEx 插件。可以通過在配置中定義的鍵盤快捷方式重新加載。預設的快捷鍵是 F6。
  * Startup Profiler 記錄各插件啟動時各階段的時間消耗
  * Simple Mono Profiler 看似也是時間記錄相關，明寫了會影響效能
  * MirrorInternalLogs 用以導出 Unity 內部的 log
  * CtorShotgun 用來判斷 class 初始化順序的工具
* ☆[CheatTools v3.0](https://www.patreon.com/posts/37889909) 遊戲作弊器，裡面有解鎖 FreeH 所有體位、修改 MainGame 女角數值等功能。快捷是 Pause，需要 Runtime Unity Editor v2.5
* ☆[Runtime Unity Editor v2.5 遊戲修改器](https://www.patreon.com/posts/33966766)
* ☆[PregnancyPlus v5.2](https://github.com/thojmr/KK%5FPregnancyPlus#how-to-install) 懷孕 +，比 KK\_Pregnancy 做更細微的形狀調整。它是配合 KK\_Pregnancy 開發的，兩插件不衝突，請同時使用。
* ☆[Expression\_Control\_v0.2.6](https://mega.nz/file/VsgiGDwb#bCCdHHlzuhQcF4kkvbrtfOMJAOTwATS0b91ign-bzbk) 按 L 快速調整角色表情  
  此為來自 upillusion0498 的 KKS 移植版，原作者為 [56e4\_xXVv](https://ux.getuploader.com/56e4%5FxXVv/download/93)

## 其他工具 {#other_tools}

* ☆[Koikatu KKManager v0.18](https://www.patreon.com/posts/kkmanager-v0-14-41869238) Koikatu 的人物卡和 mod 管理器，支援 sideloader mod 的自動更新
* [Plugin Data Reader](https://plugindatareader.maki0419.com/) 此工具網站可以檢查角色卡所使用的 plugin 和 mod
* [Card Image Replacer v1.0](https://www.patreon.com/posts/32927543) PNG 存檔圖片替換器，請務必詳閱說明
* ~~[MinUnity3D](https://github.com/kkdevs/MinUnity3D/releases) 用這工具可以大幅降低整體檔案大小還有 RAM 的消耗量，對 abdata 執行~~KK Manager 已內建此功能
* ~~[Unity3D file compression script](https://www.patreon.com/posts/unity3d-file-28988648) 此工具功能同上者，注意閱讀使用說明~~KK Manager 已內建此功能
* [KK キャラ抽出改変 ver1.2.3](https://mega.nz/folder/Fx5ikKzR#KsrxZ2VN939UHukgHKqeCA) ([uppervolta 發布](http://uppervolta-3d.net/illu/upload.php?id=0550)) Scene 中 Chara 之複數提取器

## 相關網站

* 官網 {{cr(body="已全數死去")}}
  * Illusion: <http://www.illusion.jp/>
  * コイカツ！サンシャイン: <http://www.illusion.jp/preview/koikatsu%5Fsunshine/index.php>
  * CharaStudio: <http://www.illusion.jp/preview/charastudio/index.php>
  * 角色交換站: <http://upks.illusion.jp/list/chara> (要日本 IP)
  * SceneData 交換站: <http://upks.illusion.jp/list/scene> (要日本 IP)
* コイカツ！(中文) - Discord 伺服器  
  [![](/Koikatu/bep5-plugin-guide/join.png#no-hover)](https://discord.gg/UJEA9nr)
* Koikatsu! 英文 Discord 伺服器  
  <https://discord.gg/hevygx6>
* ZODGAME 論壇 - 恋活！Sunshine 版 (需邀請註冊)  
  <https://zodgame.xyz/forum.php?mod=forumdisplay&fid=127>
* uppervolta-3d (要日本 IP)  
  <http://uppervolta-3d.net/illu/upload.php>

## 人權

[![image](2021-08-31%2002%2051%2044.png)](2021-08-31%2002%2051%2044.png)

[![image](2023-07-16%2019%2049%2046.png)](2023-07-16%2019%2049%2046.png)

[![image](KKS.jpg)](KKS.jpg)
