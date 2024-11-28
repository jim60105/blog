+++
title = "多重開機USB製作 及 開機選單修改(上) - 建立開機USB"
description = "多重開機USB製作 及 開機選單修改(上) - 建立開機USB"
date = 2017-07-08T12:47:00.006Z
updated = 2022-02-07T11:12:17.964Z
draft = false
aliases = ["/2017/07/usb-usb.html"]

[taxonomies]
tags = ["資訊科技"]

[extra]
banner = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhDNcE1WYc0XxFKropYJAkvHV_uKRiGnCpxbxqasDDiTjBWoMEShE6WRd4phBDVAUJ7OcM-nhVh4B_dxLBowM6BBCE24foPuHdXfwtYOb2oj5Z0AqDxmxiiEScbtv6MDosFF9gYwflKr7DI/s640/2018-08-06+17+55+37.png"
+++
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhDNcE1WYc0XxFKropYJAkvHV_uKRiGnCpxbxqasDDiTjBWoMEShE6WRd4phBDVAUJ7OcM-nhVh4B_dxLBowM6BBCE24foPuHdXfwtYOb2oj5Z0AqDxmxiiEScbtv6MDosFF9gYwflKr7DI/s640/2018-08-06+17+55+37.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhDNcE1WYc0XxFKropYJAkvHV%5FuKRiGnCpxbxqasDDiTjBWoMEShE6WRd4phBDVAUJ7OcM-nhVh4B%5FdxLBowM6BBCE24foPuHdXfwtYOb2oj5Z0AqDxmxiiEScbtv6MDosFF9gYwflKr7DI/s1600/2018-08-06+17+55+37.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhK-YkBhujGHVZT9AWAArPb2L9ySfb90I04KAHmsqBz3MQYBJeyvLdZkiq6S8I2IcXErAZJA5Up9oF4x_SI8b1OButmo4bdRU4UprMp7Y5rQCFoliFvG3mlszHPKVS_C0U8ripyIMFIGH9p/s640/2018-08-06+17+56+23.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhK-YkBhujGHVZT9AWAArPb2L9ySfb90I04KAHmsqBz3MQYBJeyvLdZkiq6S8I2IcXErAZJA5Up9oF4x%5FSI8b1OButmo4bdRU4UprMp7Y5rQCFoliFvG3mlszHPKVS%5FC0U8ripyIMFIGH9p/s1600/2018-08-06+17+56+23.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjkP6UtKKGnckfAWWBzdmVYJCC7XhI9ZQeYA98bzCSraezLaoVZ_xUeuhtyKNtyIfRUPe1lurHG3TGVYQxVBNRq5gnMsZ9vnceRsB1Xy9S93X6PU6il9jUqqZ0KSWjDmkOEqI-gTmdx7prr/s640/2018-08-06+17+57+37.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjkP6UtKKGnckfAWWBzdmVYJCC7XhI9ZQeYA98bzCSraezLaoVZ%5FxUeuhtyKNtyIfRUPe1lurHG3TGVYQxVBNRq5gnMsZ9vnceRsB1Xy9S93X6PU6il9jUqqZ0KSWjDmkOEqI-gTmdx7prr/s1600/2018-08-06+17+57+37.png)

  
## 2018/08/03 更新

1. 新增UEFI開機支援，修改自: [這裡](https://www.microduo.tw/forum.php?mod=viewthread&tid=33430)
2. 刪除Windows 8 PE
3. Windows 10 PE換成[USBOX v3.1](http://hsuanthony.pixnet.net/blog/post/220334610-usbox-3.1-2018%E6%96%B0%E5%B9%B4%E9%9A%86%E9%87%8D%E7%99%BB%E5%A0%B4~~-win10pe%E6%94%AF%E6%8C%81%E7%B6%B2%E8%B7%AF-%E5%8A%A0)
4. 修正Windows 7&10 安裝ISO使用Firadisk引導，並且自己寫了對應Windows 10的AutoUnattend.xml
5. Arconis True Image更新至2018
6. 「記憶體硬體檢測」更名為「硬體檢測工具」
   1. 新增Lenovo Linux Bootable Diagnostics-4201聯想電腦硬體檢測工具
   2. Memtest86更新至7.5 Pro版(UEFI)

  
## 前言

身為一個電腦維修工程師，一定要有一支開機維護隨身碟。剛入行的時候是拿給同事請他做，去年我重新修改製作了自己的版本。最近公司合約進了一批最新的電腦，預設沒開Lagacy也不吃Win7，所以這次我把此工具新增支援UEFI，ISO做了一些更新，修正安裝光碟上的引導問題等。  
  
此工具主要融合自:  
* [SuperUSB v6 – 電腦維護的利器 | 格雷資訊](https://www.grayfree.tw/archives/716)
* [《【原创】主要针对服务器的专业维护人员使用的直接调用ATI.iso和kav\_rescue\_10.iso的小工具 》](https://www.microduo.tw/forum.php?mod=viewthread&tid=33430)
* [如何讓NTFS也能UEFI開機？](https://www.grayfree.tw/archives/728)
* [《把PE集成进启动U盘的两种不同的集成方式所造成的PE在使用上的一点重大差别》](https://www.microduo.tw/thread-34842-1-1.html)
* [Windows快速装机中心——IQI9、OBR、DQI全家桶](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=402718&extra=&page=1)

  
## 步驟大綱

本系列分成兩篇敘述，上篇老少皆宜，下篇屬於困難級，請適當斟酌  
  
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

## 準備

開工前請先備妥以下東西:

1. 載體: USB\*1 (容量及細部規格見後述)
2. 製作平台: Windows 系統(Mac、Linux部分工具須找代用品)
3. 工具:
   1. BOOTICE v1.3.3.2  
   <http://www.ipauly.com/2015/11/15/bootice/>  
   [](https://sites.google.com/site/gbrtools/home/software/bootice-portable/bootice-downloads)
   2. 簡易啟動測試器v4.0 Beta6  
   <https://edp.idv.tw/wp-content/uploads/2016/10/qmenu.zip>
   3. DiskGenius  
   <http://www.diskgenius.cn/download.php>
   4. IObit SmartDefrag Portable  
   <http://www.azofreeware.com/2007/01/iobit-smartdefrag-beta-201.html>
   5. WinContig Portable  
   <http://www.azofreeware.com/2014/03/wincontig-120b.html>
4. 安裝包: [下載點](https://drive.maki0419.com/d/s/nOb7v9DH1pjl5rbTX5dGRxs3cySx0tC7/QXPkPYgitMwW%5FWeyG6wDrSdTRcIXvyJP-RLEgX4qpRwk)  
家用NAS請愛護它

## USB的選擇

容量請選擇至少8G或以上，USB2.0、USB3.0建議各做一支。理論上此工具Base模式少於8G，但是我手邊沒有U2 8G可以測試，也不想去買垃圾，所以未做測試。U3速度快，運行較不會LAG，但是實務上並非所有機器都能適用U3(舊硬體、驅動等)，所以建議各做一支。另外，此篇文章所製作之成果為15.7G，需要32G USB，若包含下篇之VHD全部是33G，要64G USB才裝得下，否則就要適當取捨。

  
建議:

USB2.0: 8G、16G

USB3.0: 32G、64G

  
實測可用USB:

1. Kingston DTSE9H (U2 16G)
2. Kingston DT101 G2 (U2 16G)
3. Kingston DT50 (U3.1 16G)
4. ~~ADATA UV128 (U3 32G)~~(開機有時抓不到)
5. SANDISK ULTRA FLAIR USB 3.0 (U3 64G) ←推👍

## 正文

### 事前

在開始以前，請先開啟「顯示隱藏檔案」，關閉「隱藏已知檔案類型的副檔名」、「隱藏保護的作業系統檔案」  
  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7pDmdyHN62eHhUZIdpbyNzaW1tXBdBjgqB1tL92fdgHH1nYZpsWBASqp7wRDakYgtRYaSdyYN2eA_bIyVH4fvXfNbm5Xb_MMuToC3q1xc3ZGvl8ixL4NVpmM556t9Ad73LMNFmRS9pOZO/s1600/2017-07-09+19+17+54.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7pDmdyHN62eHhUZIdpbyNzaW1tXBdBjgqB1tL92fdgHH1nYZpsWBASqp7wRDakYgtRYaSdyYN2eA%5FbIyVH4fvXfNbm5Xb%5FMMuToC3q1xc3ZGvl8ixL4NVpmM556t9Ad73LMNFmRS9pOZO/s1600/2017-07-09+19+17+54.png)

  
### 處理磁碟分割及引導

開啟DiskGenius，USB磁碟上右鍵，清除所有分區  
※注意：此USB所有文件將會刪除   

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMjBFbl4CagPn7vNwba3wyt3ipjJYp_7RsfimD1WLnaKU6XSEdSfUYIIcabH7n-Xe8q0tCQRfEKJsxDxRj1rHvL2lW4Gy1v_LLXdWLLbbKxUqAqHA2ZnsUMEdNX6O2Bk4EGdrRuNSRMxI4/s640/1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMjBFbl4CagPn7vNwba3wyt3ipjJYp%5F7RsfimD1WLnaKU6XSEdSfUYIIcabH7n-Xe8q0tCQRfEKJsxDxRj1rHvL2lW4Gy1v%5FLLXdWLLbbKxUqAqHA2ZnsUMEdNX6O2Bk4EGdrRuNSRMxI4/s1600/1.png)
  
  
選擇磁碟後，使用快速分區，確認圓圈處沒有選擇錯誤，創建2個分區 ，設置分割區如下  
1. NTFS，容量自動帶，主要分割
2. FAT32，容量256MB，主要分割

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhl8VJFDJ6IzIfl6q79CDNEUhKwWF-_gjWYV5VUFbgJjR9kHDWOhyphenhyphenc0-nzqy4d75Q4cbkBcbs4vWcbDW9ecQcuE4yY7Ln59hCUlNUtCh6P325550Lyed1wKsXfrAOEMWmo1veXkp2fXAiiB/s640/3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhl8VJFDJ6IzIfl6q79CDNEUhKwWF-%5FgjWYV5VUFbgJjR9kHDWOhyphenhyphenc0-nzqy4d75Q4cbkBcbs4vWcbDW9ecQcuE4yY7Ln59hCUlNUtCh6P325550Lyed1wKsXfrAOEMWmo1veXkp2fXAiiB/s1600/3.png)

  
格式化完成後第一個分區應該會自動掛載如圖  
選擇第二個FAT32分區，右鍵「從鏡像檔還原分區 」，倒進這裡提供的uefi256M.pmf  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO2-SB-Un34ALcq0yxNi97MAJql3UJDSc-xkGY2whlFu0Ttalvt3s1-H43t8LKOTytQmIxL7mfI4X2BIAlPkaDAs2Gh9L5_TXtlPdeTXhUMIGMCF05PyOrzn9jnnjt7gH5zCK9QlZ3w_Yf/s640/4.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO2-SB-Un34ALcq0yxNi97MAJql3UJDSc-xkGY2whlFu0Ttalvt3s1-H43t8LKOTytQmIxL7mfI4X2BIAlPkaDAs2Gh9L5%5FTXtlPdeTXhUMIGMCF05PyOrzn9jnnjt7gH5zCK9QlZ3w%5FYf/s1600/4.png)

  
開啟BOOTICE，選擇到目標USB，主引導記錄，選擇 Grub4dos0.4.6a，其餘設置如圖，寫入磁片  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpvMnGlGOAUJ7rdO2Mh-uKfgJkvbFQK98Y7yL6_g4BJyFzfvRsLvPhTrGJm4p88i2rXPvU1TCDMrVY3e3OatVAI0LOJ_riWMPvYL66hTFDSEOAcgpqzg5UdoeRyrssMbixjde2x0Oz5XhW/s640/5.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpvMnGlGOAUJ7rdO2Mh-uKfgJkvbFQK98Y7yL6%5Fg4BJyFzfvRsLvPhTrGJm4p88i2rXPvU1TCDMrVY3e3OatVAI0LOJ%5FriWMPvYL66hTFDSEOAcgpqzg5UdoeRyrssMbixjde2x0Oz5XhW/s1600/5.png)

  
BOOTICE分區管理，將自動掛載的盤符刪除  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZviDnGviKgePiC53kVZ7A4WJ7yR3mhWt7vZTTOrxI0QuAoKJbvOdu55UOdAxsgZMFng7gRRuenJOQyNylMs38_6-IH3jO1-uAxWGaFbvYH4kfElnQtwYRgZK9eLABX3wLAFMm5OE2yA09/s640/6.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZviDnGviKgePiC53kVZ7A4WJ7yR3mhWt7vZTTOrxI0QuAoKJbvOdu55UOdAxsgZMFng7gRRuenJOQyNylMs38%5F6-IH3jO1-uAxWGaFbvYH4kfElnQtwYRgZK9eLABX3wLAFMm5OE2yA09/s1600/6.png)

  
盤符改變後按下最左側的「刷新」，注意要選擇到目標USB  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi17eX0SeHaLI5y5-3Fo_wsX5UUxhUmO2Ibn8E2ar-Ip2aYUJ1-DStGwLE9HHxPk7SWLB_3WEwlwielNr5pleWhEQq17OETn8otDizNknL6ixzBwGMDz9dSoAsE6N1BB_sBqXjW67gfx35R/s640/2018-08-10+17+26+31.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi17eX0SeHaLI5y5-3Fo%5FwsX5UUxhUmO2Ibn8E2ar-Ip2aYUJ1-DStGwLE9HHxPk7SWLB%5F3WEwlwielNr5pleWhEQq17OETn8otDizNknL6ixzBwGMDz9dSoAsE6N1BB%5FsBqXjW67gfx35R/s1600/2018-08-10+17+26+31.png)

  
BOOTICE分區引導記錄，選擇Grub4dos 0.4.6a，兩個分區都要修改  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjTyVCouI0aCu4wVSNl9523At4K0GrZOqfaGsZXcsiRs9QzFOeAKIcbbD67LQDArmxcGO21n9rEf43x0E9-WbVdvzFaUo26DT3Hn1cDviD3deg83AmvEHDNAyHGLX3UXqKf3LvG9gqjNK42/s640/7.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjTyVCouI0aCu4wVSNl9523At4K0GrZOqfaGsZXcsiRs9QzFOeAKIcbbD67LQDArmxcGO21n9rEf43x0E9-WbVdvzFaUo26DT3Hn1cDviD3deg83AmvEHDNAyHGLX3UXqKf3LvG9gqjNK42/s1600/7.png)

  
將第一分區盤符恢復  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhSYpk-dv1k_v0EIRAlRjAR5XaPZP0EU7Z0le8Z5gWahNwapEIHKgnmA2CcAHvwvnf8KnkkKgh0c8YmD1Ki-Ryc6Q6sO3NfPBssLzcGLlX_meBFXjkK3ZvGLabqc3LbSTO8aty6P6cxSSt7/s640/2018-08-06+17+50+33.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhSYpk-dv1k%5Fv0EIRAlRjAR5XaPZP0EU7Z0le8Z5gWahNwapEIHKgnmA2CcAHvwvnf8KnkkKgh0c8YmD1Ki-Ryc6Q6sO3NfPBssLzcGLlX%5FmeBFXjkK3ZvGLabqc3LbSTO8aty6P6cxSSt7/s1600/2018-08-06+17+50+33.png)

  
### 安裝Base模式(8G)

解壓縮base.rar，將檔案全部丟進去就是了  
特別注意有沒有忘記開隱藏檔，請比對一下圖片  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVzBi2K0VIkYsATeGt00uhXI6gnS2J9nO0al6CcmFsdCObFnEnO1qrq80oVOGXjTl3DXqKInlISktazUMkums925rtiCfl0jWExXXpx65h5LbFVQDtiYxUVpHLIVjeVw6UL5a1Xi5UT_Cp/s640/2018-08-10+17+21+19.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVzBi2K0VIkYsATeGt00uhXI6gnS2J9nO0al6CcmFsdCObFnEnO1qrq80oVOGXjTl3DXqKInlISktazUMkums925rtiCfl0jWExXXpx65h5LbFVQDtiYxUVpHLIVjeVw6UL5a1Xi5UT%5FCp/s1600/2018-08-10+17+21+19.png)

  
### 安裝Add模式(16G)

必須要先安裝Base模式   
Add模式相比Base模式新增了Windows7、Windows10安裝光碟  
需要至少16G以上的USB   
解壓縮add.rar，將檔案全部覆蓋進去就行  
  
### 安裝Add\_xp模式(32G)

必須要先安裝Base模式   
Add\_xp模式又再增加了xp安裝光碟  
總共需要至少32G以上的USB   
解壓縮add\_xp.rar，將檔案全部覆蓋進去就行  
  
如果未安裝Add模式但是要Add\_xp的話，修改os.lst將Windows7、Windows10的引導部分刪除即可  
  
### 安裝Tools

Tools資料夾下有分為「Recommend」和「Optional」  
如果是16G USB，請使用 Recommend 資料夾，若是32G以上可再加上 Optional 資料夾  
  
### 測試成果

開機進BOOT選單，選擇從USB開機，若要使用UEFI則選擇第二分割區  
原則上我會建議先試Legacy，出錯誤再試UEFI，UEFI當成備援就好  
  
Base + Tools(Recommend)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzpzldIfgYIjTXMv1s6cB0EELgp7W8lo8xZqFy_eFc4QCmLx-RcooFiKhffMAlpghO6ca-XcYxAG_nAzVp95Yg6F_s-MJfHgznGOYtI4Iz9EsLWWRZwL8cnf78s0JxDzm8a_wICnvJr2oi/s400/base%252Btool%2528Re%2529.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzpzldIfgYIjTXMv1s6cB0EELgp7W8lo8xZqFy%5FeFc4QCmLx-RcooFiKhffMAlpghO6ca-XcYxAG%5FnAzVp95Yg6F%5Fs-MJfHgznGOYtI4Iz9EsLWWRZwL8cnf78s0JxDzm8a%5FwICnvJr2oi/s1600/base%252Btool%2528Re%2529.png)

  
Base + Add + Tools(Recommend)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3PO_DUXry5n2tZG_4U2zWNJCpP5_1D6gsPk17KRRx8qLIb0MjR90Wa7jmtUPgXwpCc3DIy5x3cZx5zQl3EAbBk1JWZiUV4WePWLAvlzReq9Z6MC-Wn1Gf_-rJ6IEY6OwN5vG9bAm5S1hi/s400/base%252Badd%252Btool%2528Re%2529.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3PO%5FDUXry5n2tZG%5F4U2zWNJCpP5%5F1D6gsPk17KRRx8qLIb0MjR90Wa7jmtUPgXwpCc3DIy5x3cZx5zQl3EAbBk1JWZiUV4WePWLAvlzReq9Z6MC-Wn1Gf%5F-rJ6IEY6OwN5vG9bAm5S1hi/s1600/base%252Badd%252Btool%2528Re%2529.png)

  
Base + Add + Add\_xp + Tools(All)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQricIdI6BF01YLNaXxQf8RZ1Po49_JnIjNbPGUg1354DfZhgWmzc8OlKgTSN5GXhvrHpek9gUf80L9nB4q8lWQ-GBZes5Wnss7SsVItugV0fCQT0h0TslUgOMldI57yI9VbIBHBR0BNU4/s400/2018-08-14+14+11+10.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQricIdI6BF01YLNaXxQf8RZ1Po49%5FJnIjNbPGUg1354DfZhgWmzc8OlKgTSN5GXhvrHpek9gUf80L9nB4q8lWQ-GBZes5Wnss7SsVItugV0fCQT0h0TslUgOMldI57yI9VbIBHBR0BNU4/s1600/2018-08-14+14+11+10.png)

  
Base + Add + Add\_xp + Tools(All) + VHD

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifmu7b5cuB5R47zK4sepmXJC8kmvL6QbZuefOtTsylBL6r2mwQtmG6aRbquOlO9oJZZy0nI4Tyc_0C1aklQsA7CfGhrCUdyY-uoZ1Je7HDT6wGrxaTDShXBY4P_O5Y0XCyXCY6g5EhB_N_/s400/all%252BVHD.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifmu7b5cuB5R47zK4sepmXJC8kmvL6QbZuefOtTsylBL6r2mwQtmG6aRbquOlO9oJZZy0nI4Tyc%5F0C1aklQsA7CfGhrCUdyY-uoZ1Je7HDT6wGrxaTDShXBY4P%5FO5Y0XCyXCY6g5EhB%5FN%5F/s1600/all%252BVHD.png)

  
### 注意事項

* UEFI模式請關閉Secure boot
* 有些機器無法開啟UEFI下的grub2文件管理器，應是該機器本身的支援問題  
(實測ASUS MD590可以成功啟動x64文件管理器，Lenovo M83就不行)
* 「簡易啟動測試器 v4.0 Beta6.exe」要用系統管理員執行，只能測試Legacy開機Menu
* 若修改了ISO，可以至List資料夾下修改menu文件
* XP安裝完成後會跳出一個亂碼視窗提到「Firadisk」字眼，此為「引導安裝光碟時所需要的驅動」的刪除程式，輸入Y即可執行刪除
* **請切記一定要注意：勿遺漏隱藏文件**

本系列分成上下兩篇，請接著閱讀[下篇](http://blog.maki0419.com/2017/07/usb3.html)

  
### 檔案來源:

1. USBOX v3.1 ISO版  
<http://hsuanthony.pixnet.net/blog/post/220334610-usbox-3.1-2018%E6%96%B0%E5%B9%B4%E9%9A%86%E9%87%8D%E7%99%BB%E5%A0%B4~~-win10pe%E6%94%AF%E6%8C%81%E7%B6%B2%E8%B7%AF-%E5%8A%A0>
2. Windows 7 多合一安裝光碟<http://leo160918.pixnet.net/blog/post/178121683-%E3%80%90windows-7-~-windows-10%E3%80%91windows-7-sp1-13in1>
3. Windows 10 安裝光碟  
<https://briian.com/23608/>
4. Windows XP 安裝光碟 (zh-tw\_windows\_xp\_professional\_with\_service\_pack\_3\_x86\_cd\_vl\_x14-74140)  
<http://mei881.pixnet.net/blog/post/93696616-windows-xp-professional-with-service-pack3>
5. ubuntu-16.04.4-desktop-i386  
<http://ftp.ubuntu-tw.org/mirror/ubuntu-releases/16.04/>
6. UEFI引導:  
<https://www.microduo.tw/forum.php?mod=viewthread&tid=33430>
7. 其餘:  
<https://www.grayfree.tw/archives/716>