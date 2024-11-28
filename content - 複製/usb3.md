+++
title = "多重開機USB製作 及 開機選單修改(下) - 加入Windows To Go系統"
description = "多重開機USB製作 及 開機選單修改(下) - 加入Windows To Go系統"
date = 2017-07-12T17:56:00.005Z
updated = 2020-11-24T14:56:53.459Z
draft = false
aliases = ["/2017/07/usb3.html"]

[taxonomies]
tags = ["資訊科技"]

[extra]
banner = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVjbCjxYk850s0qo-OrGhm6lLD9Uj2jbePmqmAv2l039UozEk4qqSZmt8qNM03DmcjVQxireW8ML3sNYQfpAa-pJY5RophbyCv5VisBXpthbIau_WhgNjoNnTtepXeFrG0zE1EYPo6B9dF/s640/2017-07-12+21+29+17.png"
+++
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVjbCjxYk850s0qo-OrGhm6lLD9Uj2jbePmqmAv2l039UozEk4qqSZmt8qNM03DmcjVQxireW8ML3sNYQfpAa-pJY5RophbyCv5VisBXpthbIau_WhgNjoNnTtepXeFrG0zE1EYPo6B9dF/s640/2017-07-12+21+29+17.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVjbCjxYk850s0qo-OrGhm6lLD9Uj2jbePmqmAv2l039UozEk4qqSZmt8qNM03DmcjVQxireW8ML3sNYQfpAa-pJY5RophbyCv5VisBXpthbIau%5FWhgNjoNnTtepXeFrG0zE1EYPo6B9dF/s1600/2017-07-12+21+29+17.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizAF9Ak239u7GhlPbC9_N-xNuDWziO6BQOByv-7rPjhkqOMmEn2wU5yhG7X5PAiP3oiYrLPAw3jFwZKfDbxreI7_E61ikd29dmtg57YSGoi14TL9HKnCtPBkss4E6aoPN0gcawJkn7Bh1x/s640/2017-07-12+22+41+45.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizAF9Ak239u7GhlPbC9%5FN-xNuDWziO6BQOByv-7rPjhkqOMmEn2wU5yhG7X5PAiP3oiYrLPAw3jFwZKfDbxreI7%5FE61ikd29dmtg57YSGoi14TL9HKnCtPBkss4E6aoPN0gcawJkn7Bh1x/s1600/2017-07-12+22+41+45.png)

  
## 前言

本系列分成上下兩篇，請先閱讀[上篇](https://blog.maki0419.com/2017/07/usb-usb.html)

  
使用PE的時候一直有點困擾  

> "就缺了這個軟體呢"

> "想要可以保存這個文件啊"

這時候就會想，何不在USB裡面灌個一般系統呢? →得到的解答: **Windows To Go**  
WTG本身是不難做，但是要跟我們的多重開機合併就會遇到幾個瓶頸  
  
1. Windows C槽結構固定，無法安裝在特定資料夾
   * 灌進VHD裡面，然後使用Grub4Dos→BCD引導
2. 灌起來以後效能不佳
   * 安裝EWF把系統載入RAM
   * 使用USB3.0提升速度
   * 盡量保持系統輕量化  
   →實測載入系統**約30秒**
另外，因為Windows10在開機的時候會掃描硬體並安裝驅動，Win7跟XP不會。雖然Linux會，但是還是Windows系統通用性高，所以系統選擇**Windows10**
  
  
## 步驟大綱

系列分成兩篇敘述，上篇老少皆宜，下篇屬於困難級，請適當斟酌  

[上篇-建立開機USB](/2017/07/usb-usb.html):  
1. 處理磁碟分割及引導
2. 安裝Base模式(8G)
3. 安裝Add模式(16G)
4. 安裝Add\_xp模式(32G)
5. 安裝Tools
6. 測試成果
7. 注意事項
  
[下篇-加入Windows To Go系統](/2017/07/usb3.html):  
1. 製作Win10 VHD
2. 設置BCD引導
3. 安裝EWF影子系統
4. TroubleShooting

## VHD (Virtual Hard Disk)

> Windows 7 中 VHD 檔案格式其實是虛擬硬盤(virtual machine hard disk)的檔案格式。Windows 7 內建對 VHD（Virtual Hard Disk）的原生支持，可以很容易的將VHD文件掛載到系統中，看起來就像一個真實的硬碟分區(partition)般。  
>  
> VHD 是一部虛擬硬盤，不同於傳統硬盤的盤片、磁頭和磁道，VHD硬盤的載體是文件系統上的一個VHD 檔案。如果大家仔細閱讀VHD文件的技術標準，就會發現標準中定義了很多Cylinder、Heads和Sectors等硬盤特有的術語，來模擬針對硬盤的 I/O操作。既然VHD是一塊硬盤，那麼就可以跟物理硬盤一樣，進行分區、格式化、讀寫等操作。  
>
> ──[Windows 7 中的 VHD 檔案格式到底是什麼 ? :: ezone.hk :: 一站式即時科技新聞](http://ezone2.ulifestyle.com.hk/tips.php?tipsid=3142)

> 詳細介紹:  
> [把 Windows 7 灌進 VHD 虛擬磁碟（上） | T客邦 - 我只推薦好東西](http://www.techbang.com/posts/3910-invincible-vhd-virtual-disk-on)

## EWF (Enhanced Write Filter)

> EWF（Enhanced Write Filter，增強型寫入過濾器）是XP Embedded嵌入式系統中的一個強大組件，它被稱為微軟牌的「影子系統」。  
>  
> EWF是什麼？簡單的說它就是讓磁碟變成「唯讀」、「防寫」狀態。EWF可以安裝在一般的硬碟上，讓你目前的作業系統變成唯讀保護。  
>  
> EWF的工作原理，就是把系統的變動都記錄在RAM上，而不寫入硬碟（除非使用者要求），所以能讓XP變成防寫的狀態。但是如果RAM本身不足夠的話，對於效能會有反效果。  
>
> ──[微軟的EWF影子系統 @ 更高境界．願景 :: 痞客邦 PIXNET ::](http://texhello.pixnet.net/blog/post/21429774-%E5%BE%AE%E8%BB%9F%E7%9A%84ewf%E5%BD%B1%E5%AD%90%E7%B3%BB%E7%B5%B1)

  
下載EWF: [MEGA](https://mega.nz/#!R5RnkR4S!lkx8tW4bb%5FgaEGnueyxWpciUpC5KS0EO6Sv7SsfWV9M)

## 正文

### 製作Win10 VHD

第一步，建立空白VHD  

Win+R打開執行，輸入"diskmgmt.msc"打開磁碟管理員  
動作→建立VHD  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGR-UizbXrs9CC0ey1Ji7_v64kQy3M-HBbnIoGlAWOpAx42wlpsuXe9PeQc2kA0rrQ2FATmYGtU5Fz1MhBw1pT6INnDokIxH3pQ-Ffo69nIVKInRfEEYKW5sjge-D2Bb7kd9yAP8enqGMI/s640/2017-07-12+20+04+39.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGR-UizbXrs9CC0ey1Ji7%5Fv64kQy3M-HBbnIoGlAWOpAx42wlpsuXe9PeQc2kA0rrQ2FATmYGtU5Fz1MhBw1pT6INnDokIxH3pQ-Ffo69nIVKInRfEEYKW5sjge-D2Bb7kd9yAP8enqGMI/s1600/2017-07-12+20+04+39.png)

  
大小給15G，Win10裝到能用下限差不多是這樣  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhg_OmdUO6iW2A9i25Xsf32jhyphenhyphenNDzk1AnYswEwXeI4_GxADCjY_8RKo4-MjnRf-Wb0FhfFETfQxNqNFoJM8LYWipQjcXtC3L86dH6l87EE3HX7IyMsPSAcEumNwpuXy9jBctuqoQ5OBjsDF/s1600/2017-07-12+20+06+00.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhg%5FOmdUO6iW2A9i25Xsf32jhyphenhyphenNDzk1AnYswEwXeI4%5FGxADCjY%5F8RKo4-MjnRf-Wb0FhfFETfQxNqNFoJM8LYWipQjcXtC3L86dH6l87EE3HX7IyMsPSAcEumNwpuXy9jBctuqoQ5OBjsDF/s1600/2017-07-12+20+06+00.png)

  
建立完成後應該會自動連結VHD，會出現未初始化VHD  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-gJHcV68GlgS6HFJJlEXnboojlEZcGy5zMuQwrIgkeWA1T0knHMLMXoeghQvsI9tdvtaMWA_1NJdDPJw_WgBHTazoC3fI-4GV3H_jG4P1Eiaj-N7diMDOC9CyyVU2yU7IHFPax74hbuvc/s640/2017-07-12+20+09+05.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-gJHcV68GlgS6HFJJlEXnboojlEZcGy5zMuQwrIgkeWA1T0knHMLMXoeghQvsI9tdvtaMWA%5F1NJdDPJw%5FWgBHTazoC3fI-4GV3H%5FjG4P1Eiaj-N7diMDOC9CyyVU2yU7IHFPax74hbuvc/s1600/2017-07-12+20+09+05.png)

  
對著其左半邊右鍵→初始化磁碟  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimDATzfDJKtZhyphenhyphenRMun2nBVfA42V0De045T76ocw1CuttzP2Yv_huZfk522wUduKVT-j9RBzaFhedtPwizWRC0kW1NSyRbdXjiiphjBkMFIGF3scbOuXETpLZFd7qRifE7jgDW5GgCI2ckA/s640/2017-07-12+20+09+52.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimDATzfDJKtZhyphenhyphenRMun2nBVfA42V0De045T76ocw1CuttzP2Yv%5FhuZfk522wUduKVT-j9RBzaFhedtPwizWRC0kW1NSyRbdXjiiphjBkMFIGF3scbOuXETpLZFd7qRifE7jgDW5GgCI2ckA/s1600/2017-07-12+20+09+52.png)

  
選擇MBR  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Ne7qyAtjf0iDAqB7kgDPeP7NS3pxtdyf2FBJZkiBJ2EaSEUO3X9J7kQwY5oitbgQheU0g5LK_vvGV7JWVOVzUAPFrsrt74D77HuWs72zKPN_KOUHmifxbe1v8iF_7X1MFg6x3OvpBxhR/s1600/2017-07-12+20+10+19.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Ne7qyAtjf0iDAqB7kgDPeP7NS3pxtdyf2FBJZkiBJ2EaSEUO3X9J7kQwY5oitbgQheU0g5LK%5FvvGV7JWVOVzUAPFrsrt74D77HuWs72zKPN%5FKOUHmifxbe1v8iF%5F7X1MFg6x3OvpBxhR/s1600/2017-07-12+20+10+19.png)

  
對著黑色右半部右鍵→新增簡單磁碟區  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO5dq7twxGhmZ5riR9WTHZkXE2V3tid15E_1RQAKYghqIMyLjGoL_QSmR4ELtiUSQlqBFM2RN-93YAidm4C5aiTS8pERVM8QxcWd6MJkfolC-hk9uuAL8K04N2osJxsMi8j-SghlPKNgYG/s640/2017-07-12+20+11+13.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO5dq7twxGhmZ5riR9WTHZkXE2V3tid15E%5F1RQAKYghqIMyLjGoL%5FQSmR4ELtiUSQlqBFM2RN-93YAidm4C5aiTS8pERVM8QxcWd6MJkfolC-hk9uuAL8K04N2osJxsMi8j-SghlPKNgYG/s1600/2017-07-12+20+11+13.png)

  
將Windows10安裝光碟用WinRAR打開，找到"\\x64\\sources\\install.esd"，解壓縮出來  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh_bP6rNYXuzjXtmw3VRhqk2Eg6WXufYXHQvCyjlaiR7dFTXMQ5pq6zmURwQxtg5AwCM-Mo-ee7T7SdtAaw2o5bHAN4tHWJSJG5RcYMp3E29Br5GumSWA4YhK7FydTY_e0BirAOeVd5gz7Y/s640/2017-07-12+23+26+45.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh%5FbP6rNYXuzjXtmw3VRhqk2Eg6WXufYXHQvCyjlaiR7dFTXMQ5pq6zmURwQxtg5AwCM-Mo-ee7T7SdtAaw2o5bHAN4tHWJSJG5RcYMp3E29Br5GumSWA4YhK7FydTY%5Fe0BirAOeVd5gz7Y/s1600/2017-07-12+23+26+45.png)
  
  
以系統管理員開啟cmd命令提示字元  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhHGY74SuxxkCccuWlQKsMMRc9bergUUnYBvbjJyQrPEv864uhAsSYdybrkZn2KY6s9vKjfg37mjb1Rxtryw3T0f8Y7V5u9Il5yBQDspEBiuJiFEBeLN8vpZLDIfzY5VqBNhHv8pEljEKNM/s640/2017-07-12+20+16+53.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhHGY74SuxxkCccuWlQKsMMRc9bergUUnYBvbjJyQrPEv864uhAsSYdybrkZn2KY6s9vKjfg37mjb1Rxtryw3T0f8Y7V5u9Il5yBQDspEBiuJiFEBeLN8vpZLDIfzY5VqBNhHv8pEljEKNM/s1600/2017-07-12+20+16+53.png)

  
先cd到install.esd所在目錄: cd C:\\Users\\jim60\\Desktop\\working (視你的檔案位置而定)  
然後解開映像到VHD所在磁區: dism /apply-image /imagefile:install.esd /index:1 /applydir:E:\\ (替換成你的15G VHD掛載盤符)  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyynbguSm8Mm42CmnYiZsGpikzA_3-HXZ0yESuQ05ydY9RV3qiRMu4dicQZgjDJibBkeW_eWBV3EN3s0obA_JCwAbzHb_J-cVkzJycMrQ0i4Nxm9EUGcn1bbbX17coIeVsiso3dlM4dilx/s640/2017-07-12+20+20+43.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyynbguSm8Mm42CmnYiZsGpikzA%5F3-HXZ0yESuQ05ydY9RV3qiRMu4dicQZgjDJibBkeW%5FeWBV3EN3s0obA%5FJCwAbzHb%5FJ-cVkzJycMrQ0i4Nxm9EUGcn1bbbX17coIeVsiso3dlM4dilx/s1600/2017-07-12+20+20+43.png)

  
接下來要建立BCD引導: bcdboot.exe E:\\windows /s E: /f ALL (替換成你的15G VHD掛載盤符)  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbPUtFJtFv11B_L4fvJxVAMXDsyLU2eEHS9_uCcqi523ni094Sg_qpNVSmVcC0yCqdcQWLIh5eRyehD27gr055i75AMRnHcTnT9LEm3blsCvLd9Q83s2xDlromjR5Usm3hnMUIrZ0xxuap/s640/2017-07-12+20+26+02.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbPUtFJtFv11B%5FL4fvJxVAMXDsyLU2eEHS9%5FuCcqi523ni094Sg%5FqpNVSmVcC0yCqdcQWLIh5eRyehD27gr055i75AMRnHcTnT9LEm3blsCvLd9Q83s2xDlromjR5Usm3hnMUIrZ0xxuap/s1600/2017-07-12+20+26+02.png)

  
完成以後VHD裡應該長這樣  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZtq_C2R87wxbakEJcbIK2fZw97gTD6Lk9t3mB534SHmUL-K3uM8_q_rv8Yjbcs34vHKEFSG6z94DYpJmY_0WMj9xqa-E9Czrbpiu-Gi_WuXe5v82BcThN107mhIlK-NseyfRwiPS_GbLr/s640/2017-07-12+23+47+05.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZtq%5FC2R87wxbakEJcbIK2fZw97gTD6Lk9t3mB534SHmUL-K3uM8%5Fq%5Frv8Yjbcs34vHKEFSG6z94DYpJmY%5F0WMj9xqa-E9Czrbpiu-Gi%5FWuXe5v82BcThN107mhIlK-NseyfRwiPS%5FGbLr/s1600/2017-07-12+23+47+05.png)
  
  
把以下三項複製到隨身碟根目錄下  
* Boot資料夾
* bootmgr
* BOOTNXT
  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEixvHPjpD1RVqxomPcBfN_o5-SpAh4dK0v1FUpZmPowKPENpEMEsoN7mAHBcP4lGJlCgWLMEkRB24i1MMASoHTSldFvTGl6Er8EzOYF2pUf9G9jFFUlFEdfo719E3P-yVm8hjNsnh-F0xl6/s640/2017-07-12+20+30+15.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEixvHPjpD1RVqxomPcBfN%5Fo5-SpAh4dK0v1FUpZmPowKPENpEMEsoN7mAHBcP4lGJlCgWLMEkRB24i1MMASoHTSldFvTGl6Er8EzOYF2pUf9G9jFFUlFEdfo719E3P-yVm8hjNsnh-F0xl6/s1600/2017-07-12+20+30+15.png)

  
卸載VHD，對著VHD左半邊右鍵→中斷連結  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg7CFRykSgFSawAh2PBn8bs2SWFj_foSL81cAWSkLfrxJ6yeYVfwPm1W0JKMP3K99T-D9bgYBeaVX-0ChTrcPDF9uEWyc3fl_VZWPiSBYE8Wf-l6HdlqNwSt0aSXLtgcrnzRpDmuRQxsVQk/s640/2017-07-12+20+32+24.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg7CFRykSgFSawAh2PBn8bs2SWFj%5FfoSL81cAWSkLfrxJ6yeYVfwPm1W0JKMP3K99T-D9bgYBeaVX-0ChTrcPDF9uEWyc3fl%5FVZWPiSBYE8Wf-l6HdlqNwSt0aSXLtgcrnzRpDmuRQxsVQk/s1600/2017-07-12+20+32+24.png)

  
在USB根目錄下建立一個資料夾"VHD"，將15G VHD檔複製進去  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAWglGMF0M-czWzSfW6h-LevGfybkT_zfxijRly3gom5f9-rJqO6X4-siKVnH6QWWVNhNbW0qPknFjVlZss4URbVdRrNUbFWYqLOX8RhRRx8Z-S4KHb6M3x4L4z3B0QOQsiESbnumdJV-O/s640/2017-07-12+20+40+17.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAWglGMF0M-czWzSfW6h-LevGfybkT%5FzfxijRly3gom5f9-rJqO6X4-siKVnH6QWWVNhNbW0qPknFjVlZss4URbVdRrNUbFWYqLOX8RhRRx8Z-S4KHb6M3x4L4z3B0QOQsiESbnumdJV-O/s1600/2017-07-12+20+40+17.png)

  
### 設置BCD引導

開啟BOOTICE→BCD編輯→其他BCD檔案→...→選擇到USB:\\Boot\\BCD  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZ4CUDqIHIokzDtvPKhqcE1_gVrq3lNA9kPM7sbxSZo34nQ5zjWzPoXg6WpMsht0wkox_3-ewIAS256FkwuDBo3522QysDXtRCOu5hwK1x3-mirbCQk38gmN7VZxc5jbvwdMneZ2hyphenhyphen3TIq/s640/2017-07-12+20+54+57.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZ4CUDqIHIokzDtvPKhqcE1%5FgVrq3lNA9kPM7sbxSZo34nQ5zjWzPoXg6WpMsht0wkox%5F3-ewIAS256FkwuDBo3522QysDXtRCOu5hwK1x3-mirbCQk38gmN7VZxc5jbvwdMneZ2hyphenhyphen3TIq/s1600/2017-07-12+20+54+57.png)

  
選擇"智慧編輯模式"  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjkk04oYuqMMS7hCmQJehpgfobOyqhpXfpOuWU32OmzTYLsBeFTYXBBJyh6wUU8v3JAvPrZOPKR_uEVdiowvch1Yzyunox-pU0SNsM6PEu_sHDOS8NvhWXPcsMTZZ18dNGNcY1bxNVevmgF/s1600/2017-07-12+20+56+18.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjkk04oYuqMMS7hCmQJehpgfobOyqhpXfpOuWU32OmzTYLsBeFTYXBBJyh6wUU8v3JAvPrZOPKR%5FuEVdiowvch1Yzyunox-pU0SNsM6PEu%5FsHDOS8NvhWXPcsMTZZ18dNGNcY1bxNVevmgF/s1600/2017-07-12+20+56+18.png)

  
把原有的Win10項目砍掉，重新添加VHD啟動項  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg-CtqgF1v8DXLM02ikOoqW9ndhyphenhyphenzurwjal9hjDqSrjzve_kBRoGz59ET2Iu1JoU6ls6aLXhVdb_t2tpfyqgDjfXPn5jSatDWLcVNt2xiz2rRcRnwxL_bw15iBL7XJ54BCErzp89kOS96uA/s640/2017-07-12+21+00+05.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg-CtqgF1v8DXLM02ikOoqW9ndhyphenhyphenzurwjal9hjDqSrjzve%5FkBRoGz59ET2Iu1JoU6ls6aLXhVdb%5Ft2tpfyqgDjfXPn5jSatDWLcVNt2xiz2rRcRnwxL%5Fbw15iBL7XJ54BCErzp89kOS96uA/s1600/2017-07-12+21+00+05.png)

  
所有欄位設定如圖，然後紅框處兩個按鈕都點一下(兩個一定都要按)，然後關閉退出BOOTICE  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVBhXlyY07aMwpb5GGeBOgZTR9opOF1Ko_umk5YCnGYeDWAY59we1QG9vNqPY-QYHdzf6DjaAXyzS1a3mKTYIGmewdt-6o7fo7AYfyds62Kb1ee9a4ofPjbaMtNj2B5_IyzBPmfTqi2L2I/s640/2017-07-12+20+56+50.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgVBhXlyY07aMwpb5GGeBOgZTR9opOF1Ko%5Fumk5YCnGYeDWAY59we1QG9vNqPY-QYHdzf6DjaAXyzS1a3mKTYIGmewdt-6o7fo7AYfyds62Kb1ee9a4ofPjbaMtNj2B5%5FIyzBPmfTqi2L2I/s1600/2017-07-12+20+56+50.png)

  
建立Grub4Dos引導至BCD  
編輯USB:\\List\\menu.lst，在中間加入這段  

title  BCD選單\n Boot from BCD Menu\n - VHD Windows 10 1607
chainloader /bootmgr

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGuAYWAckdksht9A8WO_xiMwxj1CbpqvwsQK0WjT3eAVEifPE1HNYt_w9ExaYP2Q2T8EZBezPDudrt1BhgCcXbJWihV_4SnY6IwzwBwqxXI4OxM3SCQlsloGZLJjeFpcRXgwSJPDL0Pcdm/s640/2017-07-12+21+07+07.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGuAYWAckdksht9A8WO%5FxiMwxj1CbpqvwsQK0WjT3eAVEifPE1HNYt%5Fw9ExaYP2Q2T8EZBezPDudrt1BhgCcXbJWihV%5F4SnY6IwzwBwqxXI4OxM3SCQlsloGZLJjeFpcRXgwSJPDL0Pcdm/s1600/2017-07-12+21+07+07.png)

  
至此，多重開機USB建立完成  
接下來要進到VHD做設定了  
  
這時候要做一件事  
**拔網路線!!!!!**  
**拔網路線!!!!!**  
**拔網路線!!!!!**很重要說三次，自動更新會把15G弄炸掉  
  
BIOS開機進USB，選擇"BCD選單"  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFcJn_9-1rKdbqR6Wywb6bo85jiKq02lfu84M1gzE6Z9fn3nuzyhc_N98pRfMhGsLqWeoavjQqqeUICWoDxG5Y6vw0mqpGFYOgaOA3c2PJ2TbndxEKBVJ7IGG22p3J4Wlix5GNzolhycqn/s640/2017-07-12+21+29+17.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFcJn%5F9-1rKdbqR6Wywb6bo85jiKq02lfu84M1gzE6Z9fn3nuzyhc%5FN98pRfMhGsLqWeoavjQqqeUICWoDxG5Y6vw0mqpGFYOgaOA3c2PJ2TbndxEKBVJ7IGG22p3J4Wlix5GNzolhycqn/s1600/2017-07-12+21+29+17.png)

  
然後就是漫長的等待  
......

然後終於出來啦!

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPjmApj1VSOxxeSrH4mBl84lgCatKqikqu_2PUrh2PXYMvbvEIS3goTS-dAIJSv1_7zchQgbCbvU3CVdSlhbZmDsiWh3gksq6B4N9IRS-n2_Fj7fLD7P9xBguMp1nWXxP0f1E87cxf2oA3/s640/2017-07-12+21+50+48.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPjmApj1VSOxxeSrH4mBl84lgCatKqikqu%5F2PUrh2PXYMvbvEIS3goTS-dAIJSv1%5F7zchQgbCbvU3CVdSlhbZmDsiWh3gksq6B4N9IRS-n2%5FFj7fLD7P9xBguMp1nWXxP0f1E87cxf2oA3/s1600/2017-07-12+21+50+48.png)

  
叫你連線到網路的時候跳過  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgELzWzzaTvmE-mCBZhl4_aUFGgjF7vRQt0IqwRsymCMcJPrbxhMoKvHQUZdoIllxlkD_NUWB6PWeDEUVb65TmxD2m2YayuB5DlPTX6h12QrksIPiKKsK3ygI8bSuURbGfCnvcYoWHt97Zg/s640/2017-07-13+00+40+45.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgELzWzzaTvmE-mCBZhl4%5FaUFGgjF7vRQt0IqwRsymCMcJPrbxhMoKvHQUZdoIllxlkD%5FNUWB6PWeDEUVb65TmxD2m2YayuB5DlPTX6h12QrksIPiKKsK3ygI8bSuURbGfCnvcYoWHt97Zg/s1600/2017-07-13+00+40+45.png)

  
建立使用者，使用者名稱"User"，密碼空著直接下一步

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEheWqGTNSKfn5WSE2_LXv8rwoBf2ut0AAdPapqkCQrQBUQqSqK9PMwH2i8LYBdpsGarCxwsVDjn5GfwobvEJ5raGKdTVY7Y0JHATZMHKobFepEdgliZtoaJMCijNzcSjnboMJ0CQcPqml9u/s640/2017-07-12+21+53+06.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEheWqGTNSKfn5WSE2%5FLXv8rwoBf2ut0AAdPapqkCQrQBUQqSqK9PMwH2i8LYBdpsGarCxwsVDjn5GfwobvEJ5raGKdTVY7Y0JHATZMHKobFepEdgliZtoaJMCijNzcSjnboMJ0CQcPqml9u/s1600/2017-07-12+21+53+06.png)

  
這裡全部不選，然後下一步到底

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO82GbFxCTuAlIKZAx0ShkiwNTiPuSDfGh3uTwdb5XyX6vA6sOT-ELGelaPDFatG3k9FCiQL2mjyXP4d093l3T8ZioVk4xQwwXWNeNLk4-ewASRvOZilp9pXxMuze16eOfuFzKDmEh5S9N/s640/2017-07-12+21+54+02.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO82GbFxCTuAlIKZAx0ShkiwNTiPuSDfGh3uTwdb5XyX6vA6sOT-ELGelaPDFatG3k9FCiQL2mjyXP4d093l3T8ZioVk4xQwwXWNeNLk4-ewASRvOZilp9pXxMuze16eOfuFzKDmEh5S9N/s1600/2017-07-12+21+54+02.png)

  
開進桌面第一件事，關更新

左下角工具列右鍵→設定→更新與安全性→進階選項

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEidWOSckrS5NSy1dqudVYM310byNjCov7cT4dQruOIaNgetBW8ASPDyR3oGlBuERI4NNOy-MLTstpzdsTrJ7lW5r0X71WozTWafs-zhdI9QVv3ouk9opnKZh8-jcszzMPbIo-bU4uFhwz-e/s640/2017-07-12+22+09+47.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEidWOSckrS5NSy1dqudVYM310byNjCov7cT4dQruOIaNgetBW8ASPDyR3oGlBuERI4NNOy-MLTstpzdsTrJ7lW5r0X71WozTWafs-zhdI9QVv3ouk9opnKZh8-jcszzMPbIo-bU4uFhwz-e/s1600/2017-07-12+22+09+47.png)

  
把它全部延到最長  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGYAOPdWG5Jr2D5BMuywlKdYuV3ilzeXZ60U-ZgjTlYZKc2VZ3_sHWNmpjYVDi15SUYfUs8UA2P93V6nzk4uvTFX5AswuK93dL0LFyg-gsFpK7z9MuQovpmSR6lWp0-fv_uy7XVE9afVfk/s640/2017-07-12+22+10+38.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGYAOPdWG5Jr2D5BMuywlKdYuV3ilzeXZ60U-ZgjTlYZKc2VZ3%5FsHWNmpjYVDi15SUYfUs8UA2P93V6nzk4uvTFX5AswuK93dL0LFyg-gsFpK7z9MuQovpmSR6lWp0-fv%5Fuy7XVE9afVfk/s1600/2017-07-12+22+10+38.png)

  
然後是關防毒  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOsZJ8AvVYbHtND2d5hTXTAUtm4PnbqliS3ZbLzR6oVt-yTCAi7WhdPFxLFejScrZXMn92tfdTh3m2-umBc03Q-Or10FbXSm-fZoJFRF3uACjr3uApNKGNlO0v42KNipoxudjV-HqEp0C7/s640/2017-07-13+00+47+48.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOsZJ8AvVYbHtND2d5hTXTAUtm4PnbqliS3ZbLzR6oVt-yTCAi7WhdPFxLFejScrZXMn92tfdTh3m2-umBc03Q-Or10FbXSm-fZoJFRF3uACjr3uApNKGNlO0v42KNipoxudjV-HqEp0C7/s1600/2017-07-13+00+47+48.png)

  
把所有盤符都加到例外清單  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuFgYxCgKpsGOFqCvvBWYwP98oQBmATfb0XBOyiOc188Ufl8Ajlr9YNozU9aP3yn_bnrw0fTmUdPfeXq65PISP8JL3aWqlM6INQ2ib89J7SjATVDMORz6NRfLRUVxH3K0JKlELvIUk60X8/s640/2017-07-13+00+49+25.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuFgYxCgKpsGOFqCvvBWYwP98oQBmATfb0XBOyiOc188Ufl8Ajlr9YNozU9aP3yn%5Fbnrw0fTmUdPfeXq65PISP8JL3aWqlM6INQ2ib89J7SjATVDMORz6NRfLRUVxH3K0JKlELvIUk60X8/s1600/2017-07-13+00+49+25.png)

  
可以看到，剛灌好就吃掉了8G  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJdVEtYBrTl8h_PJh2FTGhoU4AnnPf2z3ogSLoZ25dba-8Ur3AoUfFuYqKpTgBWBFjAxG1udzwgjMhAW0ZsesiJ2RitFuynFBE_TAj_binkAw5pZUYgmbWuhQpb5sXcAzHzCDprRQhglN7/s640/2017-07-13+00+51+55.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJdVEtYBrTl8h%5FPJh2FTGhoU4AnnPf2z3ogSLoZ25dba-8Ur3AoUfFuYqKpTgBWBFjAxG1udzwgjMhAW0ZsesiJ2RitFuynFBE%5FTAj%5FbinkAw5pZUYgmbWuhQpb5sXcAzHzCDprRQhglN7/s1600/2017-07-13+00+51+55.png)

  
然後開始清理系統，把常用的東西裝上去  
這部分請按照喜好自己處理 \~  

以下直接秀我的調教成果

(圖內的EWF先無視，我是拿了另一個完成的source來截圖)

  
※注意不要裝太多軟體，盡量使用Portable版，放在"USB:\\\\Data\\"資料夾下，不要占用VHD的空間

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhn3TX_FpfG_f2vi3De96KMgkJOb0uRiINulDG3qFvHcU74MSQtrihP_7Z4GQh7VyAriHirSY91pz543qH_y5xphrUAB5ONEB083wKJ45kXmM6sOA-KKk2zNZt4j6yQp10IqeaVZcCOEaQv/s640/2017-07-12+22+41+45.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhn3TX%5FFpfG%5Ff2vi3De96KMgkJOb0uRiINulDG3qFvHcU74MSQtrihP%5F7Z4GQh7VyAriHirSY91pz543qH%5Fy5xphrUAB5ONEB083wKJ45kXmM6sOA-KKk2zNZt4j6yQp10IqeaVZcCOEaQv/s1600/2017-07-12+22+41+45.png)

  
可以看到基本上接近吃滿了

主要是Office吃很大

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRKRocbyp9AfENzZ8gdLEiN8opUvbNl0mBPOvut3o2ki8xxOIvVKD8FGkBGHbD2oXX98RNFFTI-O9NoRwTnu6TKAMvstRUyNg-2YVoyrydcEngKRz-oQE9bPiLJ8dpMQLpOZXqh1DosB8U/s640/2017-07-12+22+39+05.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRKRocbyp9AfENzZ8gdLEiN8opUvbNl0mBPOvut3o2ki8xxOIvVKD8FGkBGHbD2oXX98RNFFTI-O9NoRwTnu6TKAMvstRUyNg-2YVoyrydcEngKRz-oQE9bPiLJ8dpMQLpOZXqh1DosB8U/s1600/2017-07-12+22+39+05.png)

  
防毒會報毒的東西都放在VHD裡面  
免得開其他系統時跳出殺毒  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhR-BIpU8Cy2KAGnNNeeveTBbdh2Ek8i6fJlBDAEee2ekpNCAPjlJpil9kn3rIqW8ZOL46qKrRNUwEfO7STMI8CNxFy9vA392X6UvZ4NxXzwaVeXwnwNxKaXW6VmX47N4JnB7yEDc36tTRq/s640/2017-07-12+22+40+22.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhR-BIpU8Cy2KAGnNNeeveTBbdh2Ek8i6fJlBDAEee2ekpNCAPjlJpil9kn3rIqW8ZOL46qKrRNUwEfO7STMI8CNxFy9vA392X6UvZ4NxXzwaVeXwnwNxKaXW6VmX47N4JnB7yEDc36tTRq/s1600/2017-07-12+22+40+22.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEG9tlVP6euDMx_umkWE5AsWj5gmYL8CfW5VQNsBW2bDWadjjeoSSAKKgvWqR9oOc4ZhNTAnnW1SFm5cNlLJyot3je5QKON4n183sDqrg1lBH0a-bAjkcyHxiiQwqRqrKYphRhK3aZfNMf/s640/2017-07-12+22+41+11.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEG9tlVP6euDMx%5FumkWE5AsWj5gmYL8CfW5VQNsBW2bDWadjjeoSSAKKgvWqR9oOc4ZhNTAnnW1SFm5cNlLJyot3je5QKON4n183sDqrg1lBH0a-bAjkcyHxiiQwqRqrKYphRhK3aZfNMf/s1600/2017-07-12+22+41+11.png)

  
### 安裝EWF影子系統

在安裝EWF以前請把win10.vhd複製一份備份起來  
免得萬一安裝失敗了要重做系統

  
請下載EWF: [MEGA](https://mega.nz/#!R5RnkR4S!lkx8tW4bb%5FgaEGnueyxWpciUpC5KS0EO6Sv7SsfWV9M)

  
把下載的EWF解壓縮，放進VHD內的文件底下

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgw8xOKYo_zzn8VXUiqtHyDm5TRWm3MpAtGYTcUVrK75RbzTHG0dpIXO2qV4ihk2-cbqYwvwpsOh32876wBk3d8SqBl-K0P6BMtxrfhmzZh2z3eRI7rOathpYq9fQeGfU7rZaeOnerB8b6p/s640/2017-07-12+23+08+38.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgw8xOKYo%5Fzzn8VXUiqtHyDm5TRWm3MpAtGYTcUVrK75RbzTHG0dpIXO2qV4ihk2-cbqYwvwpsOh32876wBk3d8SqBl-K0P6BMtxrfhmzZh2z3eRI7rOathpYq9fQeGfU7rZaeOnerB8b6p/s1600/2017-07-12+23+08+38.png)

  
把"\\EWF for x86 + x64\\EWF for x86 + x64\\EWF-W7(x64)"資料夾下的"System32"、"SysWOW64"兩個資料夾複製到"C:\\Windows"下

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgYIuj148dgMwVVE7LNfgOtlGBx-L5mhcIrPuSPWCb1XzqmlRFZJDvqe2eim0AxSm827UEPf_AxQaiRqk3EYB3ywhdf48zwVYsGY2hnW95nJ52rQOU7I-y1k2TpuTsBnyj5P7nUplJJkR9r/s640/2017-07-13+00+55+17.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgYIuj148dgMwVVE7LNfgOtlGBx-L5mhcIrPuSPWCb1XzqmlRFZJDvqe2eim0AxSm827UEPf%5FAxQaiRqk3EYB3ywhdf48zwVYsGY2hnW95nJ52rQOU7I-y1k2TpuTsBnyj5P7nUplJJkR9r/s1600/2017-07-13+00+55+17.png)

  
"ewf.reg"登錄檔右鍵→合併  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEir-0SeRVBZKBhyphenhyphenUSZpiLZ3_dR1qb8SSy_jn8eVuKn1rGjeciYp6JdGigqNAtqMmKgzxHsULKV85e2zdqeqDQMpK9WsAu6MqDM9ZFZz3UePae24a1kK3bRzK9hMV-ZN5sygzqL7mQKBrCcn/s640/%25E6%259C%25AA%25E5%2591%25BD%25E5%2590%258D.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEir-0SeRVBZKBhyphenhyphenUSZpiLZ3%5FdR1qb8SSy%5Fjn8eVuKn1rGjeciYp6JdGigqNAtqMmKgzxHsULKV85e2zdqeqDQMpK9WsAu6MqDM9ZFZz3UePae24a1kK3bRzK9hMV-ZN5sygzqL7mQKBrCcn/s1600/%25E6%259C%25AA%25E5%2591%25BD%25E5%2590%258D.png)

  
重新啟動

  
開起來後，系統管理員開啟cmd

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiWTak3sKpJN6jJdT4fC-2c6DqhexkKMFICw7pIgv_w8LP-n8YevqpaUE2mcTH54qNJslXjPGZ1hYLGezDFGxjixAKbT1RIsdu7DA8G_e-gjv3-StsV8JAFmZTmvhIa-QQqZ42xnwayvM30/s640/1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiWTak3sKpJN6jJdT4fC-2c6DqhexkKMFICw7pIgv%5Fw8LP-n8YevqpaUE2mcTH54qNJslXjPGZ1hYLGezDFGxjixAKbT1RIsdu7DA8G%5Fe-gjv3-StsV8JAFmZTmvhIa-QQqZ42xnwayvM30/s1600/1.png)

  
執行"ewfcfg -install"，看到completed即可  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjM0j6SxSgashpM-K_NsKKxFxmhxiQ60dD-HbmZzWfb5JD8gt8XpK-5U8ppRPdeX6mbDZmYprlCG4iQn_fTneiyIazjM-o_Xtnv42bu_Rzx4Xk8CipUXVoO7C7yUeM1jFa8-ocCnTfTILxj/s640/2017-07-13+01+06+37.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjM0j6SxSgashpM-K%5FNsKKxFxmhxiQ60dD-HbmZzWfb5JD8gt8XpK-5U8ppRPdeX6mbDZmYprlCG4iQn%5FfTneiyIazjM-o%5FXtnv42bu%5FRzx4Xk8CipUXVoO7C7yUeM1jFa8-ocCnTfTILxj/s1600/2017-07-13+01+06+37.png)

  
到 C:\\WINDOWS 下將 "bootstat.dat" 重新命名為"bootstat.dat.old"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi-ULv00Mrrz_kVijG84EgOLWtUAf2EzebpsmaGp8kFre_yWUbJwsqhvve3tjQxiCyqNxWEZYLFRrlkxQlM4k0MwnIUlPYWr6Hl0URncMbiJPToa5LlIjAHzmT8j3auzXKpf4QYwLjfVaUR/s640/2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi-ULv00Mrrz%5FkVijG84EgOLWtUAf2EzebpsmaGp8kFre%5FyWUbJwsqhvve3tjQxiCyqNxWEZYLFRrlkxQlM4k0MwnIUlPYWr6Hl0URncMbiJPToa5LlIjAHzmT8j3auzXKpf4QYwLjfVaUR/s1600/2.png)

  
再次重新啟動

  
再次系統管理員開啟cmd，執行"ewfmgr C: -enable"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0gX71PDgBu3PxCe4qH1L2UwHJ5eq9BHcNlkf3MSB8KemD8-qRCox6d6S1gNE_guUnLqheaqHBy2db8hyJ4VHvFMyXAw7nHksSJvOM-0Uj-N6dsDoh2zl0Jnj-fiGkSY3WFH-v-NJSggCw/s640/2017-07-13+01+16+56.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0gX71PDgBu3PxCe4qH1L2UwHJ5eq9BHcNlkf3MSB8KemD8-qRCox6d6S1gNE%5FguUnLqheaqHBy2db8hyJ4VHvFMyXAw7nHksSJvOM-0Uj-N6dsDoh2zl0Jnj-fiGkSY3WFH-v-NJSggCw/s1600/2017-07-13+01+16+56.png)

  
回到我的文件，將圖中四個cmd檔案傳送捷徑到桌面

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAt_luv9hgK4l1t47F9cVTHAtHp-B8JBkYoI0ScqC0yF7ebDAhHL2kxi4_JzSbfoqWG0D3AHeByloNUGA-bte4H6E1SFpdo5KWPSM5cmks12bv11PnzKlpI9JOYxQCSoWdCI_XU4iyvs5n/s640/2017-07-13+01+18+52.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAt%5Fluv9hgK4l1t47F9cVTHAtHp-B8JBkYoI0ScqC0yF7ebDAhHL2kxi4%5FJzSbfoqWG0D3AHeByloNUGA-bte4H6E1SFpdo5KWPSM5cmks12bv11PnzKlpI9JOYxQCSoWdCI%5FXU4iyvs5n/s1600/2017-07-13+01+18+52.png)

  
對著捷徑右鍵→內容→進階→以系統管理員身分執行→確定套用，四個捷徑都要分別做

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifwf963xG7BXQ4Ta_LpY44AjVVOmvQJx1JIQbnI8tHGbr0vCgGXVBS_ngel90W5cHaM4n8UVgfiQFA4gkTaQ2MgCXUWVN2STTgGp_G7c5XWsZAVtZ6qOz92rmXViT4_rK_a3QVmT0ihAL_/s640/2017-07-13+01+21+41.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifwf963xG7BXQ4Ta%5FLpY44AjVVOmvQJx1JIQbnI8tHGbr0vCgGXVBS%5Fngel90W5cHaM4n8UVgfiQFA4gkTaQ2MgCXUWVN2STTgGp%5FG7c5XWsZAVtZ6qOz92rmXViT4%5FrK%5Fa3QVmT0ihAL%5F/s1600/2017-07-13+01+21+41.png)

  
> 以下補充四個捷徑的用法:  
> SAVE.bat 是保存本次數據並重啟。  
> (就是對系統做出修改設置後，點擊這個會重啟保存你的設置，  
> 因為EWF 不許對保護的系統盤-做任何修改，只有通過這種方式  
> 保存你的修改，否則你裝進任何軟體-重啟之後就沒有了，但是  
> 點擊這個重啟後，設置會被保存。)  
> TurnOff.bat 是保存本次數據.並重啟動及關閉EWF 覆蓋層。  
> (簡單來說就是關掉EWF)  
> TurnOn.bat 就是開啟覆蓋層並重啟。(就是再次啟用了)  
> Status.bat 查看當前EWF設定狀態。(查看現在是否有啟用)

這樣EWF就設定完成拉\~

可以放心地連上網路了\~

  
### TroubleShooting

Q: Grub4Dos畫面有出來，但是有些功能開不進去，顯示Error 60  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8WFU3rZlROKvg1aOpLhWFEcZQCccjMSAKH95qQ_x9yb8IohPsyzQ1eew-cpPLCbiRq9jEAMNnnRlsPVksho7nUCzZ6xd_nxcWXV2FA925PyC56SgY9ve0gCEnynFcOX5j0UrsLVie14rL/s640/2013_01_21_14_02_49.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8WFU3rZlROKvg1aOpLhWFEcZQCccjMSAKH95qQ%5Fx9yb8IohPsyzQ1eew-cpPLCbiRq9jEAMNnnRlsPVksho7nUCzZ6xd%5FnxcWXV2FA925PyC56SgY9ve0gCEnynFcOX5j0UrsLVie14rL/s1600/2013%5F01%5F21%5F14%5F02%5F49.jpg)

  
A: 所有ISO跟VHD檔案在磁碟上必須連續

1. 用WinContig程式檢查是否有碎片
2. 將有碎片之檔案移出，用SmartDefrag的Free Space Defrag功能把空間重組到一起，再複製回去
3. 再不行，將整支隨身碟內容複製出來，格式化掉，再複製回去(注意勿遺漏隱藏檔案及重作BOOTICE引導)