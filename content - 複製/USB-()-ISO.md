+++
title = "多重開機USB製作 及 開機選單修改(中) - 引導重灌ISO"
description = "多重開機USB製作 及 開機選單修改(中) - 引導重灌ISO"
date = 2017-07-11T15:52:00.000Z
updated = 2020-11-24T14:56:53.457Z
draft = true
aliases = ["null"]

[taxonomies]
tags = ["資訊科技"]

[extra]
banner = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiioRS3knCfQvrPPeSFb9acwrswXfiDUuUV_eJ7gG5JVdQg5vi4n7a2mJOzr_hMl1am0aiJSMqR3fvfvjnX_HMgJKrf7D69l06bUwFB6hJeS_IwQtT6MvvgviIK7CGqU2HDNttFjPGu2L81/s640/main.png"
+++
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiioRS3knCfQvrPPeSFb9acwrswXfiDUuUV_eJ7gG5JVdQg5vi4n7a2mJOzr_hMl1am0aiJSMqR3fvfvjnX_HMgJKrf7D69l06bUwFB6hJeS_IwQtT6MvvgviIK7CGqU2HDNttFjPGu2L81/s640/main.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiioRS3knCfQvrPPeSFb9acwrswXfiDUuUV%5FeJ7gG5JVdQg5vi4n7a2mJOzr%5FhMl1am0aiJSMqR3fvfvjnX%5FHMgJKrf7D69l06bUwFB6hJeS%5FIwQtT6MvvgviIK7CGqU2HDNttFjPGu2L81/s1600/main.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhK6wmc7YasydBarzL2gtdkwSnlFVk-YeDLCuq_KUN3k46r7BjP8PzJreNFABNUC2VUexlU9Wyeya72xddqsvanyWOJszN3bRohDkAZNFAUIRJGcyEC8sgh_6SpsZxBOspJjp4qnx80iRdr/s640/%25E5%25AE%2589%25E8%25A3%259DOS.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhK6wmc7YasydBarzL2gtdkwSnlFVk-YeDLCuq%5FKUN3k46r7BjP8PzJreNFABNUC2VUexlU9Wyeya72xddqsvanyWOJszN3bRohDkAZNFAUIRJGcyEC8sgh%5F6SpsZxBOspJjp4qnx80iRdr/s1600/%25E5%25AE%2589%25E8%25A3%259DOS.png)
  
  
## 前言

\~本系列分成上中下三篇，請先閱讀[上篇](http://blog.jim60105.com/2017/07/usb.html)\~
  
  
Windows7和Windows10透過Grub4Dos引導十分的麻煩  

如果直接把iso拿來用會出現下面這個:  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEily-U0ygDNEpLUcdff5bmpkdomouRF_Wsp8R5VFzFU9JI8wr7Sqc6ELeJ_qKcqktPluI7Uq0_k-D_kOKycQmFX11AGD4snaxzPa32z6krnnnG5LYThSRru-b6NPQngFgts1puYJS2W5N0L/s640/Grub4Dos_Error-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEily-U0ygDNEpLUcdff5bmpkdomouRF%5FWsp8R5VFzFU9JI8wr7Sqc6ELeJ%5FqKcqktPluI7Uq0%5Fk-D%5FkOKycQmFX11AGD4snaxzPa32z6krnnnG5LYThSRru-b6NPQngFgts1puYJS2W5N0L/s1600/Grub4Dos%5FError-1.png)

沒看錯，並不是你眼睛業障重

他抓不到驅動....
  
  
解答是要透過imdisk掛載，才能正常執行  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjr8gT2X5BqKboHJ5iNY9iXXBlkP6oCj5c5EWy4IflHOdkXnIH23iRvCLB3PDbIvBVqEJHT9nPuoimBFcSpZgqmJU8X-86QsXF2Cio3in3UKRLFnmxct09hxj1UJzO8J8hhUVDDthQpu19V/s400/%25E6%2588%2591%25E4%25B8%258D%25E6%2598%25AF%25E9%2596%258B%25E7%258E%25A9%25E7%25AC%2591%25E9%2580%2599%25E6%2598%25AF%25E7%259C%259F%25E7%259A%2584+%25E5%2581%2587%25E7%259A%2584.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjr8gT2X5BqKboHJ5iNY9iXXBlkP6oCj5c5EWy4IflHOdkXnIH23iRvCLB3PDbIvBVqEJHT9nPuoimBFcSpZgqmJU8X-86QsXF2Cio3in3UKRLFnmxct09hxj1UJzO8J8hhUVDDthQpu19V/s1600/%25E6%2588%2591%25E4%25B8%258D%25E6%2598%25AF%25E9%2596%258B%25E7%258E%25A9%25E7%25AC%2591%25E9%2580%2599%25E6%2598%25AF%25E7%259C%259F%25E7%259A%2584+%25E5%2581%2587%25E7%259A%2584.png)

  
又另外，Windows7安裝時如果使用USB3.0孔插滑鼠鍵盤，你可能會發現滑鼠鍵盤完全不動  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNR9ie0WmiveMl6p6Ar3AIrTk8t5yiHwbRM6F37OYGtzrPu5l1OcX8Ludy36FqoH7a_v6VBTrm8PtxcjMtCHapVPaIZsbI_4rBPkpLD96QazLlEm6hQH585xr_alPeAuzKQ79hGL0_JqnR/s400/%25E7%259C%259F%25E6%2598%25AF%25E5%25A4%25A0%25E5%2599%2581%25E5%25BF%2583%25E7%259A%2584.JPG)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNR9ie0WmiveMl6p6Ar3AIrTk8t5yiHwbRM6F37OYGtzrPu5l1OcX8Ludy36FqoH7a%5Fv6VBTrm8PtxcjMtCHapVPaIZsbI%5F4rBPkpLD96QazLlEm6hQH585xr%5FalPeAuzKQ79hGL0%5FJqnR/s1600/%25E7%259C%259F%25E6%2598%25AF%25E5%25A4%25A0%25E5%2599%2581%25E5%25BF%2583%25E7%259A%2584.JPG)

是的，Windows7沒有3.0驅動  
而現在新的電腦有些沒有2.0插槽，像是[這台](http://blog.jim60105.com/2017/02/win7.html)

  
於是我們就要開工了...

  
## 步驟大綱

本系列分成三篇敘述，上篇老少皆宜，中下篇屬於困難級，請適當斟酌  
  
上篇-建立開機USB＆PE系統: <http://blog.jim60105.com/2017/07/usb.html>  
1. 安裝SuperUSB\_v6
2. 刪除SuperUSB\_v6多餘部分
3. 增加Win10 PE
中篇-引導重灌ISO: <http://blog.jim60105.com/2017/07/usb2.html>  
1. 製作並增加安裝OS選單: Windows XP
2. 製作並增加安裝OS選單: Windows 7
3. 製作並增加安裝OS選單: Windows 10
4. 製作並增加安裝OS選單: Ubuntu 16.04
下篇-加入Windows To Go系統: <http://blog.jim60105.com/2017/07/usb3.html>  
1. 製作Win10 VHD
2. 設置BCD引導
3. 安裝EWF影子系統
4. TroubleShooting

## 正文

### 製作並增加安裝OS選單: Windows XP

確認上篇建議下載的Windows XP iso檔案名稱為"zh-tw\_windows\_xp\_professional\_with\_service\_pack\_3\_x86\_cd\_vl\_x14-74140.iso"

  
然後請將此ISO檔複製到"USB://ISO/"目錄底下

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJRj89on2dyVfMIzaPFcufWQMbr6ps57USTdIgLGKT9Vm4F84_F6-OLZKWMzkzB_bHaumdIi1MR4IYvjTWH04hIWKrM1ILWbtHl5rKu2o6yN08MMGTPNaLk0hJyoCgX9-hrd_cpq-xoydq/s640/2017-07-11+22+16+50.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJRj89on2dyVfMIzaPFcufWQMbr6ps57USTdIgLGKT9Vm4F84%5FF6-OLZKWMzkzB%5FbHaumdIi1MR4IYvjTWH04hIWKrM1ILWbtHl5rKu2o6yN08MMGTPNaLk0hJyoCgX9-hrd%5Fcpq-xoydq/s1600/2017-07-11+22+16+50.png)

  
修改USB://List/menu.lst，拿掉os.lst的註解  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEspYuT-CGPCHa5d3hZ_39YSL2mVYcuA4eyYqqWyYK6Pl1Qlhxc2zK3rRF2IfPyX6ZtbNRC7hBlJiyOn654HgNw2tKEwW-pXA9qDgkUYKhuRhYZUkJk2unh_l357r8rigJrvhnMLKI4JAm/s640/2017-07-11+22+21+46.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEspYuT-CGPCHa5d3hZ%5F39YSL2mVYcuA4eyYqqWyYK6Pl1Qlhxc2zK3rRF2IfPyX6ZtbNRC7hBlJiyOn654HgNw2tKEwW-pXA9qDgkUYKhuRhYZUkJk2unh%5Fl357r8rigJrvhnMLKI4JAm/s1600/2017-07-11+22+21+46.png)
  
  
修改USB://List/os.lst，中間砍掉換成這段  

title [ 安裝OS ]
clear

title   [01] 安裝 Windows XP Pro SP3 x86(IDE)\n Install Windows XP Pro SP3 x86\n 必須是IDE模式，不能是AHCI模式
/UBRESCUE/NTBOOT/NTBOOT iso_inst=firadisk cdrom=/ISO/zh-tw_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-74140.iso addons="dpms 0"
boot

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg9wwnNVVmhj9jT4ZxC4fTgSnTMAT3bRcqZDPl6IhD59foJ4zV3eswblPFVl93iWS98ofhOdOVeaZf7GB0AHQc6cWXPhlma0dyJpkcj6SFIKG_WMZ1M2Xe2ntgeCPPiG6sk5v4rlQb61uJ7/s640/2017-07-11+22+20+14.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg9wwnNVVmhj9jT4ZxC4fTgSnTMAT3bRcqZDPl6IhD59foJ4zV3eswblPFVl93iWS98ofhOdOVeaZf7GB0AHQc6cWXPhlma0dyJpkcj6SFIKG%5FWMZ1M2Xe2ntgeCPPiG6sk5v4rlQb61uJ7/s1600/2017-07-11+22+20+14.png)

> ※注意※  
> SATA模式必須是IDE模式，不能是AHCI模式，XP無法支援AHCI

  
### 製作並增加安裝OS選單: Windows 7

開始製作win7跟win10以前，請先下載:  
1. imdisk: [MEGA](https://mega.nz/#!8wo2BDhR!nXgHjz-P4AQBBn-fj2G1waUdZf6KxE-hqZS134S39vw)
2. Win7 USB Patcher: [ASRock](http://www.asrock.com.tw/microsite/Win7Install/index.tw.html) (N3000系列 → 透過USB隨身碟及任何一種滑鼠鍵盤。 → Win7 USB Patcher)

將上篇建議下載的Windows7 11合一iso檔案重新命名為"Windows\_7\_11in1.iso"  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLWIP19UBntHjuQQQK0HrR_i82ne-sNpYIOXE8m-PNpw49AxrJFg38qD2MXO4L7E96MPFmTmdDDdGz7aD-TJT3OhhVgYblSrykVaD3bbuh4fiXgxvw8b4QEoHJiVGoyP4bUISP6N139R36/s640/2017-07-11+20+38+39.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLWIP19UBntHjuQQQK0HrR%5Fi82ne-sNpYIOXE8m-PNpw49AxrJFg38qD2MXO4L7E96MPFmTmdDDdGz7aD-TJT3OhhVgYblSrykVaD3bbuh4fiXgxvw8b4QEoHJiVGoyP4bUISP6N139R36/s1600/2017-07-11+20+38+39.png)

  
開啟UltraISO，打開Windows\_7\_11in1.iso映像檔  
左上方打開路徑\\sources，左下方選取到存放位置，右上方找到"boot.wim"以後對其右鍵提取  
提取成功後先不要關閉UltraISO，後面還要用  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUPmxSWqd4fRLoeiPbow8TMM1QtJZtv4XHirhDRm12-IjFPPGBB7xeLyaQs-lNmZ3EVuLx714nqQ-ZCfkLtqQb5HC3O_ZDdUIYyrqhnQJSIGQvoVjnkt6Obu1Vk35hPHLs1hL5PUIWSX_y/s640/2017-07-11+19+20+17.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUPmxSWqd4fRLoeiPbow8TMM1QtJZtv4XHirhDRm12-IjFPPGBB7xeLyaQs-lNmZ3EVuLx714nqQ-ZCfkLtqQb5HC3O%5FZDdUIYyrqhnQJSIGQvoVjnkt6Obu1Vk35hPHLs1hL5PUIWSX%5Fy/s1600/2017-07-11+19+20+17.png)

  
檔案總管開啟boot.wim存放位置，在同級下建立資料夾"mount"  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZceydxa2w2fN9yNpsDueu2zbe1uo5G1AT1EPRZBVZVJe4N5iy-1hh8pV1DDkfSshjS68PkG-J9CUiow8tIMEfkqerC1nVm24ArpHphlnCT6kn1qoPvqUpY8IMC_9DqNoVxhDUOkaT0Amm/s640/2017-07-11+19+22+40.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZceydxa2w2fN9yNpsDueu2zbe1uo5G1AT1EPRZBVZVJe4N5iy-1hh8pV1DDkfSshjS68PkG-J9CUiow8tIMEfkqerC1nVm24ArpHphlnCT6kn1qoPvqUpY8IMC%5F9DqNoVxhDUOkaT0Amm/s1600/2017-07-11+19+22+40.png)

  
開啟Gimagex，在"掛載映像"頁籤如圖選擇，然後進行掛載  
掛載完成後先不要關閉Gimagex，後面還要用  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCe7ibklC169pJEWYlqDHc1waZ7N-KkrNjHU5mU7zelnEFNg72xmb-cAaIskIZSLea18RpkW_Ar2mN5HBHhAw4rBx2c_UTIIP9pSosIoQwSfgPnNtm05A9Scio2YZY83HC9WIYmA8a51gm/s640/2017-07-11+19+23+38.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCe7ibklC169pJEWYlqDHc1waZ7N-KkrNjHU5mU7zelnEFNg72xmb-cAaIskIZSLea18RpkW%5FAr2mN5HBHhAw4rBx2c%5FUTIIP9pSosIoQwSfgPnNtm05A9Scio2YZY83HC9WIYmA8a51gm/s1600/2017-07-11+19+23+38.png)

  
開啟記事本，建立文件"win7.cmd"

pushd %SYSTEMDRIVE%\imdisk
@rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 .\imdisk.inf
@FOR %%I IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO @IF EXIST %%I:\ISO\Windows_7_11in1.iso imdisk -a -f %%I:\ISO\Windows_7_11in1.iso -m #:
exit

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEim-PFf1A7FCyCbhA3NxN64MLeVbjLluh82t6CU-0fnJsHEJX9ZmlIZ7mZ8DChYj-lCw-lKkhpfw2FgqT9etED_9Va-joDzJZ5z-v6PNHJ40peQTaI5jD7wCN-c2QngyRHpzhofliEvXHSV/s640/2017-07-11+20+01+19.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEim-PFf1A7FCyCbhA3NxN64MLeVbjLluh82t6CU-0fnJsHEJX9ZmlIZ7mZ8DChYj-lCw-lKkhpfw2FgqT9etED%5F9Va-joDzJZ5z-v6PNHJ40peQTaI5jD7wCN-c2QngyRHpzhofliEvXHSV/s1600/2017-07-11+20+01+19.png)

  
開啟記事本，建立文件"Winpeshl.ini"

[LaunchApp]
AppPath = %SYSTEMDRIVE%\sources\win7.cmd

[LaunchApps]

%SYSTEMDRIVE%\sources\setup.exe

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjI1BFGC2t0xTZhKo061KyH0IuA4bqK47Xaml6aTln5apk554yBSsr1GMDHhE2Cg7VlCNqrL8_FhyphenhyphenOiaKiKCtdT0lMr9Q-rNVbjBk0gZM_OaA5VKs4VC8Wa8qU3lxTjjnq9fRlkspSeAIXR/s640/2017-07-11+20+03+13.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjI1BFGC2t0xTZhKo061KyH0IuA4bqK47Xaml6aTln5apk554yBSsr1GMDHhE2Cg7VlCNqrL8%5FFhyphenhyphenOiaKiKCtdT0lMr9Q-rNVbjBk0gZM%5FOaA5VKs4VC8Wa8qU3lxTjjnq9fRlkspSeAIXR/s1600/2017-07-11+20+03+13.png)

  
將win7.cmd複製到路徑"\\mount\\sources"之下  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjX7pJa-xYShWw8SbFDmn81e01UqGGdz-p3bierc6Guf9t4pHtL3m0pTG5Xgh4ECZP1LrQ8oIFYB3ViHa1dc6pHYPHNIwnCVVEDkfSgRTBMiR8YqRk-1duoM-7XQTMAJxs9qt8lA1D4472a/s640/2017-07-11+20+04+28.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjX7pJa-xYShWw8SbFDmn81e01UqGGdz-p3bierc6Guf9t4pHtL3m0pTG5Xgh4ECZP1LrQ8oIFYB3ViHa1dc6pHYPHNIwnCVVEDkfSgRTBMiR8YqRk-1duoM-7XQTMAJxs9qt8lA1D4472a/s1600/2017-07-11+20+04+28.png)

  
將Winpeshl.ini複製到路徑"\\mount\\Windows\\System32"之下  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEij3skfvDtsOYwF7z2KpaI_7kjh3fQwi_usIyyVDyAYfq-hb3kHp1tVQ0jXMfywf2Qm5fNXJL86qbt0zuVA0-0x037Or1KLw6nwxiDx25IYpYNUGHZRSd-P6EvXRMqozsww2AGo2kVdQyn5/s640/2017-07-11+20+06+34.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEij3skfvDtsOYwF7z2KpaI%5F7kjh3fQwi%5FusIyyVDyAYfq-hb3kHp1tVQ0jXMfywf2Qm5fNXJL86qbt0zuVA0-0x037Or1KLw6nwxiDx25IYpYNUGHZRSd-P6EvXRMqozsww2AGo2kVdQyn5/s1600/2017-07-11+20+06+34.png)

  
將imdisk複製到路徑"\\mount"之下  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-V5sfqcWc5oAEV7ERoXBMDvsPh2Nrc4FRoUTq_B6iGqhgTRaizmVIELtGc4n6Q52LN6MssU3yAMh4JXI3pb2DtQR4HLySaBXTMhNntdQ1IFZrtVZLztpzK55NbRIq-reXvqianot3qndf/s640/2017-07-11+20+09+10.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-V5sfqcWc5oAEV7ERoXBMDvsPh2Nrc4FRoUTq%5FB6iGqhgTRaizmVIELtGc4n6Q52LN6MssU3yAMh4JXI3pb2DtQR4HLySaBXTMhNntdQ1IFZrtVZLztpzK55NbRIq-reXvqianot3qndf/s1600/2017-07-11+20+09+10.png)

  
回到Gimagex，如圖卸載boot.wim  

> ※注意※  
>  
> 卸載前務必把\\mount下開啟的所有文件/資料夾關閉，恢復到非使用中狀態  
> 要是掛載/卸載失敗就以系統管理員執行cmd: Dism /Cleanup-Wim

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgAYWns3slwXvWoPuM9cE2YdI881IeGMh3TfFpyvphwLdU0zBgfNMLJ7yocQdEzT__n01MEe5r9-iVTmitTd7ijw-V4dmnZNKGqHaNWWoo0XkT5G2V9xl8ijHoD6s7LoweohJcgD6dIeCPx/s640/2017-07-11+20+10+44.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgAYWns3slwXvWoPuM9cE2YdI881IeGMh3TfFpyvphwLdU0zBgfNMLJ7yocQdEzT%5F%5Fn01MEe5r9-iVTmitTd7ijw-V4dmnZNKGqHaNWWoo0XkT5G2V9xl8ijHoD6s7LoweohJcgD6dIeCPx/s1600/2017-07-11+20+10+44.png)

  
回到UltraISO，對右下部分"右鍵→重新整理"，直到新的boot.wim正確顯示  
然後對其右鍵→加入→覆蓋進去  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdVvR1VfIVpuNkJ9eVmW2CzNnZGfffpIXPRW4zgAgkwhtljCbnXlHq5KC67oVw31rMHdJ3oeWhwow3cnb0rM6Rkz_09AVhHNkSvF2ScyD5aaO6633M2M5YSKl-0mTROzPwGN9ZqVlpRNED/s640/2017-07-11+20+25+01.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdVvR1VfIVpuNkJ9eVmW2CzNnZGfffpIXPRW4zgAgkwhtljCbnXlHq5KC67oVw31rMHdJ3oeWhwow3cnb0rM6Rkz%5F09AVhHNkSvF2ScyD5aaO6633M2M5YSKl-0mTROzPwGN9ZqVlpRNED/s1600/2017-07-11+20+25+01.png)

  
確認是否加入成功，然後存檔離開UltraISO  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguBgFt_tNN3LGzSdt2UY4nOQX9FdpaR3pLbHXBYqvBaPoFh62e1x-yHrWmGcYNrMGRqeVQ3xt8Dbybnz6bPEj9OUETmjYj1HsUVJoDnf89rycNIMrS4endCGvJcEMv3aX8AdeZKy0ogaOO/s640/2017-07-11+20+26+18.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguBgFt%5FtNN3LGzSdt2UY4nOQX9FdpaR3pLbHXBYqvBaPoFh62e1x-yHrWmGcYNrMGRqeVQ3xt8Dbybnz6bPEj9OUETmjYj1HsUVJoDnf89rycNIMrS4endCGvJcEMv3aX8AdeZKy0ogaOO/s1600/2017-07-11+20+26+18.png)

  
開啟Win7 USB Patcher，對剛剛存檔完成的Windows\_7\_11in1.iso檔案使用  
第一次選ISO  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgWgXPEKAJZDMc5QaCG864tGOHnWDKO_d7iFZAZo58kVKJEC-iKMLlbdQ-94WlvWLy0S8uhchqkIAeQihUR6U9sAiS76wW8uunxY1HkK3ZFqwg9NCRPdVYsq4ZakHOtYtbQsUebi_wTEZOt/s1600/2017-07-11+20+36+26.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgWgXPEKAJZDMc5QaCG864tGOHnWDKO%5Fd7iFZAZo58kVKJEC-iKMLlbdQ-94WlvWLy0S8uhchqkIAeQihUR6U9sAiS76wW8uunxY1HkK3ZFqwg9NCRPdVYsq4ZakHOtYtbQsUebi%5FwTEZOt/s1600/2017-07-11+20+36+26.png)

  
選ISO，並選擇剛剛完成的Windows\_7\_11in1.iso  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgURYRXWrtPlXg9KauTEOQ-VaHE-RhaMDk8KAFCFr0WoQbnq85y2QGZHki-rgIP5VAiG0q9D8A4qXgf4Uh44BpEBBJjE8REbaP2Kn538bU8-jsEPVQCoErI6oD0-IbXInkdhNdRfG8waVou/s1600/2017-07-11+20+37+05.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgURYRXWrtPlXg9KauTEOQ-VaHE-RhaMDk8KAFCFr0WoQbnq85y2QGZHki-rgIP5VAiG0q9D8A4qXgf4Uh44BpEBBJjE8REbaP2Kn538bU8-jsEPVQCoErI6oD0-IbXInkdhNdRfG8waVou/s1600/2017-07-11+20+37+05.png)

  
到下圖這步驟，Start按下去就開始跑了，途中可能會無回應，請耐心等待\~  

這裡要等非常非常久

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjP0pv1xmPsSnepCWWpC-Cf34bXrSOA7nkGu3ZUdfDEoEd6fBLQwqeoIk8Kts-ZspuclayQB5Ur3_yZkmyfF-X2cjc_fN3G8sklRV3Tv8E-I7rM-FB1F-n5YSPJ3DxonOqzGkNZnn2GSj_J/s1600/2017-07-11+20+37+43.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjP0pv1xmPsSnepCWWpC-Cf34bXrSOA7nkGu3ZUdfDEoEd6fBLQwqeoIk8Kts-ZspuclayQB5Ur3%5FyZkmyfF-X2cjc%5FfN3G8sklRV3Tv8E-I7rM-FB1F-n5YSPJ3DxonOqzGkNZnn2GSj%5FJ/s1600/2017-07-11+20+37+43.png)

  
下圖表示完成

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiulJGMkSD_UX-VudLQxkUQpfOlAjtHyPXqBPoiGEAMQxEzqKXoCRMUiO9TakrqJ3nqRK0LsCKYePN88Griahd4i4Fy_nU3YWRY5ErApISX32Cgfi7tlPYBxd3mEVht1Uyg99JMvnAp8r0_/s1600/2017-07-11+21+50+36.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiulJGMkSD%5FUX-VudLQxkUQpfOlAjtHyPXqBPoiGEAMQxEzqKXoCRMUiO9TakrqJ3nqRK0LsCKYePN88Griahd4i4Fy%5FnU3YWRY5ErApISX32Cgfi7tlPYBxd3mEVht1Uyg99JMvnAp8r0%5F/s1600/2017-07-11+21+50+36.png)

  
完成以後到桌面找到PatchedImg.iso，重新命名為"Windows\_7\_11in1.iso"，並複製到"USB://ISO"資料夾底下  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEidC4OS76GlaeMN6ihTeFtKovhyp-j68uAHR3LQrtvPrvBCRCnJT3S0vDW8VaVnowXWaUH2mgh7pmSN-JcJf_bUbiz7TJUBTHJGMTkgw4SBIMDWbyRQN8o-SigjfbR5Uq_hdvpaij0Ka_gv/s640/2017-07-11+21+52+39.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEidC4OS76GlaeMN6ihTeFtKovhyp-j68uAHR3LQrtvPrvBCRCnJT3S0vDW8VaVnowXWaUH2mgh7pmSN-JcJf%5FbUbiz7TJUBTHJGMTkgw4SBIMDWbyRQN8o-SigjfbR5Uq%5Fhdvpaij0Ka%5Fgv/s1600/2017-07-11+21+52+39.png)

  
修改USB://List/os.lst，中間加上這段  

title   [02] 安裝 Windows 7\n Install Windows 7\n
find --set-root /ISO/Windows_7_11in1.iso
map /ISO/Windows_7_11in1.iso (hd32)
map --hook
chainloader (hd32)
boot

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQJAWiSkWww9RhWdGbqCw0A845qc8jbtBuQ5idcfqQaItqXOZF1fbCakwKOUIxBSullrXoJgbdSx4hLS0pSjIT9DjY7XKYZoivT-u62uFDvVECJR79ZwNMrqKfLeWjPsqnrGkP6qC-2OkZ/s640/2017-07-11+22+13+32.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQJAWiSkWww9RhWdGbqCw0A845qc8jbtBuQ5idcfqQaItqXOZF1fbCakwKOUIxBSullrXoJgbdSx4hLS0pSjIT9DjY7XKYZoivT-u62uFDvVECJR79ZwNMrqKfLeWjPsqnrGkP6qC-2OkZ/s1600/2017-07-11+22+13+32.png)

  
> ※注意※  
> 插在USB3.0插槽啟動時Win7還是會遇到引導失敗，建議盡量插在2.0插槽使用  
> 不然就另外單獨拿一支USB2.0燒著備用，用rufus直接做比較保險

  
### 製作並增加安裝OS選單: Windows 10

Windows10作法跟Windows7類似，一樣要使用imdisk掛載

不過他並不需要上U3Patch，Win10原生支援USB3.0

需要注意的是Win10的win10.cmd和Winpeshl.ini與Win7的內容不同，注意不要混用

  
再來就是，我下載到的Windows10是x64+x86混和光碟，所以boot.wim有兩個，要提取作業兩次(兩個boot.wim內容不同，都要個別上imdisk)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFRT1OsyxtLPFHl1RJFnoB5okQoJdruN4ZjHS98bfurs4DeRcJ6cOhGCVOJJj8lbQgNQsIcNOtPEYyJLeJQxNBPqiyhf3CZaEXV8PrJpfSsHHqF7-4FB955B3enKeiVGVg2rtWRSBdFe8w/s640/2017-07-11+22+48+50.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFRT1OsyxtLPFHl1RJFnoB5okQoJdruN4ZjHS98bfurs4DeRcJ6cOhGCVOJJj8lbQgNQsIcNOtPEYyJLeJQxNBPqiyhf3CZaEXV8PrJpfSsHHqF7-4FB955B3enKeiVGVg2rtWRSBdFe8w/s1600/2017-07-11+22+48+50.png)

  
兩個檔案給在這裡，步驟同上不再重複(記得不要遺忘imdisk)  

win10.cmd

pushd %SYSTEMDRIVE%\imdisk
@rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 .\imdisk.inf
@FOR %%I IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO @IF EXIST %%I:\ISO\zh-tw_Windows_10_Pro_x64_1607.iso imdisk -a -f %%I:\ISO\zh-tw_Windows_10_Pro_x64_1607.iso -m #:
exit

  
Winpeshl.ini

[LaunchApp]
AppPath = %SYSTEMDRIVE%\sources\win10.cmd

[LaunchApps]

%SYSTEMDRIVE%\setup.exe

  
簡單附上兩張示意圖  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi0Ma8J3D3Zm8xoabwclgp4Gmwen_DUTsBU3BhFJgA52_q5Zg1nX6yNpu-QtNL_ZKvKGk79jS4uz78WHYaIpu3a1o_uN7VsLtnIDjYI_LZXdeEzzzUQsECC_Omzv1wkUl7cGAodEEZO7Ea2/s640/2017-07-11+22+56+11.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi0Ma8J3D3Zm8xoabwclgp4Gmwen%5FDUTsBU3BhFJgA52%5Fq5Zg1nX6yNpu-QtNL%5FZKvKGk79jS4uz78WHYaIpu3a1o%5FuN7VsLtnIDjYI%5FLZXdeEzzzUQsECC%5FOmzv1wkUl7cGAodEEZO7Ea2/s1600/2017-07-11+22+56+11.png)

  
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiDYgny-xbD3GFECf4ScljTO_2mr3JPCnpfkHKsIYPmJo2Y9PQmD75-f_ot9zoJyRJyyZ0MpGTbR4Aqj0LHx1P8sA1xWqztuw_zyQNM651wiS6eEPRcJK1J0sCgVoWEATWSa9l56fi2WA_g/s640/2017-07-11+22+58+39.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiDYgny-xbD3GFECf4ScljTO%5F2mr3JPCnpfkHKsIYPmJo2Y9PQmD75-f%5Fot9zoJyRJyyZ0MpGTbR4Aqj0LHx1P8sA1xWqztuw%5FzyQNM651wiS6eEPRcJK1J0sCgVoWEATWSa9l56fi2WA%5Fg/s1600/2017-07-11+22+58+39.png)

  
確認完成的Windows 10 iso檔案名稱為"zh-tw\_Windows\_10\_Pro\_x64\_1607.iso"

  
然後請將此ISO檔複製到"USB://ISO/"目錄底下  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKa0RWMYGtIMNNA21l4W27U18nkvJC9yjzw6Us9ntUkfaTLG_CewuECsE4dNzVJs6RfLXiX5hBtIAJl6lM1ED1vuwaFoCUjJrOZe0CMJdP04qbQL4mVQFtaOLfEgBtcFYzgzjD6AbRzvQr/s640/2017-07-11+23+09+57.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKa0RWMYGtIMNNA21l4W27U18nkvJC9yjzw6Us9ntUkfaTLG%5FCewuECsE4dNzVJs6RfLXiX5hBtIAJl6lM1ED1vuwaFoCUjJrOZe0CMJdP04qbQL4mVQFtaOLfEgBtcFYzgzjD6AbRzvQr/s1600/2017-07-11+23+09+57.png)

  
修改USB://List/os.lst，中間加上這段  

title   [03] 安裝 Windows 10 1607\n Install Windows 10 1607
find --set-root /ISO/zh-tw_Windows_10_Pro_x64_1607.iso
map /ISO/zh-tw_Windows_10_Pro_x64_1607.iso (hd32)
map --hook
chainloader (hd32)
boot

  
### 製作並增加安裝OS選單: Ubuntu 16.04

相較之下Ubuntu處理非常簡單

先建立一個資料夾，名稱為"ubuntu-16.04.2-desktop-amd64"

然後把ubuntu-16.04.2-desktop-amd64.iso丟進資料夾裡面

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglycc7enLP4s-_2egMcNjr1XhfOaaH_6Iztrg7x34hG8DzUM019fxWAKs3aYMCDMepA63xCpWBitC7vKXKo-2cIMscf_Yki2HlG7t6YyALvwRr_n3uqDCa3rFMhYl6YvK24CIJPteE73C7/s640/2017-07-11+23+29+00.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglycc7enLP4s-%5F2egMcNjr1XhfOaaH%5F6Iztrg7x34hG8DzUM019fxWAKs3aYMCDMepA63xCpWBitC7vKXKo-2cIMscf%5FYki2HlG7t6YyALvwRr%5Fn3uqDCa3rFMhYl6YvK24CIJPteE73C7/s1600/2017-07-11+23+29+00.png)

  
以WinRAR或其他壓縮軟體開啟ubuntu-16.04.2-desktop-amd64.iso  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFbyrIvxHb4FwzIOPC6OYJniB8h27jgwHlxwWaVd6Jp32cKRbM6tDRl7gbrjFJD3eim28j6NmiFl-pYvCwzYPlWHvX-Q2oVdWfEqCbHaoUeIKM_tLfzHgogDNDYqqA7hfZdqHKwMm1umRf/s640/2017-07-11+23+29+41.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFbyrIvxHb4FwzIOPC6OYJniB8h27jgwHlxwWaVd6Jp32cKRbM6tDRl7gbrjFJD3eim28j6NmiFl-pYvCwzYPlWHvX-Q2oVdWfEqCbHaoUeIKM%5FtLfzHgogDNDYqqA7hfZdqHKwMm1umRf/s1600/2017-07-11+23+29+41.png)

  
開啟路徑"\\casper"，將 initrd.lz 和 vmlinuz.efi 兩個檔案解壓縮到ubuntu-16.04.2-desktop-amd64資料夾內  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsDagw0fxOhlGxFK21IvXwsbWRi1aUhaVoBe1JCiHaoSacNdmw8G_zACHZQUoKmkLPLUCXV-OCMYSJUolY0E_Zi-mI1G45XO_9jICe6P703VtJjy54tkj-uFEgHeiY_vvwoDqKek3BPFCE/s640/2017-07-11+23+30+47.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsDagw0fxOhlGxFK21IvXwsbWRi1aUhaVoBe1JCiHaoSacNdmw8G%5FzACHZQUoKmkLPLUCXV-OCMYSJUolY0E%5FZi-mI1G45XO%5F9jICe6P703VtJjy54tkj-uFEgHeiY%5FvvwoDqKek3BPFCE/s1600/2017-07-11+23+30+47.png)

  
資料夾下狀態如圖  

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCi6lZmr_Ox5u7j0MMc9z7Kx3jUILms81jhEpMhvA62RCdkIpDYlVdtXSufMKnxt_EYxkHvhxNhFE0Dg61Oz40Uc9hWvloZv-YtvN7SYYPSte2p2qBPJEecMdCVmmJCyiMe72DMkGUBFEj/s640/2017-07-11+23+32+20.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCi6lZmr%5FOx5u7j0MMc9z7Kx3jUILms81jhEpMhvA62RCdkIpDYlVdtXSufMKnxt%5FEYxkHvhxNhFE0Dg61Oz40Uc9hWvloZv-YtvN7SYYPSte2p2qBPJEecMdCVmmJCyiMe72DMkGUBFEj/s1600/2017-07-11+23+32+20.png)

  
將ubuntu-16.04.2-desktop-amd64資料夾整個丟到USB://ISO/底下

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOWBZuxOXBee_zwEzmlqDaNE4rZmc4wnUINFAKHtHp9YvQaoN3pWGgvd9Cf8d06sEbVgTXbYJADIdVV1MMlUk8L4trs8Ks5Cg5lk_Qwdi9lk2oRoSsldvl_X_1xCCYkdts5zbAf5LcwT8N/s640/2017-07-11+23+32+48.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOWBZuxOXBee%5FzwEzmlqDaNE4rZmc4wnUINFAKHtHp9YvQaoN3pWGgvd9Cf8d06sEbVgTXbYJADIdVV1MMlUk8L4trs8Ks5Cg5lk%5FQwdi9lk2oRoSsldvl%5FX%5F1xCCYkdts5zbAf5LcwT8N/s1600/2017-07-11+23+32+48.png)

  
修改USB://List/os.lst，中間加上這段  

title   [04] 安裝 Ubuntu 16.04 LTS x64\n Install Ubuntu 16.04 LTS x64
root (hd0,0)
kernel (hd0,0)/ISO/ubuntu-16.04.2-desktop-amd64/vmlinuz.efi boot=casper iso-scan/filename=/ISO/ubuntu-16.04.2-desktop-amd64/ubuntu-16.04.2-desktop-amd64.iso
initrd (hd0,0)/ISO/ubuntu-16.04.2-desktop-amd64/initrd.lz

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCKSPQi2tHcUQ9aMvfHvVh_uV9YbRuwMOLdIkaGpB1MbwzTw3kumPcDo1tXAD9jg5Q_g-3wCc-ifANUejwJ2pZ8k5VWar8DY1Yjwc02pkDe-5ZJiAfAV-yLCEWPY2msdXNuOXHlgbG4TcX/s640/2017-07-11+23+41+33.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCKSPQi2tHcUQ9aMvfHvVh%5FuV9YbRuwMOLdIkaGpB1MbwzTw3kumPcDo1tXAD9jg5Q%5Fg-3wCc-ifANUejwJ2pZ8k5VWar8DY1Yjwc02pkDe-5ZJiAfAV-yLCEWPY2msdXNuOXHlgbG4TcX/s1600/2017-07-11+23+41+33.png)

  
修改USB://List/menu.lst，中間加上這段  

title   - Ubuntu 16.04 LTS x64\n Install Ubuntu 16.04 LTS x64
root (hd0,0)
kernel (hd0,0)/ISO/ubuntu-16.04.2-desktop-amd64/vmlinuz.efi boot=casper iso-scan/filename=/ISO/ubuntu-16.04.2-desktop-amd64/ubuntu-16.04.2-desktop-amd64.iso
initrd (hd0,0)/ISO/ubuntu-16.04.2-desktop-amd64/initrd.lz

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgr98t8CdIYrKZpIlv8TWjbOHfoMdbxXIsBfFWDa5u8VdapIhlEE1uwU-mLJ_GSMwFDOjoBpP7flUgMT8uMEVOUkhVO-ugBoVdboqcd313GFZBeCq4GHhmO12HjRSYs-_cQsJtm1P9pedTk/s640/2017-07-11+23+43+09.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgr98t8CdIYrKZpIlv8TWjbOHfoMdbxXIsBfFWDa5u8VdapIhlEE1uwU-mLJ%5FGSMwFDOjoBpP7flUgMT8uMEVOUkhVO-ugBoVdboqcd313GFZBeCq4GHhmO12HjRSYs-%5FcQsJtm1P9pedTk/s1600/2017-07-11+23+43+09.png)
  
  
## 參考資料

* SuperUSB v6 – 電腦維護的利器 | 格雷資訊，格雷，2013-09-04， <https://www.grayfree.tw/archives/716>
* 隨身碟 G4D 單一ISO安裝WIN7、8..(PART2) #12，2567288，2013-02-27， <http://nonameteam.cc/forum.php?mod=redirect&goto=findpost&ptid=1143&pid=8923&fromuid=29234>
* 琳的備忘手札: 灌Win7時滑鼠鍵盤無法使用，陳鈞，2017-02-04， <http://blog.jim60105.com/2017/02/win7.html>