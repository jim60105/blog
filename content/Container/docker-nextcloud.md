+++
title = "[Docker] Nextcloud自有雲建置"
description = ""
date = 2020-07-03T21:38:00.163Z
updated = 2022-12-15T20:43:34.882Z
draft = false
aliases = ["/2020/07/docker-nextcloud.html"]

[taxonomies]
tags = ["Container"]
+++
## 前言

[![](https://img.maki0419.com/blog/nextcloud/preview.jpg)](https://img.maki0419.com/blog/nextcloud/preview.jpg) 

> Nextcloud是一套用於建立網路硬碟的客戶端－伺服器軟體。其功能與Dropbox相近，但Nextcloud是自由及開放原始碼軟體，每個人都可以在私人伺服器上安裝並執行它。
> 
> [——維基百科](https://zh.wikipedia.org/zh-tw/Nextcloud)

[![](https://img.maki0419.com/blog/nextcloud/Nextcloud.png)](https://nextcloud.com/) 

 我的blogger日瀏覧量約1000人次，其中1/4是來自大陸牆內，因為眾所周知的原因，他們看不到blogger上google伺服器的圖片 (過牆請見[附註](#Wall))  

我想所有站長都知道圖片的重要，一但失去圖片，文章看起來就是垃圾。

~~不要誤會，我不是針對你~~  
說起圖片站，常見到的像是imgur、upload.cc、Flickr

前兩個確定牆了，Flickr Pro據說能過，但樹大招風(ry

  
 這裡就是私有主機出場的地方了! ⁽⁽٩(๑˃̶͈̀ ᗨ ˂̶͈́)۶⁾⁾  

  
 圖片鏈結放在與blogger同一網域下，若整個站被牆那就是另一層面的問題了 ┐(´д\`)┌

 且我的Nextcloud同時做為檔案主機和圖片主機  

 所以不只圖片，分享檔案再也不用和該死的百毒網盤大眼瞪小眼wwww  
而效果，試試看這條網址:<https://cloud.maki0419.com/s/RDFmcPoi3gZ6kmq> 

  
這是我花一週做出的專案，docker真心好玩 (ㆆᴗㆆ)

  
 本機客戶端設定自動同步後，只要在電腦裡把檔案放進資料夾就會自動上傳Nextcloud，接著直接輸入網址就能訪問  

有沒有看到文首的圖片? 對，他就在一個blog\\nextcloud\\preview.jpg的路徑下

  
 寫blog時上傳圖片唯一要做的一件事，就是把它拖進去  

[![](https://img.maki0419.com/blog/nextcloud/0.png)](https://img.maki0419.com/blog/nextcloud/0.png) 

 上傳是機器的事，我就按資料夾名拼網址用就好  
(因為一些原因，我把這張圖重命名為了preview.jpg)

## 概觀

### 本專案核心目標

* 以最少的步驟建立整個server
* 定時備份功能
* 同時做為檔案分享站和圖片站，圖片站需要縮址和直鏈訪問

### 本專案特徵

* 使用nextcloud官方image，將來升級就是 docker-compose pull 解決
* 重寫了docker-compose file將需要填入的部份獨立出來，並降到最少
* 分開nginx reverse proxy和Nextcloud的compose file，實現擴充彈性
* 用Cloudflare Worker將img網域做縮址，以產生漂亮的圖片直鏈

### 本文適合對象

* 初級以上的linux操作基礎
* 有自己的主機或NAS，沒有可以[現在租](#DigitalOcean) (不然你檔案想放哪裡?)
* **會在意中國大陸看不到圖片的blogger站長** 我

## 流程簡述

1. [Linux主機之Docker安裝和ReveseProxy建置](/2020/11/linux-docker-setup-revese-proxy.html)
2. git clone下來docker-compose建置檔案和config檔案
3. 密碼類的個別設定
4. docker-compose up -d
5. (選)Restore既有資料和config

## 硬體架構

 機器有兩台: Digital Ocean租的VPS做主要伺服器；我家的Synology NAS做備份伺服器  
若不備份Rsync Server就不是必要的。本文會講解不做備份的設定方式  

┌ Digital Ocean Droplet (Main Server)

WWW  

└ Synology NAS (Rsync Server)

## Main Server系統架構

WWW

│  

 Reverse Proxy (nginx Server) (SSL證書申請、Renew)  
│ ┌ MariaDB資料庫 (網路只對Nextcloud)  
└ Nextcloud (nginx Server)  
 └ Jobber (Cron) (定時備份Docker volume，備份完送至rsync server)

##  DNS設定和Cache設定

我使用Cloudflare做DNS和Cache  
若用其它DNS商請略過Cache設定

  
SSL相關設定如此是為了讓Let's Encrypt能成功訪問，請留意

  
 DNS Record有三條，一條A指向SERVER\_IP，另倆CNAME指向A Record  
nextcloud網域DNS Only用做日常操作，以免Cache造成回應錯誤  
Cache只設定於cloud和img倆網域上，分享時使用這倆網域以節省主機流量，Cloudflare能夠抓住近99% 

* DNS  
* A: `nextcloud.domain.com` → SERVER\_IP (DNS Only)  
* CNAME: `cloud.domain.com` →`nextcloud.domain.com` (Proxied)  
* CNAME: `img.domain.com` →`nextcloud.domain.com` (Proxied)
* SSL/TLS  
* Always Use HTTPS: **Off**  
* HTTP Strict Transport Security (HSTS):**Disabled**  
* Automatic HTTPS Rewrites: (Can enable if needed)
* Caching  
* Caching Level: Standard
 Page Rule 
* `*domain.com/.well-known/acme-challenge*`  
* **Disable Everything**  
* Cache Level: Bypass
nextcloud.domain.com/index.php/apps/sharingpath//Public/\* 
* Disable Security
* Browser Integrity Check: Off
* SSL: Full
* Browser Cache TTL: a year
* Cache Level: Cache Everything
* Edge Cache TTL: a month
* Automatic HTTPS Rewrites: On
* Disable Performance
* `https://cloud.domain.com/*`  
* SSL: Full  
* Rocket Loader: Off  
* Cache Level: Cache Everything  
* Automatic HTTPS Rewrites: On  
* Disable Apps

## 建置

### Linux主機和Docker安裝

請完成此文的建置章節  

> 琳的備忘手札 \[Docker\] Linux主機之Docker安裝和ReveseProxy建置  
> </2020/11/linux-docker-setup-revese-proxy.html> 

### Nextcloud建置

* cd到root家目錄  
cd
* git clone專案  
git clone https://github.com/jim60105/docker-Nextcloud.git
* 進入docker-Nextcloud資料夾  
cd docker-Nextcloud
* 填入.env檔案  
cp .env_sample .env && vim .env  
[![](https://img.maki0419.com/blog/nextcloud/10.png)](https://img.maki0419.com/blog/nextcloud/10.png)  
   * `LETSENCRYPT_TEST`: 此為設定申請測試SSL證書，現在給true，**最後上線前才改false**  
   * `LETSENCRYPT_EMAIL`: Let's Encrypt在證書到期時通知你用的email，不會透過這個做驗證。但這也是你對網域的申報，建議正確填入。  
   * `LETSENCRYPT_HOST`: SSL證書網域名稱和別名。以半型逗點「,」分隔，不能用wildcard  
   * `NEXTCLOUD_TRUSTED_DOMAINS`: Nextcloud的信任網域，這是一個安全性設定，以其它的網域訪問Nextcloud時會被擋住  
    建議和LETSENCRYPT\_HOST填入相同內容但以空白分隔，或可用「\*」wildcard字符  
    需注意，填入後若要消除，必須到nextcloud container下的/var/www/html/config/config.php中做消除  
   此處設定只寫不消，且只在第一次建立Nextcloud設定檔時會讀取
* 填入db.env檔案  
cp db.env_sample db.env && vim db.env  
   * `MYSQL_PASSWORD`: Nextcloud程式專用帳號的Database密碼  
   * `MYSQL_ROOT_PASSWORD`: Database的root密碼  
    
下面這兩條可不使用，只有同時設定了才會生效  
設定了上機時會跳過創建主帳號程序，直接開始Nextcloud初始化  
   * `NEXTCLOUD_ADMIN_USER`: 創建你要用的Nextcloud帳號  
   * `NEXTCLOUD_ADMIN_PASSWORD`:創建你要用的Nextcloud密碼
* 修改jobber部份:  
   * 你有Rsync Server，且會按照本文設定  
   →建立\~/ssh.pas檔案過build，密碼我們後面再填入  
   touch ~/ssh.pas  
   * 你沒有Rsync Server，定時備份後留在Main Server就好  
   →編輯docker-compose.yml，刪除JOB\_COMMAND1的後半段、secrets相關內容  
   [![](https://img.maki0419.com/blog/nextcloud/18.png)](https://img.maki0419.com/blog/nextcloud/18.png)  
   * 你完全不想執行備份  
   →編輯docker-compose.yml，刪除secrets相關內容和整個jobber  
   [![](https://img.maki0419.com/blog/nextcloud/17.png)](https://img.maki0419.com/blog/nextcloud/17.png)
* 起機囉\~\~  
docker-compose up -d
* 檢查Container是否都有起來  
docker ps -a  
[![](https://img.maki0419.com/blog/nextcloud/11.png)](https://img.maki0419.com/blog/nextcloud/11.png)
* 檢查SSL是否成功  
docker logs proxy_le -f  
 注意紅框處，這樣就是成功  
[![](https://img.maki0419.com/blog/nextcloud/12.png)](https://img.maki0419.com/blog/nextcloud/12.png)
* 將SSL申請改為正式申請  
vim .env  
 第一行`LETSENCRYPT_TEST`改為`false`  
> ※注意  
> 因為Let's Encrypt針對網域正式申請有次數限制，不論成功與否，做太多次就會鎖住  
> 發布前一定要測試成功再轉正，並於申請成功後備份cert  
 重做compose  
docker-compose down -v && docker compose up -d  
 檢查是否有成功要到正式證書  
注意紅框處，已沒有\_test\_字樣  
[![](https://img.maki0419.com/blog/nextcloud/13.png)](https://img.maki0419.com/blog/nextcloud/13.png)

## Rsync Server設定和備份還原

### Rsync Server設定   

* Synology rsync server設定
   * Rsync是DSM內建功能，開啟「控制台→檔案服務→rsync」  
   啟動rsync服務，port可改(或者由上層的router，外自訂轉內22)  
   [![](https://img.maki0419.com/blog/nextcloud/rsync1.png)](https://img.maki0419.com/blog/nextcloud/rsync1.png)
   * 「使用者帳號→新增使用者」  
   使用者名**必須為rsync**，密碼記起來  
   [![](https://img.maki0419.com/blog/nextcloud/rsync2.png)](https://img.maki0419.com/blog/nextcloud/rsync2.png)
   * 設定NetBackup為可讀寫，其餘禁止  
   (這rsync專用的共用資料夾**必須名為NetBackup**)  
   [![](https://img.maki0419.com/blog/nextcloud/rsync3.png)](https://img.maki0419.com/blog/nextcloud/rsync3.png)
   * 使用者建立後，選中rsync使用者「編輯」→「應用程式」頁籤  
   全選禁止，再選中「rsync服務→針對IP設定」  
   「允許清單→新增IP位址→單一主機」，填入Main Server的IP  
   [![](https://img.maki0419.com/blog/nextcloud/rsync4.png)](https://img.maki0419.com/blog/nextcloud/rsync4.png)
* 回到Main Server，修改upload.sh的設定  
cp shellScript/upload.sh_sample shellScript/upload.sh && vim shellScript/upload.sh  
 最後兩行修改如下，填入你的RSYNC\_SERVER\_IP和PORT  
su - root -c "ssh-keyscan -p 你的PORT 你的RSYNC_SERVER_IP >> ~/.ssh/known_hosts"  
su - root -c "sshpass -f /run/secrets/rsyncpass rsync -e 'ssh -p 你的PORT' -avz --no-p --no-g /backup/ rsync@你的RSYNC_SERVER_IP::NetBackup/docker_backup/"
* 將shellScript下的檔案權限都改為可執行  
chmod 744 shellScript/* && ls -al shellScript/  
 root權限應為rwx  
[![](https://img.maki0419.com/blog/nextcloud/14.png)](https://img.maki0419.com/blog/nextcloud/14.png)
* 設定rsync server的ssh密碼，填入Rsync Server上rsync使用者的密碼  
echo "你的密碼" > ~/ssh.pas
* 修改密碼檔權限為-rw-------  
chmod 600 ~/ssh.pas

### 備份

測試定時備份功能，下面這段的意思是  
「在名為docker-nextcloud\_jobber\_1的container中，執行jobber test指令，測試名為Backup的定時工作」  

docker exec -it docker-nextcloud_jobber_1 jobber test Backup

Stderr會報說下載了docker image和加入SSH-Key, 但只要有輸出rsync資訊就是成功  

[![](https://img.maki0419.com/blog/nextcloud/15.png)](https://img.maki0419.com/blog/nextcloud/15.png) 

 也別忘了到Rsync Server確認檔案是否存在

[![](https://img.maki0419.com/blog/nextcloud/rsync5.png)](https://img.maki0419.com/blog/nextcloud/rsync5.png) 

爆了 (´ﾟдﾟ\`) 

> ※提醒  
> upload.sh不能在host直接執行，因為密碼檔是以docker secrets的方式處理  
> 此路徑在host不存在

  
 我做了簡易的log，記錄下執行時間和IP

[![](https://img.maki0419.com/blog/nextcloud/16.png)](https://img.maki0419.com/blog/nextcloud/16.png) 

### 還原  

 把備份檔案放回Main Server的/backup資料夾下  
這部份沒有特別建立管道，我是以區網Samba連到NAS，再拖曳進MobaXterm的SFTP傳輸  
因為安全性考量，我不希望建立能自動從我家NAS輸出資料的管道  
  
假若前面有申請了新的正式SSL證書想要保留，留下reverseproxy字樣的備份不覆蓋  
 執行Restore

./shellScript/restore.sh && ./shellScript/startContainer.sh

 若restore後不希望自啟動，去掉&&後那一段

> ※提醒  
> restore邏輯  
> 1. 由tag為nextcloud和proxy的現存volume中取得清單
> 2. 去/backup資料夾找檔案做複原
> 故運行前**要先有volume存在**，意即必須得先docker-compose up一次建立volume，後做restore  

> ※提醒  
> renameVolume.sh的用法如下  
> 
> renameVolume.sh oldVolumeName newVolumeName
> 
> rename邏輯  
> 1. 如果新volume不存在就建立，否則清空延用volume
> 2. 將舊volume的檔案傳到新的volume
> 3. 砍掉舊的volume
> 在建立的過程中不會帶有backup.sh需要的label，所以要由docker-compose up來建立

## img圖片縮址

### img網域的縮址如下

`https://img.domain.com/OOXX`   

 \=  
https://nextcloud.domain.com/index.php/apps/sharingpath//Public/OOXX   

  
### 在Cloudflare操作

* 先確定是否有按照[前面的小節](#dnsSetting)做Cloudflare設定
* 如果你是第一次使用Cloudflare Worker，你可能需要閱讀[官方手冊](https://developers.cloudflare.com/workers/learning/getting-started)，直至可以建立一般的線上worker
* 建一個Worker，內容把[這些Code](https://github.com/jim60105/docker-Nextcloud/blob/master/CloudflareWorker/worker.js)複製進去
* 修改前三行的內容
   * `NextCloudUserName` \= 你在nextcloud的username
   * `SourceHost` \= 你的img網域
   * `TargetHost` \= 你的nextcloud網域
* Route `img.domain.com/*` 到這個Worker

> 延伸閱讀  
> 我另外寫了一個[此Cloudflare Worker的持續部屬專案](https://github.com/jim60105/worker-img%5Frouter)，有興趣可以參考看看

### 在Nextcloud操作

1. 安裝Nextcloud應用程式: Sharing Path  
 右上角「應用程式→Files分類」，裝上Sharing path  
> ※**注意**:  
> Sharing Path會開啟「以路徑直鏈訪問公開檔案」功能  
> 這雖然方便，但會導致路徑可猜的資安問題  
> 故**建議此Nextcloud只存放低敏感度資料**
2. 右上角「設定→個人-分享→Sharing Path」，勾上Enable sharing path
3. 「設定→管理-分享」，勾選以下項目  
   * 允許 apps 使用分享 API  
   * 允許使用者透過連結分享  
         * 允許公開上傳  
   * 允許使用者名稱自動補齊在分享對話框  
   * 允許這台伺服器上的使用者發送分享給其他伺服器  
   * Search global and public address book for users
4. 在Nextcloud根目錄新增Public資料夾，此資料夾開啟外部唯讀分享，做為分享的根目錄
5. Public資料夾下放做為img網域的favicon.ico，即`Public/favicon.ico`

## 客戶端

 最後，你會需要一個Nextcloud客戶端，做[自動同步](#client)  
[\>>官網<<](https://nextcloud.com/install/#install-clients) ლ( • ̀ω•́ )っ  
在這裡可以取得，而且安裝非常簡單

 安裝時請填入沒有過proxy的nextcloud網域  

## 附註: Nextcloud升級

因為用了docker，內建的升級功能會有問題，必須在docker image層面升級

 參考[官方指南](https://github.com/nextcloud/docker#update-to-a-newer-version) 

docker-compose pull
docker-compose up -d

注意，一次只能升級一版 

 意即如果要從17升19，要17升18；18再升19

sed -i -e 's/nextcloud:[0-9.]*-apache/nextcloud:18-apache/g' docker-compose.yml
docker-compose up -d

 進入網頁確認升級完成，然後

sed -i -e 's/nextcloud:[0-9.]*-apache/nextcloud:19-apache/g' docker-compose.yml
docker-compose up -d

[這裡有所有可用的版號](https://github.com/docker-library/docs/blob/amd64/nextcloud/README.md#supported-tags-and-respective-dockerfile-links)  

##  附註: Content-Security-Policy問題

我不確定什麼情況會讓Nextcloud觸發Content-Security-Policy Error

這個問題的解法是在Nextcloud目錄下之.htaccess file加上設定  
這個檔案會在升級時被重置

docker exec -it docker-nextcloud_app_1 bash
apt-get update && apt-get install vim -y
vim .htaccess

在最後面加上以下幾行，記得把\*.domain.com換成你的域名  


  Header set Content-Security-Policy " \
      img-src 'self' *.domain.com www.google-analytics.com *.nextcloud.com data: blob:; \
  "
  
## 附註: 讓Blogger過牆

 Blogger是放在Google的伺服器，預設狀態牆內無法瀏覧，但我們能用一些方式讓它過牆  

 這裡有兩個要素要更動: 域名和IP，只要這倆個都不是掛在Google就能通過

* 購買一個自己的網域，並在Blogger後台設定一個子網域給blogger使用。  
像本站是[blog.maki0419.com](https://blog.maki0419.com/)[ ](https://blog.maki0419.com/)
* 將此網域通過Cloudflare DNS Proxy，這會改變出站IP  
隱藏伺服器的真實IP也有一定的資安保護做用

| [![](https://1.bp.blogspot.com/-u6JipiNSz78/XwNR9r3-GlI/AAAAAAAAMiA/IQvzXUnudn0zcRE4KbhVJ3Y8eRyHOitBgCK4BGAsYHg/d/2020-07-07%2B00%2B28%2B41.png)](https://1.bp.blogspot.com/-u6JipiNSz78/XwNR9r3-GlI/AAAAAAAAMiA/IQvzXUnudn0zcRE4KbhVJ3Y8eRyHOitBgCK4BGAsYHg/s1191/2020-07-07%2B00%2B28%2B41.png) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 這張以內建功能上傳的圖片，網址在哪裡呢?                                                                                                                                                                                                                                                            |

 以上簡單的操作可讓Blogger本站過牆，但Blogger內建的圖片上傳功能並不會套用自訂網域在圖片網址上

這使得我們只能使用外鏈圖片，不能用Google內建的圖片上傳

而架設這個「外鏈圖片站」，就是本專案的核心目標 (・\`ω´・)  

iscn://likecoin-chain/aXd1wy1XjZZQ72ErL3P5adhEFObEBmvbLGiaJS9nVJg