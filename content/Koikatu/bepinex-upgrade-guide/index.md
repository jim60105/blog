+++
title = "[Koikatu] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) BepInEx框架 v4.X→v5.X升級指南"
description = "[Koikatu] コイカツ！ ( Koikatu / Koikatsu / 戀愛活動 ) BepInEx框架 v4.X→v5.X升級指南"
date = 2019-11-04T06:54:00.020Z
updated = 2021-10-31T11:16:06.841Z
draft = false
aliases = [ "/2019/11/koikatsu-bepinex-upgrade-guide.html" ]

[taxonomies]
tags = [ "Koikatu" ]
licenses = [ "GFDL 1.3" ]

[extra]
banner = "preview.jpg"
+++
(角色是我家的，但是原始Scene不是我做的)

2019/10/23 經歷了一次 BepInEx 4→5 的重要框架升級，在插件安裝位置方面做了很大的變更  
另外因為此版本內部變動很大，對開發者來說有些插件得要重寫  
像我 8 個插件死了 4 個....  
請務必詳讀內文，按照提示做升級，否則幾乎必死w
<!-- more -->
## 三種插件類型

現在插件分為三種安裝方式:

* BepInEx 5 插件:  
  直接將 \*.dll 等檔案放置於「**BepInEx/plugins/**」之下，例如「C:\illusion\Koikatu\BepInEx\plugins」  
  BepInEx 5 開始插件支援子資料夾，可以放置在 BepInEx/plugins 底下的任何多層資料夾內，但推薦參考原始壓縮檔之結構放置
* BepInEx 4 插件:  
  必須安裝 [BepInEx4Upgrader](https://github.com/BepInEx/BepInEx.BepInEx4Upgrader/releases/latest) 將之升級為「符合 BepInEx5 框架的 BepInEx4 插件」  
  之後將 \*.dll 等檔案放置於「**BepInEx/**」之下，例如「C:\illusion\Koikatu\BepInEx」，就可以自動升級  
  自動升級運作{{cr(body="有機會異常")}}，請小心使用
* IPA:  
  直接將 \*.dll 等檔案放置於「**Plugins/**」之下，例如「C:\illusion\Koikatu\Plugins」  
  **需要** [IPALoaderX](https://github.com/BepInEx/IPALoaderX/releases/latest)，{{cr(body="有機會異常")}}，若遇到錯誤請移除該個別插件

所有在 2019/10/23 以前發布的 BepInEx 插件皆是 BepInEx 4 插件，而在那之後的請參考各插件 Readme。

## BepIn4Patcher: BepInEx4 插件的自動升級器

在每次遊戲啟動時，[BepIn4Patcher](https://github.com/BepInEx/BepInEx.BepInEx4Upgrader/releases/latest) 會掃描「BepInEx」資料夾下的 BepInEx4 插件。如果需要升級，他會將原始 BepInEx4 插件備份至「BepInEx/bepinex4\_backup」，然後把升級過後之「符合 BepInEx5 框架的 BepInEx4 插件」放在原位。

請注意，這些經過轉換吐出的插件檔案，{{cr(body="切勿再分享出去")}}，也{{cr(body="不適合再另外備份保留")}}，請備份 backup 資料夾裡的原始插件。這是為了不要在網路上造成混淆，且將來若 BepIn4Patcher 有修改升級，這些產出檔案就應該要再被重新轉換。[IPALoaderX](https://github.com/BepInEx/IPALoaderX/releases/latest) 也是同理。

## BepInEx v5.X 之資料夾結構說明 {#bepinex5-folder-structure}

這些 \*.exe 檔案所在的最外層位置稱為「遊戲根目錄」，圖中路徑為遊戲預設安裝目錄「C:\illusion\Koikatu」，若使用原版コイカツ！ 安裝光碟以預設值安裝就會在此位置

<figure>
{{ image(url="1.png") }}
<figcaption>圖1，C:\\illusion\\Koikatu </figcaption>
</figure>

* 「BepInEx」: BepInEx 插件目錄，詳見圖 2
* 「mods」: 需要自己建立的目錄，裏頭放置 Sideloader mods，其應為 \*.zip 或 \*.zipmod
* 「Plugins」: **IPA 插件資料夾**，以前是位於「BepInEx/IPA」，現在改到這裡以符合 IPA 插件預設目錄結構
* 「Plugins\_backup」: IPA 插件備份資料夾，IPALoaderX 會將某些 IPA 插件做轉換，讓他可以在 BepInEx 框架環境運行，而轉換吐出的插件會留在「Plugins」資料夾，原始 IPA 插件會備份至「Plugins\_backup」

<figure>
{{ image(url="2.png") }}
<figcaption>圖2，C:\\illusion\\Koikatu\\BepInEx</figcaption>
</figure>

* 「BepInEx」: **BepInEx4 插件請直接放在此目錄內**，就如同舊版位置
* 「BepInEx/config.ini」: **BepInEx4 插件設定檔**，就如同舊版位置
* 「BepInEx/bepinex4\_backup」: BepInEx4 插件備份資料夾，BepIn4Patcher 會將 BepInEx4 插件自動升級為 BepInEx5 插件，而升級吐出的插件會留在「BepInEx」資料夾，原始 BepInEx4 插件會備份至「BepInEx/bepinex4\_backup」
* 「BepInEx/cache」: 快取資料夾，{{cr(body="不要去動他")}}
* 「BepInEx/config」: **BepInEx5 插件設定檔資料夾**，新版的設定檔是每一插件都會個別產生一個 cfg 檔，集中放置在此；可用文字編輯器打開
* 「BepInEx/core」: BepInEx5 重要核心插件，{{cr(body="不要去動他")}}
* 「BepInEx/patchers」: 特殊修補程式，例如 BepIn4Patcher 就在這，{{cr(body="只有極少數補釘會放在這")}}
* 「BepInEx/plugins」: **BepInEx5 插件放置位置**，支援多層子資料夾，建議參考各插件的壓縮檔結構放置；若無參考結構，直接放在「BepInEx/plugins」下即可
* 「BepInEx/Translation」: 存放翻譯資料之資料夾

## BepInEx v4.X→v5.X 升級方法

1. 把舊的「BepInEx」資料夾重命名為「BepInEx\_bak」，或是其他名稱
2. 參考 [\[BepInEx v5.X\] コイカツ！ 主程式 + mod + plugin 安裝指南](@/Koikatu/bep5-plugin-guide/index.md#necessary_plugins)安裝{{cr(body="所有")}}必裝插件
3. 啟動 Koikatu 遊戲運行一次至主畫面 (或 CharaStudio 至編輯器加載結束) ，確認 Console 無報錯  
   (若有問題請參考[コイカツ! 插件安裝方式、問題判斷及排除指南](@/Koikatu/install-and-debug-guide/index.md))
4. 參考 [\[BepInEx v5.X\] コイカツ！ 主程式 + mod + plugin 安裝指南](@/Koikatu/bep5-plugin-guide/index.md#other_plugins)安裝**所需**之其他插件
5. 啟動 Koikatu 遊戲運行，確認 Console
6. 用文字編輯器打開「BepInEx\_bak/config.ini」，檢視有無需要拷貝過去「BepInEx/config」下和「BepInEx/config.ini」的設定
7. 重啟遊戲

用一句話來概述，**就是砍掉重練**  
不然你問題絕對會爆炸多w
