+++
title = "[Koikatsu Sunshine] コイカツ！サンシャイン 中文安裝指南"
description = "[Koikatsu Sunshine] コイカツ！サンシャイン 中文安裝指南"
date = 2021-10-30T17:57:00.044Z
updated = 2023-07-17T09:12:26.838Z
draft = false
aliases = ["/2021/08/koikatsu-sunshine-bep5-plugin-guide.html"]

[taxonomies]
tags = ["Koikatu"]

[extra]
banner = "https://img.maki0419.com/blog/preview/kks_main0827b.png"
+++
> ※注意※  
> 圖片都是舊版的，請看個示意就好  
> 目前KKS各種小bug各種不穩，玩玩是可以，但別用來搞創作

| [![](https://img.maki0419.com/blog/preview/kks_main0827b.png)](https://img.maki0419.com/blog/preview/kks%5Fmain0827b.png) |
| ------------------------------------------------------------------------------------------------------------------------- |
| (官圖)                                                                                                                      |

## 序言

此篇文章旨在列出所有Koikatsu Sunshine的插件清單，將會定期更新  
現時點各插件作者都在做更新，此清單並不完整  
文章最後更新時間:2021/10/31

安裝順序簡述如下:
1. 安裝主程式
2. 安裝所有免費、付費DLC
3. 安裝所有必裝外掛
4. 安裝所需之其它外掛

官方DLC的模組基本上都沒有順序問題，設計上是分離檔案；程式部份可能會有覆寫狀況  
目前來說，Sunshine各DLC在安裝順序上沒有區別

其它外掛我會盡量寫上前置依賴，除了列在必裝清單上的東西  
就是被太多東西依賴我才會列為必裝  
我就不再贅述，反正都給我必裝上去

## 主程式+各式DLC介紹

> 以下DLC都需要主程式才能遊玩
>
> 免費更新請在CharaStudio和VR之後覆蓋套用

* 主程式+付費DLC: [DLsite](https://www.dlsite.com/pro/work/=/product%5Fid/VJ015725.html) (下載版、數位版)
* 免費DLC:  
官網:(要日本IP)  
<http://www.illusion.jp/preview/koikatsu%5Fsunshine/download.php>  
<http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/download.php>  
<http://www.illusion.jp/preview/charastudio/index.php#download>  
<http://www.illusion.jp/preview/koikatsu%5Fsunshine/download%5Fvr.php>  
分流: (免費更新: 2022/02/10；CharaStudio: 2021/09/21；VR: 2021/10/29)  
<https://mega.nz/folder/98YkVTpa#6tzx99sDwQbcTw929uLG1w>  
| [![](https://img.maki0419.com/blog/UNInhXC.jpg)](https://img.maki0419.com/blog/UNInhXC.jpg) |  
| ------------------------------------------------------------------------------------------- |  
| <https://imgur.com/UNInhXC>使用方法，圖片點擊放大                                                      |
* 其他官方特典包:
   * コイカツ！サンシャイン 相關特典
      * [全ショップ共通予約特典 追加衣装 「乙姫 セット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine/yoyaku.php) (龍宮公主)
      * [オフィシャル予約特典 追加衣装 「妖精 セット」](https://www.illu-member.jp/shop/img/products/koikatu%5Fsun/fairy.jpg) (妖精)
      * [オフィシャル予約早期特典 「ケモミミセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun/yoyakucam/yoyakucam%5Fkoikatu%5Fsun02.jpg) (獸耳)
      * 非売品 コイカツ! サンシャイン 主題歌マキシ シングルCD 「青白コントラスト \\ 榊原ゆい」 (音樂)
   * コイカツ！ サンシャイン エクステンション！相關特典
      * [全ショップ共通予約特典「マジックアカデミーセット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/yoyaku.php) (魔法學院制服?)
      * [オフィシャル予約特典 追加衣装「キョンシーセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun%5Fex/jiangshi.jpg) (中式殭屍)
      * [オフィシャル予約早期特典「わんこセット」](https://dlshop.illu-member.jp/user%5Fdata/packages/illusion/img/products/koikatu%5Fsun%5Fex/yoyakucam/yoyakucam%5Fkoikatu%5Fsun%5Fex02.jpg) (狗狗)
      * [発売記念無料追加データ「桜満開セット」](http://www.illusion.jp/preview/koikatsu%5Fsunshine%5Fex/download%5Fsc.php#c2) (櫻花主題的小裙子)

## 必裝外掛介紹

> 如果遇到安裝問題，請參考這篇  
> [コイカツ! 插件安裝方式、問題判斷及排除指南](https://blog.maki0419.com/2019/07/koikatu.html)

* [BepInEx v5.4.15](https://github.com/BepInEx/BepInEx/releases/tag/v5.4.15): 這是最基礎的外掛框架，有了它其他東西才會生效  
這裡下載BepInEx\_x64\_5.\*.zip回來，把所有東西解壓進遊戲根目錄  
然後在遊戲根目錄新增一個資料夾叫做 "mods"，裡面放後述的sideloader mod  
[![image](https://img.maki0419.com/blog/2019-12-01%2016%2002%2032.png)](https://img.maki0419.com/blog/2019-12-01%2016%2002%2032.png)  
    
[![image](https://img.maki0419.com/blog/38600782_2052356328117301_4461874492536258560_o.jpg)](https://img.maki0419.com/blog/38600782%5F2052356328117301%5F4461874492536258560%5Fo.jpg)
* [BepisPlugins.r16.9](https://github.com/IllusionMods/BepisPlugins/releases/tag/r16.9): 搭配上面這個的基礎外掛包  
下載KKS\_BepisPlugins\_r\*.zip回來後整個解壓進遊戲根目錄，建議參考壓縮檔資料夾結構放置，依賴後面提到的[XUnity.AutoTranslator](#XUnity%5FAutoTranslator)  
[![image](https://img.maki0419.com/blog/2019-11-03%2020%2019%2006.png)](https://img.maki0419.com/blog/2019-11-03%2020%2019%2006.png)
* [BepInEx.MessageCenter v1.1.1](https://github.com/BepInEx/BepInEx.Utility/releases/tag/r7): 將重要度為「Message」的訊息顯示在遊戲畫面頂端  
將BepInEx.MessageCenter\_v\*.zip載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置
* [BepInEx.ConfigurationManager v16.3](https://github.com/BepInEx/BepInEx.ConfigurationManager/releases/tag/v16.3): 遊戲內設定修改器  
將BepInEx.ConfigurationManager\_v\*.zip載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置
* Sideloader modpack [^](#sideloader%5Fmodpack):~~由DeathWeasel整理~~ 改由ScrewThisNoise整理的sideload mod包  
> KKManager中，「Sideloader Modpack」資料夾是Koikatu和Koikatsu Sunshine共用，其內容是相同的  
> 可以由Koikatu將此資料夾拷貝過來(或mklink junction)後再使用KKManager做更新，以節省時間、減輕伺服器負載  
   1. 使用[KKManager](#other%5Ftools)來做自動更新  
   2. 從此[Google Drive](https://drive.google.com/drive/folders/1j1ZH7WunkEqvwr2YDLDF7JyutlzuyZDX)下載  
    請注意，GDrive的更新時程並不明確，可能會不同步。  
   3. 由這個下載站取得:<https://sideload.betterrepack.com/>  
    此站內容(作者說)會和KKManager同步，這裡適合用來尋找單一mod  
> 建議先從GDrive下載全部，再由KKManager做更新  
> 之後更新以KKManager為主  
sideloader modpack裡所有mod都是sideloader mod(又稱zipmod)  
他可以是「.zipmod」或「.zip」格式，並可以被各種壓縮軟體打開  
如果這個壓縮檔裡包含了manifest.xml，那他就是一個zipmod，把他放到mods文件夾下，不要解開  
直接放置如圖左，可使用子資料夾  
[![image](https://img.maki0419.com/blog/2019-01-06%2021%2006%2008.png)](https://img.maki0419.com/blog/2019-01-06%2021%2006%2008.png)
* [KKSAPI v1.28](https://github.com/IllusionMods/IllusionModdingAPI/releases/tag/v1.28): 超級多插件的依賴，他是一個遊戲的API介面，方便其它插件的開發作業  
將KKSAPI.v\*.zip載回來以後解壓縮丟進遊戲根目錄，建議參考壓縮檔資料夾結構放置  
[![image](https://img.maki0419.com/blog/2019-11-03%2020%2025%2037.png)](https://img.maki0419.com/blog/2019-11-03%2020%2025%2037.png)
* [XUnity.AutoTranslator 4.20.0](https://github.com/bbepis/XUnity.AutoTranslator/releases/tag/v4.20.0) [^](#XUnity%5FAutoTranslator) 機器翻譯  
**就算不啟用也一定要安裝**，BepisPlugins/Sideloader對他有依賴  
下載XUnity. AutoTranslator\-BepIn-5x\-\*.zip，解壓縮丟進遊戲根目錄  
可依照以下步驟關閉機器翻譯:
   1. 啟動一次遊戲，讓插件產生ini設定檔案，進到主畫面後再關閉遊戲
   2. 用文字編輯器開啟「根目錄\\BepInEx\\config\\AutoTranslatorConfig.ini」
   3. 找到\[TextFrameworks\]段落，將其下的選項全部改成False  
   [![image](https://img.maki0419.com/blog/2019-11-03%2021%2035%2052.png)](https://img.maki0419.com/blog/2019-11-03%2021%2035%2052.png)
* [MoreAccessories\_v2.0.19](https://github.com/jalil49/MoreAccessories/releases/tag/2.0.19) 增加無限多的裝飾品洞  
這是jalil49搬運並修改了Joan6694的插件所做出的新版本，它的目標是「翻修」並取代所有遊戲中舊的MoreAccessories  
它讓儲存架構變得更直覺，但也弄壞了不少東西，尤其是在和舊版本的兼容上  
但既然KKSAPI依賴於它，你別無選擇  
順便說一句，這違反Joan的License，請避免這麼做

## 其他外掛介紹

> ※標有☆符號者為推薦外掛，如果想要正常讀別人的存檔，你最好安裝他們  
> (請善用Ctrl+F搜尋☆符號)

* [jim60105/KK](/2020/05/personal-koikatu-plugin.html) 對，這些是我寫der  
> 請到[\[Koikatu\] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) 個人插件介紹匯整](/2020/05/personal-koikatu-plugin.html)  
> 閱讀專門介紹頁
   * [Coordinate Load Option v1.3.1](/2019/03/koikatu-coordinate-load-option.html)  
   載入服裝卡片時，可以選擇要載入的細項，包括飾品個別選擇
   * [Studio Transgender Loading v1.1.0](/2019/04/koikatu-studio-transgender-loading.html)  
   實現Studio跨性別替換角色功能
   * ☆[Studio Simple Color On Girls v1.3.0](/2019/04/koikatu-studio-simple-color-on-girls.html)  
   使女性支持單色化功能
   * [Studio Chara Only Load Body v1.4.2](/2019/05/koikatu-studio-chara-only-load-body.html)  
   保留衣服和飾品，只替換人物
   * [Studio Reflect FK Fix v1.1.0](/2019/05/koikatu-studio-reflect-fk-fix.html)  
   修正「IK→FK」功能會重置手勢和脖子的問題，並增加了一個複製當前脖子方向到FK「→FK(首)」的功能
   * ☆[Studio Text Plugin v1.2.0](/2019/06/koikatu-studio-text-plugin.html)  
   在Studio內添加文字物件
   * [Studio Auto Close Loading Scene Window v1.1.1](/2019/07/koikatu-studio-auto-close-loading-scene-window.html)  
   Studio Load Scene視窗處，在Import或Load後可以自動關閉視窗
   * [Plugin List Tool v1.1.0](/2020/01/koikatu-plugin-list-tool.html)  
   導出當前遊戲中**已加載的**BepInEx插件和IPA插件清單
   * [FBI Open Up v1.2.1](/2020/01/koikatu-fbi-open-up.html)  
   此插件可依照原始角色，將她們向模板角色轉變。預設為蘿化，也可以用來做三頭身化。
   * [PNG Capture Size Modifier v1.6.1](/2020/02/koikatu-png-capture-size-modifier.html)  
   可調所有PNG存檔的拍照尺寸、調整Maker中的檔案選擇器顯示列數、放大Studio SceneData選擇器的選中預覧、給PNG存檔加上浮水印角標
   * [Studio Chika Replacer v1.2.0](/2020/02/koikatu-studio-chika-replacer.html)  
   一鍵把Studio內的所有女角色都換成千佳(預設角色)，並保留原始人物的身形數據
   * [Studio Chara Light Linked To Camera v1.2.0](/2020/03/koikatu-studio-chara-light-linked-to-camera.html)  
   將Studio角色光和視角間之旋轉值連動，詳見[預覧](/2020/03/koikatu-studio-chara-light-linked-to-camera.html)對比
   * [Studio Dual Screen v1.2.0](/2020/03/koikatu-studio-dual-screen.html)  
   啟用Studio的第二顯示器功能，**必需要有實體雙顯示器才能使用**
   * [Studio Save Workspace Order Fix v1.1.0](/2020/05/koikatu-studio-save-workspace-order-fix.html)  
   以Studio的存檔邏輯，工作區中，在第一層之物件排序是以加入順序儲存 → 修改為以實際順序儲存
   * ☆[Save Load Compression v1.5.0](/2020/06/koikatu-save-load-compression.html)  
   使用LZMA對CharaFile、CoordinateFile、Studio SceneData存檔做壓縮  
    提供網頁版壓縮/解壓縮工具:<https://slcweb.maki0419.com>
   * [Coordinate Capture Pose Unlock v1.1.0](/2020/06/koikatu-coordinate-capture-pose-unlock.html)  
   解除拍照服裝存檔時的姿勢限制
* ☆[KKS\_UncensorSelector v3.11.4](https://github.com/IllusionMods/KK%5FPlugins#uncensorselector)
(立體步兵補丁)[^](#UncensorSelector): 騎兵有馬，步兵(ry)，和kPlug衝突
   * 安裝[Koikatsu Overlay Mods最新版本](https://github.com/ManlyMarco/Illusion-Overlay-Mods/releases/latest)
   * 下載KKS\_UncensorSelector，解壓縮後整個丟進遊戲根目錄下
   * 由[Sideloader Modpack](#sideloader%5Fmodpack)中，將「Sideloader Modpack - KK\_UncensorSelector」資料夾下載下來，丟進「根目錄\\mods\\」之下  
   [![image](https://img.maki0419.com/blog/uncensor.png)](https://img.maki0419.com/blog/uncensor.png)
   * 在CharaMaker裡的「身體>全體」選單下方可以選擇模組，設定完記得儲存卡片
   * 在F1裡可以設定「當角色Uncensor未設定」時要顯示的預設模組，也可以選擇「隨機(Random)」選項  
   [![image](https://img.maki0419.com/blog/2019-03-16%2018%2051%2040.png)](https://img.maki0419.com/blog/2019-03-16%2018%2051%2040.png)
* [DeathWeasel1337/KK\_Plugins](https://github.com/DeathWeasel1337/KK%5FPlugins#kk%5Fplugins):請下載[2021/08/30釋出的KKS\_Plugins port](https://github.com/IllusionMods/KK%5FPlugins/releases/download/v201/KKS%5FPlugins.batch.zip)，然後再更新以下加了連結的更新版插件  
   * [CharaMakerLoadedSound v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v210) Maker載入完成時跳音效  
   * [StudioSceneLoadedSound v1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) Studio Scene載入完成時跳音效  
   * ☆ForceHighPoly v1.2.2 強制遊戲全程使用高模。增加模型精細度，但是同時增加運行附載  
    ※正篇遊戲也會強制高模，**注意電腦附載**※  
   * ReloadCharaListOnChange v1.5.2 在角色卡/衣服卡變更的時候重整遊戲內瀏覽器  
   * ☆InvisibleBody v1.4 讓人透明，用來顯示沒人穿的衣服、配件，可以隨著存檔儲存隱形狀態  
   * ☆[UncensorSelector v3.11.4](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 前面裝過的步兵外掛，可以為不同的角色選擇不同的步兵補丁，需要KCOX  
   * [Subtitles v2.3.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) H場景和說話場景顯示字幕  
   * [AnimationController v2.3](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 可以把IK節點綁定到運動物體，讓角色做非預設的動作~~建議改用NodeConstraints~~ KKS目前沒有NodeConstraints  
   * ☆[ClothingUnlocker v2.0.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 讓衣服男女通穿，以及解除某些不能同時穿的上下衣限制  
   * EyeShaking v1.2 處女H中會視線顫抖  
   * RandomCharacterGenerator v2.0 在CharaMaker中，可以產生隨機角色  
   * [PoseFolders v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 只要在「userdata/studio/pose」內新增資料夾，並把pose檔放進去，就會以資料夾顯示在Studio的Pose讀取清單  
   * ☆ListOverride v1.0 覆蓋官方列表文件，像是可以為一些官方連褲襪提供半脫狀態  
   * ☆[HairAccessoryCustomizer v1.1.6](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) CharaMaker的頭髮飾品處，新增更多方便的調整功能  
   * FreeHRandom v1.2 在Free H選項那裏新增隨機挑選按鈕  
   * ☆Colliders v1.2 對地板、奶子、手和裙子添加碰撞器  
   * ☆[MaterialEditor v3.1.10](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v208) 讓你可以編輯模型材質的細部屬性  
   * MaleJuice v1.2.2 你現在也可以在H和Studio中讓男孩子髒髒  
   * [StudioObjectMoveHotkeys v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 以快捷鍵在Studio內移動物品，使用Y/U/I改變X/Y/Z軸數值，縮放時按T同時變更三軸  
   * ☆[FKIK v1.1.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 可以同時啟動一部份的FK和IK  
   * [AnimationOverdrive v1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) Studio裡的動作速度輸入框，支援輸入小於1000的數字  
   * Character Export v1.0 可將遊戲內已載入的角色導出，例如Studio已載入的Scene、主遊戲的學校內人物，快捷鍵是Ctrl+E(和Studio提取工具的差別為，這是在遊戲內運作的插件，需要先成功載入角色才能導出)  
   * HCharaAdjustment v2.0 H戰鬥時微調角色位置，可以手動解決%蘿莉時縮雞雞問題，快捷鍵: O第一女角、P第二女角、I男角、右Ctrl加上述按鍵重置位置(可至F1更改熱鍵設定)  
   * [StudioSceneSettings 1.3.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 隱藏擋在鏡頭和人物之間的地圖牆壁  
   * ☆[Pushup v1.3.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 可以在穿奶罩時改變女性胸型  
   * [PoseQuickLoad v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 在點選Studio的Pose時直接讀取，省去一個點Load按鈕的動作  
   * ☆[StudioImageEmbed v1.0.2](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 將存檔中使用到的bg、pattern、pattern\_thumb、frame之圖片帶入存檔中，解決「必須有同一張圖片在該資料夾中才能讀取」的問題  
   * MakerDefaults v1.0.1 設定進入Maker時的預設值，省去每次開啟Maker都要調一次姿勢、表情等  
   * [StudioCustomMasking v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 可以將MapMask功能套用在以Items拼出的場景物件上，需要StudioSceneSettings v1.2  
   * ItemBlacklist v1.1 對捏人中的item縮圖按右鍵，將其從列表中隱藏  
   * FadeAdjuster v1.0 允許您調整淡入淡出的顏色或禁用淡入和淡出效果  
   * Profile v1.0.1 捏人中的加一個大文字框，讓你可以在其中編寫角色描述  
   * [Autosave v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 每過幾分鐘就自動儲存  
   * EyeControl v1.0.1 在角色上設定最大張眼數值，設定為零就會是個閉眼角色  
   * ☆[AccessoryClothes v1.0.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v206) 配合此插件做的飾品能像一般衣服，隨著身體彎曲，隨角色的滑塊變化而縮放等。也就是說，modder現在能把衣服做成飾品了  
   * [AccessoryQuickRemove v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v191) Maker中按下Delete鍵刪除飾品  
   * [DynamicBoneEditor v1.0.4](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v203) 在Maker中修改飾品的DynamicBone  
   * [LightingTweaks v1.0.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v207) 提高陰影分辨率以提高畫質，修復主遊戲和Studio之間陰影強度不匹配的問題  
   注意，個案出現把顯卡的3D運算效能炸到100%，導致遊戲FPS剩下個位數，並拖垮整台電腦。  
   * [MoreOutfits v1.1.1](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v215) 增加角色身上的服裝數量 (KKS預設只有四套)它可能跟任何會動到服裝的插件衝突  
   * ~~[PoseUnlocker v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v197) Removes the gender restriction on saved Studio poses.~~ 這是Studio Transgender Loading已經內含的功能，如果你裝了就別裝這個。  
   * [TwoLut v1.0](https://github.com/IllusionMods/KK%5FPlugins/releases/tag/v205) 讓你自由選擇Studio中的應用的兩個濾鏡(原始設計中永遠有一個是昼)。並在濾鏡選單旁加「上一個/下一個」按鈕
* ☆[IllusionFixes v18.1](https://www.patreon.com/posts/illusionfixes-0-41216761)
   * CameraMaskResize
   * HairShadows 修正啟用「眼睛穿透前髮顯示」時，前髮無法照上影子的問題
   * Heterochromia 可以加載有不同類型的瞳孔，而不會重置它
   * MakerOptimizations 角色編輯器效能優化
   * ManifestCorrector 避免某些製作錯誤的sideloader mod manifest在故事模式造成的崩潰
   * NullChecks 移除程式內的部分錯誤Null值(頭部飾品相關)
   * ResourceUnloadOptimizations 大幅度減少Studio Scene讀取時間，增進校園模式載入效能。如果RAM大於16G時，可以斟酌至設定關閉自動卸載資源功能(以RAM空間換取讀取時間)
   * SettingsVerifier 啟動時檢查遊戲啟動器設定(分辨率、全螢幕/視窗化等)
* [Keelhauled/KoikatuPlugins](https://github.com/Keelhauled/KeelPlugins/releases/tag/build-148)
   * AnimeAssAssistant 協助你管理大量存檔的助手，透過快捷鍵操作
   * CameraFrameMask 屏蔽在讀取角色時會出現的ugly frames
   * CharaStateX  
         * 讓Studio裡某些物件可以同時編輯，用Shift/Ctrl選擇複數個人物，然後就可以同時加載姿勢、改眨眼狀態、更改動畫、更改服裝狀態、更改關節補強等等(這些舉例是原說明的描述)  
         * Studio H動作同步: 通過選擇一個男性和一個女性，然後在按住ctrl鍵的同時單擊列表中的H動畫，插件將根據性別自動選擇合適的H動畫。
   * ClothingStateMenuX 增加捏人右側欄的穿衣狀態選項，和ClothingStateMenu選一個用就好
   * DefaultParamEditor 儲存預設環境/角色參數，普通的設定好以後到設定裡面做儲存，下次開程式就會預設載入該設定
   * DefaultStudioScene 開啟Studio時載入設定的Scene
   * ItemLayerEdit 一鍵讓物品在角色層和地圖層調動，這和光影影響有關係
   * LightManager 聚光燈可以追尾指定角色
   * LockOnPlugin 鏡頭追尾外掛 (範例圖是HS，請注意功能演示就好)
   * MakerBridge 使用快捷鍵(B)將選擇的角色從CharaMaker送到Studio，或是反之。  
   附上作者畫的圖  
   [![](https://img.maki0419.com/blog/helpful_guide.png)](https://img.maki0419.com/blog/helpful%5Fguide.png)
   * RealPOV H戰鬥的第一人稱插件，預設快捷鍵Backspace，和KK\_HeadUtl各有特色
   * StudioAddonLite 在Studio內，使用快捷鍵操作X軸、Y軸、Z軸旋轉移動等
   * TitleShortcuts 新增主選單快捷
   * [UnityLogFilter](https://github.com/Keelhauled/KeelPlugins/releases/tag/build-185) Unity log 過濾器，這是patchers。一般來說你不會用到他
* [GraphicsSettings v1.2.1](https://github.com/BepInEx/BepInEx.GraphicsSettings/releases/tag/v1.2.1) 開啟更多的詳細畫面設定
* [BepInEx Utility r7](https://github.com/BepInEx/BepInEx.Utility/releases/tag/r7)  
   * EnableFullScreenToggle v1.0 以Alt+Enter切換全螢幕  
   * EnableResize v1.5 可以直接透過拖曳畫面邊角改變視窗大小  
   * InputHotkeyBlock v1.4 打字時不會觸發快捷鍵  
   * MessageCenter v1.1.1 將重要度為「Message」的訊息顯示在遊戲畫面頂端  
   * MuteInBackground v1.1 在視窗失焦時自動靜音遊戲，功能需要在Config中啟用  
   * CatchUnityEventExceptions v1.0 在常用之UnityEngine events上若發生event handlers報錯，也不會影響其它hook在同一個event上的handler  
   * SuppressGetTypesErrorsPatcher v1.0 處理在Assembly.GetTypes()上的ReflectionTypeLoadException  
   * OptimizeIMGUI v1.0 減少Unity IMGUI(OnGUI)顯示介面的不必要GC分配
* [KK\_BrowserFolders v2.6](https://www.patreon.com/posts/browserfolders-2-40644638) 讓選擇器支援子資料夾讀取
* [HideAllUI v2.3.2](https://github.com/IllusionMods/HideAllUI/releases/tag/v2.3.2) 隱藏UI介面(預設:空白鍵)
* ☆[DragAndDrop v1.2.6](https://github.com/IllusionMods/DragAndDrop/releases/tag/v1.2.6) 在載入圖檔時可以用視窗外拖曳檔案的方式。  
   * 支援在Studio、Maker、FreeH拖入角色卡、場景卡、衣裝卡  
   * 支援Studio拖入Pose存檔  
   * Studio中按著Shift拖入可為import功能  
   (Need to focus the game, hold shift, and drag a scene in. Doesn't work if you click outside of the game and then drag in!)
* ☆[Illusion Overlay Mods v6.0.4](https://www.patreon.com/posts/illusion-overlay-37785162) 在身體、衣服、眼睛上套用圖片，做客制化服裝者之必備插件
* ☆[ABMX V4.4.5](https://www.patreon.com/posts/37819916) 增加更多的捏角選項
* ☆[KK\_SkinEffects v2.0.1](https://www.patreon.com/posts/31646040) 增加幾個皮膚上效果(流汗、流水、流血)，需要Overlay Mods
* [KK\_ExpandMaleMaker v1.2](https://github.com/Kokaiinum/ExpandMaleMaker/releases/tag/1.2) 給男角色增加某些原本被限定在女編輯器才有的調整項，像是身高和X毛，需注意若大幅調整身高會導致H時錯位問題
* [QuickAccessBox v2.4.4](https://www.patreon.com/posts/quickaccessbox-2-38060886) Studio中可以用關鍵字快速檢索item  
   * Left Control + Space打開介面(可至F1更改熱鍵設定)  
   * 請閱讀[縮圖產生說明](https://github.com/ManlyMarco/QuickAccessBox#how-to-add-thumbnails-for-your-items)  
   * 為使英文搜尋生效，請按以下步驟安裝:  
      1. 請下載[IllusionMods/KKS-Translation](https://github.com/IllusionMods/KKS-Translation/releases/latest)最新Release的KKS-Translation\_Release\_(日期).zip  
      2. 此檔案解壓縮後，將其中位於「BepInEx\\Translation\\en\\Text」之下的檔案複製至遊戲資料夾內相對位置  
      3. 開啟Studio後靜待數秒讓第一次的自動翻譯完成(請注意Console Log)
* [Koikatu HeightBar v3.3](https://www.patreon.com/posts/35859949) CharaMaker中顯示換算的實際身高(多少cm)，僅供參考
* ☆[KKS\_MoreAccessoryParents v2.0](https://www.patreon.com/posts/24129495) 更多的裝飾品安裝基準點，需要More\_Accessories v1.1.0
* ☆[Koikatu KKPE\_v2.12.0](https://www.patreon.com/posts/hs-kk-ai-hs2-2-0-38673900) Studio內可以調整DynamicBones、調整BlendShape、調整Collider，調BlendShape可以做顏藝或鮑鮑開開
* [Koikatu KKUS v1.9.0](https://www.patreon.com/posts/hs-kk-ai-hs2-1-9-38675642) 增加以下功能  
   * 使主遊戲和Studio中的UI可以縮放  
   * Studio中做刪除時有個確認視窗  
   * Maker中的搜尋框  
   * Studio中物品和角色的搜尋框  
   * Studio中縮放值可以是負值  
   * 自動關節補正  
   * Studio中可以將眨眼預設為關閉  
   * Studio所有的畫面後處理都可關閉  
   * 相機視角速度調整
* [RendererEditor 1.6.0](https://www.patreon.com/posts/hs-kk-ai-hs2-1-6-39556121) 材質編輯器，[說明影片](https://www.youtube.com/watch?v=lwHjQRKkzp0)
* ☆[Timeline 1.1.0](https://www.patreon.com/posts/hs-kk-timeline-1-37188531) 可以在Studio中做關鍵幀動畫，將Studio動畫制作推到了另一個高度。視窗快捷是Ctrl+T，[這裡](https://www.youtube.com/watch?v=LGq2g5kP7wg)和[這裡](https://www.youtube.com/watch?v=5hXl2MSYop4)有教學影片
* [VideoExport 1.2.1](https://www.patreon.com/posts/hs-kk-ai-hs2-1-2-40762879) 錄影輸出工具，可逐幀輸出，快捷是左Ctrl + E，[說明書](https://joan6694.bitbucket.io/)
* [KK\_CrossEye 1.6](https://github.com/Mantas-2155X/KK%5FCrossEye/releases/tag/v1.6) 交叉眼睛注視略為錯位的兩個畫面，顯示3D效果
* [HLightControl v1.2.4](https://www.patreon.com/posts/hlightcontrol-v1-45547422) H介面固定燈光方向(原始的燈光會跟著相機轉，這能加一個選項讓你固定他)
* [StudioAccessoryNames v1.1.1](https://www.patreon.com/posts/57369363) Studio中，讓角色身上帶的飾品顯示具體名稱
* [MakerSearch v1.5](https://www.patreon.com/posts/55475679) 在Maker中可以做輸入搜尋
* [MakerRandomPicker v1.2.0](https://www.patreon.com/posts/55538871) 在Maker中每個類別窗上增加「Random」按鈕，可以做隨機套用
* [MakerAdditions v1.0.0](https://www.patreon.com/posts/makeradditions-0-40518603) 給Maker新增功能:  
   * 解鎖飾品移動的-100\~100極限  
   * 添加了更精確的飾品移動選項 (0.01 pos, 0.1 ang)  
   * 新增了將相機燈光鎖定的toggle
* [StudioPOV v1.1.1](https://www.patreon.com/posts/38686093) Studio中的第一人稱插件，選中角色後按P
* [Better Color Picker v2.0.2](https://www.patreon.com/posts/33587860) 顏色設定時，選取調色盤外的顏色，可以直接去點其他衣服部位做同步
* [RemoveToRecycleBin v1.1.1](https://www.patreon.com/posts/33827361) 遊戲內刪除\\覆蓋角色卡、服裝卡、場景卡時會送入資源回收桶，避免瞬間丟失數據
* [KK\_MobAdder v3.0](https://www.patreon.com/posts/kk-mobadder-v3-0-41427812) 在校園中生成(單色)背景人物
* [Koikatsu: Become Trap v2.1](https://github.com/ManlyMarco/IllusionTrapMods/releases/tag/v2.1) 讓男角變成偽娘，本篇遊戲裡的角色互動會變不同，詳見網頁說明
* [Gameplay Mod v2.2](https://www.patreon.com/posts/39605273) 對主遊戲增加以下功能，和kPlug不相容  
   * 上學人數上限由38升到99  
   * 能強上，但會讓她生氣  
   * H Scene用手時，可以不隱藏男角色的身體  
   * [→其它](https://github.com/ManlyMarco/Koikatu-Gameplay-Mod/tree/master#some-of-the-features)
* [KK\_Bulge v1.0.2](https://www.patreon.com/posts/kk-bulge-v1-0-2-44997454) 讓大家下面多一包
* [StudioCameraObjectTweaks v1.0](https://www.patreon.com/posts/studiocameraobje-44720834) 修改Studio中的Camera(透過camera按鈕添加的那一個)，讓它初始在當前視角而不是游標處，並初始為隱藏。
* [SliderHighlight v2.1.1](https://www.patreon.com/posts/44119450) 在捏人中高亮現正調整的滑桿位置，能清楚的知道你正在調整什麼部位。需要ABMX
* [OrthographicCamera v1.1.2](https://www.patreon.com/posts/31909622) 按鍵I切換至平行視角相機
* [KK\_UniformUniforms v1.1](https://github.com/ManlyMarco/KK%5FUniformUniforms/releases/tag/v1.1) 本篇遊戲內的制服更換器，一鍵幫大家穿校服
* [Koikatu Gamepad Support v2.0.2](https://www.patreon.com/posts/41364207) 添加搖桿支持
* [CharacterReplacer v1.6.3](https://github.com/IllusionMods/CharacterReplacer/releases/tag/1.6.3) 可以變更Maker預設角色，在F1裡頭設定
* [FPS Counter v3.1](https://www.patreon.com/posts/fps-counter-v3-0-35397322) 顯示遊戲FPS
* [RimRemover v1.2](https://github.com/IllusionMods/RimRemover/releases/tag/v1.2) 移除遊戲中所有的輪廓光(Rim Light)，需在Config啟用
* [KK\_Pregnancy v2.3.1](https://www.patreon.com/posts/kk-pregnancy-v2-40713494) 懷孕mod，需要KKABMX，[說明](https://github.com/ManlyMarco/KoikatuGameplayMods/blob/master/README.md#kk%5Fpregnancy--pregnancy-mod)
* ☆[ModBoneImplantor v1.1.1](https://github.com/IllusionMods/ModBoneImplantor/releases/tag/v1.1.1) 對一些mod衣服添加骨骼
* ☆[ClothColliders v1.1](https://www.patreon.com/posts/35139324) 對一些mod衣服添加碰撞器
* [KK\_MoanSoftly v1.0](https://www.patreon.com/posts/32405964) H戰鬥時的呻吟音量會隨著戰鬥進度改變
* [Koikatu ClothingStateMenu v3.1](https://www.patreon.com/posts/37378336) CharaMaker中加上服裝狀態操作選單，可以半脫、隱藏身體，右下角可以勾選啟閉功能。和ClothingStateMenuX選一個用就好
* [KK\_AccStateSync v3.1.1.0](https://github.com/Madevil/KK%5FAccStateSync/releases/tag/v3.1.0.0) 將飾品的顯示與否和服裝的穿、脫、半脫狀態綁定
* [KK\_MovUrAcc v1.3.0](https://github.com/Madevil/KK%5FMovUrAcc/releases/tag/v1.3.0.0) 聽說這是用來治療痔瘡用的(批量移動飾品、移除髮飾品、清空末尾空飾品欄)
* [StudioCharaSort r3](https://github.com/Madevil/Port%5FStudioCharaSort/releases/tag/r3) 設定Studio中人物列表、服裝列表的預設排序
* [AdvIKPlugin v1.6.5](https://github.com/OrangeSpork/AdvIKPlugin/releases/tag/1.6.5) 讓角色在Studio IK模式可以旋轉肩膀，做出更自然的動作
* ☆[VN\_Game\_Engine(VNGE) v32](https://mega.nz/#F!oiB2wAQK!ojGIzlAN-1B-263uUDEalQ!Jm5xAIbA) VN引擎，用來做文字選項遊戲和寫Script，語言是Python。  
相關插件: 將相關插件檔案(應為\*.py和一些附加內容)放入VNGE的「Console\\Lib\\」目錄下  
   * Scene Save State ([使用教學](https://mega.nz/#F!U2wADQRD!7Qzfk4D3qoU%5FZ0P26cgLLg)) 在Scene裡儲存角色狀態，讓你****用同一個人物去改變動作、位置等，取代複數的同一人物，以減輕電腦負擔**。  
   * VNText 這是[Studio Text Plugin](/2019/06/koikatu-studio-text-plugin.html)的VN Port  
   * VNAnime 制作關鍵幀動畫  
   * VNScene 制作VN (Virtual Novel)  
   * Pose, Face, Status, Hands libraries 以標籤、群組分類保存Pose等等  
   * Body and Face sliders 可以在Studio中簡單的修改角色身型數值  
\==以上內建在VNGE中==  
   * [Auto Chara Moments 4.5](https://mega.nz/folder/oiB2wAQK#ojGIzlAN-1B-263uUDEalQ/file/puoRUCYR) 自動為選擇的角色卡&複數場景卡拍攝截圖，使用安裝教學詳見內文  
   * [MMD Director v2.2.1](https://mega.nz/folder/NQhG3IjA#rwyaVwE0O1t3pJe5Fefv2Q) ([ZOD發布帖和說明、教學](https://zodgame.xyz/forum.php?mod=viewthread&tid=235560)) 定位為MMD製作工具，不僅是播放VMD動作，而且能夠編輯關鍵幀並協調場景內的其他道具  
   * [KoiFighter!! 1.5](https://mega.nz/folder/oiB2wAQK#ojGIzlAN-1B-263uUDEalQ/file/oyw01baD) 在Studio中玩格Game！詳見連結內影片
* [KKVMDPlay v0.3.4](https://mega.nz/file/MEoFnQKD#Lg8DFf7s96GwhnvYzkZsyzdIlxnJvN-FCQR3b8gMC-s) (發布於匿名討論串) 可以在Studio內撥放MMD的VMD動作檔、相機檔、放音樂，Ctrl+Shift+V開啟視窗  
(將設定中的CacheGagEyesTexture禁用，否則Darkness Studio眼睛會消失)
* [BepInEx Debug tools r9](https://github.com/BepInEx/BepInEx.Debug/releases/tag/r9) 插件開發工具，絕對只有開發者會需要這些。務必閱讀[詳細說明](https://github.com/BepInEx/BepInEx.Debug#tools-in-this-repo)  
   * DemystifyExceptions 將錯誤日誌改為易讀的格式  
   * ScriptEngine 從「BepInEx\\scripts」文件夾中加載和重新加載BepInEx插件。可以通過在配置中定義的鍵盤快捷方式重新加載。預設的快捷鍵是 F6。  
   * Startup Profiler 記錄各插件啟動時各階段的時間消耗  
   * Simple Mono Profiler 看似也是時間記錄相關，明寫了會影響效能  
   * MirrorInternalLogs 用以導出Unity內部的log  
   * CtorShotgun 用來判斷class初始化順序的工具
* ☆[CheatTools v3.0](https://www.patreon.com/posts/37889909) 遊戲作弊器，裡面有解鎖FreeH所有體位、修改MainGame女角數值等功能。快捷是Pause，需要Runtime Unity Editor v2.5
* ☆[Runtime Unity Editor v2.5 遊戲修改器](https://www.patreon.com/posts/33966766)
* ☆[PregnancyPlus v5.2](https://github.com/thojmr/KK%5FPregnancyPlus#how-to-install) 懷孕+，比KK\_Pregnancy做更細微的形狀調整。它是配合KK\_Pregnancy開發的，兩插件不衝突，請同時使用。
* [GeBo1/GeBoPlugins](https://github.com/GeBo1/GeBoPlugins)
   * [GeBoCommon v1.0.1](https://github.com/GeBo1/GeBoPlugins/releases/tag/r8) 以下幾個插件會依賴他運作，有用這幾個就必須安裝
   * [GameDialogHelper v0.9.1](https://github.com/GeBo1/GeBoPlugins/releases/tag/r2) 在主遊戲中提示對話選項的正確答案
   * [GameDressForSuccess v1.1.2](https://github.com/GeBo1/GeBoPlugins/releases/tag/r13) 主遊戲中，在邀請或被邀請去游泳/運動時男主也會自動換裝
   * [StudioMultiselectChara v0.9.1](https://github.com/GeBo1/GeBoPlugins/releases/tag/r3) Studio中先選取一個角色後按下快捷，就能一次將同角色全選。適合用在大量替換Scene中某人物的場合。
   * [StudioSceneNavigation v0.8.6](https://github.com/GeBo1/GeBoPlugins/releases/tag/r4) Studio中可透過快捷鍵從Scene Folder中加載下一個/上一個SceneData。
* [KK\_CrossFader v0.11](https://github.com/MayouKurayami/KK%5FCrossFader/releases/tag/0.11) HScene時的動作切換由瞬間移動改為正常動作，這在VR中的效果改善特別顯著，需要AfterSchool DLC
* [KK\_HSceneOptions v3.1.3](https://github.com/MayouKurayami/KK%5FHSceneOptions/releases/tag/3.1.3) H Scene新增一些功能性選項和許多快捷鍵，都需要到Config中設定，需要Afterschool DLC
* [KK Lipsync 0.1.3](https://github.com/01010101lzy/kk-lipsync/releases/tag/v0.1.3) 讓角色說話時的嘴形符合語句內容
* [GetTapped v0.2.0](https://github.com/01010101lzy/gettapped/releases/tag/gettapped-v0.2.0) 對觸控螢幕操作的修正，作者說只有在HScene做過測試
* [FixKPlug v0.1.0](https://gist.github.com/01010101lzy/ae07055ecea02427c4144220ce6c44f6) 作者原話:A dirty hack for those who still want to dip in the mess of kPlug but don't want it to load every single card AND RESOLVING EXTENDED DATA before Free H starts.
* ☆[Expression\_Control\_v0.2.6](https://mega.nz/file/VsgiGDwb#bCCdHHlzuhQcF4kkvbrtfOMJAOTwATS0b91ign-bzbk) 按L快速調整角色表情  
此為來自upillusion0498的KKS移植版，原作者為[56e4\_xXVv](https://ux.getuploader.com/56e4%5FxXVv/download/93)
* [KK\_DisableKinematicsOnChangeAnime 0.0.1](https://ux.getuploader.com/56e4%5FxXVv/download/95) 在Studio選擇Anime動作時，自動disable IK和FK，和FKIK同時使用可能造成不遇期操作
* [KK\_HCtrl 0.1.1](https://ux.getuploader.com/56e4%5FxXVv/download/96) 自動H插件，解放你的雙手
* ☆[KK\_NodesConstraints 1.2.1](https://www.patreon.com/posts/hs-kk-ai-hs2-1-2-40763065) 允許使用者將原本無法連結的物體連結在一起([詳細說明](https://www.patreon.com/posts/26326273))
* サバカン Sabakan\_Plugins: 他的插件發佈在英文Discord的#mod-sharing和uppervolta  
窩4不桿用  
   * Breastmilk v1.4.2 絶頂時母乳が出るようになる  
   * CyuNoVR v0.1.8 キスシーンがベロチューに代わるプラグイン  
   * DisplayofThumbnails v1.3.2 KK\_Fix\_MakerOptimizationsのWidth of maker item listsが8を想定したUIに変更する  
   * Fix\_StudioWindow v1.1.1 スタジオのUIを広げるプラグイン  
   * KK\_Fix\_MainParam v1.2.0 本編でのキャラメイクで名前などのキャラ情報を編集できる  
   * KK\_FixationalEyeMovement v1.3.3 Hシーンの目の動きを固視微動に変更  
   * KK\_GirlsClothesChange v1.2.1 ショートカットキーを使用して服の状態や靴の種類を切り替えるプラグイン  
   * KK\_LiveStageAudience v1.0.0 ライブステージの観客（サイリウム）数を調整できるプラグイン  
   * KK\_MapFriendlyOutfit v1.2.5 フリーHで着る最初の衣装を変更するプラグイン  
   * KK\_QuickLoadOption v1.2.2 確認ダイアログを省略出来たりキャラメイクやフリーＨ選択の初期設定を出来る  
   * LoadRandomMap v1.1.0 フリーH選択画面でのmapランダム切り替えが可能
* KK\_LewdCrest v0.12[upillusion0320](http://uppervolta-3d.net/illu/upload.php) 給你的妹子上淫紋、斷面圖
* KK\_FreeHFullAuto v0.0.2[upillusion0349](http://uppervolta-3d.net/illu/upload.php) FreeH自動駕駛、多視角。  
H鍵開車，Y鍵開啟多鏡頭，(Shift/Ctrl)+Y切換(前/後)一組鏡頭，並把Menu Icon變得世界小
* ~~KK\_PantyRobber v0.2[upillusion0321](http://uppervolta-3d.net/illu/upload.php) 在校園裡使出和真的「竊盜」~~ 在非日文語系有bug
* ~~[KK\_ClothesLoadOption v0.2.2](https://ux.getuploader.com/56e4%5FxXVv/download/94) 載入服裝卡片時，可以選擇要載入的細項，並不處理包括Material Editor在內的所有插件資料~~以[Koikatu Coordinate Load Option](https://blog.maki0419.com/2019/03/koikatu-coordinate-load-option.html)取代

## 其他工具

* ☆[Koikatu KKManager v0.18](https://www.patreon.com/posts/kkmanager-v0-14-41869238) Koikatu的人物卡和mod管理器，支援sideloader mod的自動更新
* [Plugin Data Reader](https://plugindatareader.maki0419.com/) 此工具網站可以檢查角色卡所使用的plugin和mod
* [Card Image Replacer v1.0](https://www.patreon.com/posts/32927543) PNG存檔圖片替換器，請務必詳閱說明
* ~~[MinUnity3D](https://github.com/kkdevs/MinUnity3D/releases) 用這工具可以大幅降低整體檔案大小還有RAM的消耗量，對abdata執行~~KK Manager已內建此功能
* ~~[Unity3D file compression script](https://www.patreon.com/posts/unity3d-file-28988648) 此工具功能同上者，注意閱讀使用說明~~KK Manager已內建此功能
* [KKキャラ抽出改変 ver1.2.3](https://mega.nz/folder/Fx5ikKzR#KsrxZ2VN939UHukgHKqeCA) ([uppervolta發布](http://uppervolta-3d.net/illu/upload.php?id=0550)) Scene中Chara之複數提取器

## 相關網站

* 官網
   * Illusion:<http://www.illusion.jp/>
   * コイカツ！サンシャイン:<http://www.illusion.jp/preview/koikatsu%5Fsunshine/index.php>
   * CharaStudio:<http://www.illusion.jp/preview/charastudio/index.php>
   * 角色交換站:<http://upks.illusion.jp/list/chara> (要日本IP)
   * SceneData交換站:<http://upks.illusion.jp/list/scene> (要日本IP)
* コイカツ！(中文)[^](#discord) \- Discord伺服器←我在這  
[![](https://img.maki0419.com/blog/join.png)](https://discord.gg/UJEA9nr)
* Koikatsu! 英文Discord伺服器  
<https://discord.gg/hevygx6>
* ZODGAME論壇 - 恋活！Sunshine版(需邀請註冊)  
<https://zodgame.xyz/forum.php?mod=forumdisplay&fid=127>
* uppervolta-3d (要日本IP)  
<http://uppervolta-3d.net/illu/upload.php>

### 人權

[![image](https://img.maki0419.com/blog/2021-08-31%2002%2051%2044.png)](https://img.maki0419.com/blog/2021-08-31%2002%2051%2044.png)

[![image](https://img.maki0419.com/blog/2023-07-16%2019%2049%2046.png)](https://img.maki0419.com/blog/2023-07-16%2019%2049%2046.png)

[![image](https://img.maki0419.com/blog/KKS.jpg)](https://img.maki0419.com/blog/KKS.jpg)

iscn://likecoin-chain/rtxrL8i4xKTDgZw8blO709mJWa-KdzDxwEkVnG1xpIM