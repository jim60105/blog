+++
title = "[Docker] Youtube直播錄影伺服器建置"
description = ""
date = 2020-11-23T21:37:00.083Z
updated = 2023-03-07T01:58:58.902Z
draft = false
aliases = ["/2020/11/docker-youtube-dl-auto-recording-live-dl.html"]

[taxonomies]
tags = ["Container", "YouTube"]
+++
##  前言

[![](https://img.maki0419.com/blog/youtube-dl-auto-recording/preview.png)](https://img.maki0419.com/blog/youtube-dl-auto-recording/preview.png) 

  
 本文希望建置起能永久自動運作的Youtube直播備份機  
 本專案包含三個部份: 

* youtube-dl-server: 這是一個網頁UI界面，可以手動執行下載
* live-dl: 直播中錄播，用來對應版權砲、下播即砍，等等的狀況
* backup-dl: 定期封存所有影片，下載Youtube算完影片後較高品質的檔案

此專案目標為**「自動化影片備份」**，盡量保存最好的影片，若砍檔我還有一份錄播的  
記錄下我推的每分每秒  

## 概觀

### 本專案核心目標

* 以docker-compose技術，將建置server的難度維持在...還可以?
* 監控指定的頻道，直播時自動錄製功能
* 磁碟滿時自動刪除錄播檔
* 能手動下載指定影片
* 定期備份Youtube已算完的影片，並上傳封存

### 本文適合對象

* 初級以上的linux操作基礎
* 有自己的主機或NAS，沒有可以[現在租](/2020/11/linux-docker-setup-revese-proxy.html#DigitalOcean) (不然你東西想放哪裡?)

###  功能說明

* 手動下載會儲存在主機的 `../YoutubeRecordings/` 之下，可以在 docker-compose.yml修改
* 可以在錄影完成後執行callback bash script
* Jobber會在每日的01:00 UTC檢查磁碟使用率，並由舊檔案刪起，直到磁碟使用率降到設定值(或直到沒有檔案)
* Jobber會每日喚醒backup-dl執行備份封存

## 流程簡述

1. [Linux主機之Docker安裝和ReveseProxy建置](/2020/11/linux-docker-setup-revese-proxy.html)
2. git clone下來docker-compose建置檔案和config檔案
3. 設定要自動錄影的直播頻道
4. docker-compose up -d

## 架構

WWW  
│  
nginx Server (Reverse Proxy) (SSL證書申請、Renew)  
├ Jobber (Cron) (定時檢查磁碟使用率，在高於設定之百分比時，自動由舊起刪除錄影)  
├┴ backup-dl (影片備份上傳機)  
├ live-dl (直播監控錄影機)  
└ youtube-dl-server (WebUI下載器)  

## 建置

### Linux主機和Docker安裝  

請完成此文的建置章節  

> 琳的備忘手札 \[Docker\] Linux主機之Docker安裝和ReveseProxy建置  
> </2020/11/linux-docker-setup-revese-proxy.html> 

另外，本專案完全可以部屬在Windows10機器上，以圖為證  
請自行轉換所有步驟在Windows執行

[![](https://img.maki0419.com/blog/youtube-dl-auto-recording/youtube-dl-win.png)](https://img.maki0419.com/blog/youtube-dl-auto-recording/youtube-dl-win.png) 

###  live-dl、youtube-dl-server建置

* cd到欲儲存影片的位置，例如我想放在`/YoutubeDL`  
mkdir /YoutubeDL && cd /YoutubeDL
* git clone專案  
git clone https://github.com/jim60105/docker-youtube-dl.git  
> **本專案有submodule**  
> 如果想要build docker image，請用`git pull --recurse-submodules`
* 進入docker-youtube-dl資料夾  
cd docker-youtube-dl
* 填入.env檔案  
cp .env_sample .env && vim .env  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/10.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/10.png)  
   * `LETSENCRYPT_TEST`: 此為設定申請測試SSL證書，現在給true，**最後上線前才改false**  
   * `LETSENCRYPT_EMAIL`: Let's Encrypt在證書到期時通知你用的email，不會透過這個做驗證。建議正確填入。  
   * `HOST`: WebUI網址  
   * `DelPercentage`: 超過時要執行刪除功能的磁碟使用百分比  
   (此處請按照你的磁碟大小估算。例如，我的磁碟大小是25G，我希望留下的空間至少為3G，3G / 25G =12%，設定為88)
* 編輯`config_live-dl.yml` 在map下建立名稱對應表，此表用於自動錄播時的資料夾建立  
vim config_live-dl.yml
* 參考`Monitor/tama.sh` 建立要做自動錄影的頻道，所有Monitor資料夾下的檔案都會被執行  
 (資料夾內可以建立多個.sh檔)  
 請自行為不同頻道替換Youtube URL和Channel Name的內容  
 目前內建的直播錄影設定的是[久遠たま](https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw)的頻道  
cp Monitor/tama.sh Monitor/{{Channel Name}}.sh  
vim Monitor/{{Channel Name}}.sh  
 內容  
`nohup /bin/bash live-dl {{Youtube URL}} &>/youtube-dl/logs/live-dl-{{Channel Name}}.$(date +%d%b%y-%H%M%S).log &`
* 給所有`*.sh`執行權限  
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
* 起機囉\~\~  
docker-compose up -d
* 檢查Container是否都有起來  
docker ps -a  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/11.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/11.png)
* 檢查SSL是否成功  
docker logs proxy_le -f  
 注意紅框處，這樣就是成功  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/12.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/12.png)
* 將SSL申請改為正式申請  
> 注意  
> 因為Let's Encrypt針對網域正式申請有次數限制  
> 不論成功與否，做太多次就會鎖住  
> 發布前一定要測試成功再轉正  
>  
> 或者，若你不需要SSL就把`proxy_le`container停掉  
vim .env  
 第一行`LETSENCRYPT_TEST`改為`false`  
 重做compose  
docker-compose down && docker compose up -d  
 檢查是否有成功要到正式證書  
注意紅框處，已沒有\_test\_字樣  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/13.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/13.png)
* 檢查自動錄影是否正常  
查看在`../YoutubeRecordings/logs`下是否有log輸出，並查看檔案內容  
ls ../YoutubeRecordings/logs
* 檢查WebUI是否正常  
開啟你在[此處](#host)設定的網址，看看是否能正常訪問網址

### backup-dl建置  

> Backup的封存位置是Azure Blob Storage，不是每個人都適用  
> 相關設定全都是註解狀態，你要用再打開

* 在Azure開一個Blob Storage，直到[取得ConnectionString](https://docs.microsoft.com/zh-tw/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys)  
這有點複雜，且本文的重點不在這裡，請[參照官方文件](https://docs.microsoft.com/zh-tw/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal)
* 編輯docker-compose.yml，把backup-dl，和jobber下半部份取消註解

vim docker-compose.yml

[![](https://img.maki0419.com/blog/youtube-dl-auto-recording/backupdl1.png)](https://img.maki0419.com/blog/youtube-dl-auto-recording/backupdl1.png) 

* 編輯.env檔案，填入要下載的頻道和連接字串  
vim .env  
[![](https://img.maki0419.com/blog/youtube-dl-auto-recording/backupdl2.png)](https://img.maki0419.com/blog/youtube-dl-auto-recording/backupdl2.png)  
   * `CHANNELS_IN_ARRAY`: Azure Blob Storage的連接字串  
   * `AZURE_STORAGE_CONNECTION_STRING_VTUBER`: 欲下載的頻道網址，以陣列傳入  
   * `HOST`: WebUI網址  
   * `MAX_DOWNLOAD`: (可選)每次執行的最大下載數量，預設為10  
   * `FORMAT`: (可選)自訂欲下載的格式，預設為bestvideo+bestaudio/best，請參考[yt-dlp說明文件](https://github.com/yt-dlp/yt-dlp#format-selection)
* 重新做docker-compose  
docker-compose down && docker compose up -d
* 檢查log看是否成功啟動，有沒有進入下載  
docker-compose logs -f

##  附註: 下載會員限定影片

 此專案支援以youtube-dl的cookies file方式登入，**可以**下載會限影片  
(youtube-dl的帳密登入從2019 bug到現在都沒有修好)  

[![](https://img.maki0419.com/blog/youtube-dl-auto-recording/youtube-dl-member.png)](https://img.maki0419.com/blog/youtube-dl-auto-recording/youtube-dl-member.png) 

* 安裝瀏覧器擴充功能，以匯出Netscape HTTP Cookie File  
   * Chrome: [Get cookies.txt LOCALLY](https://chrome.google.com/webstore/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc)  
   * Firefox:[cookies.txt](https://addons.mozilla.org/zh-TW/firefox/addon/cookies-txt/)
* 瀏覧至Youtube網頁，登入你的帳號
* 以擴充功能匯出`youtube.com`網域的所有cookie
* 將匯出之cookie檔案重命名為`cookies.txt`
* 取代專案目錄下的cookies.txt檔或用於[後述](#%E9%99%84%E8%A8%BB-%E4%B8%8D%E9%83%A8%E5%B1%AC%E4%B9%8B%E5%96%AE%E6%AC%A1%E5%9F%B7%E8%A1%8Clive-dl)的volume bind

> 注意  
> 此cookies file包含了你的Youtube登入授權  
> 任何人只要取得這個檔案，即可由你的身份登入Youtube  
> 請**務必妥善保管，把它當成你的帳號密碼看待** 

## 附註: 不部屬之單次執行live-dl

 若要單次執行而不部屬，可直接docker run  
我有build了image在此:<https://github.com/users/jim60105/packages/container/package/live-dl> 

例如

docker run --rm
        -v D:\YoutubeDownload:/youtube-dl
        -v D:\YoutubeDownload\cookies.txt:/usr/src/app/cookies.txt
        ghcr.io/jim60105/live-dl https://www.youtube.com/watch?v=GDOQTShjTQs

此格式如下  
 將{{}}填入你的內容，若不需要登入就不用傳入cookies file  
cookies file之相關說明請見[上一節](#%E9%99%84%E8%A8%BB-%E4%B8%8B%E8%BC%89%E6%9C%83%E5%93%A1%E9%99%90%E5%AE%9A%E5%BD%B1%E7%89%87) 

docker run --rm
        -v {{影片儲存資料夾}}:/youtube-dl
        -v {{cookies file，用於登入驗證}}:/usr/src/app/cookies.txt
        ghcr.io/jim60105/live-dl {{Youtube網址}}

## 附註: 錄影完成Callback

> 本專案提供的[download\_again.sh](https://github.com/jim60105/docker-live-dl/blob/master/download%5Fagain.sh) ，能在下載完成後等待一分鐘，再下載第二次  
> 由於串流中錄影容易有漏秒，所以我會在「直播結束後至Youtube版權砲前」再下載一次

### callback.sh傳入之參數

  __info "Calling callback function..."
  local cmd=( "$CALLBACK_EXEC" "${OUTPUT_PATH}.mp4" "$BASE_DIR/" "$VIDEO_ID" "$FULLTITLE" "$UPLOADER" "$UPLOAD_DATE" )
  nohup "${cmd[@]}" &>> "$OUTPUT_PATH.log" &

bash參數

1. 產出檔案的完整路徑
2. 產出檔案之所在資料夾
3. 影片id
4. 影片標題
5. 影片上傳者
6. 上傳日期

## 附註: Logging相關設定

本專案logging經過調整，可搭配[Seq Log Server](https://datalust.co/seq)使用 (或是任何支援GELF http post的log server)

* 參考這個repo部屬Seq: <https://github.com/jim60105/docker-Seq>
* .env正確設置LOGSERVER路徑，格式為`IP:埠號`
* Monitor/\*.sh註解掉File logging，改用「STDOUT logging (with log tag)」方式呼叫
* download\_again.sh註解掉File logging，改用「Docker logs logging (with log tag)」方式呼叫
* 啟動指令改用 `docker-compose -f docker-compose.yml -f docker-compose.log-server.yml up -d`  
或是將`docker-compose.log-server.yml`重命名為`docker-compose.override.yml`，使 `docker-compose up -d` 可以自動應用override檔

iscn://likecoin-chain/OkHAhjNWyZppmCu3ffbFJpRV2x33dNoiqkBNFyIzmec