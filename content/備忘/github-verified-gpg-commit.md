+++
title = "Github Verified之GPG金鑰設定"
description = ""
date = 2020-11-09T18:25:00.037Z
updated = 2022-06-14T11:04:54.863Z
draft = false
aliases = ["/2020/11/github-verified-gpg-commit.html"]

[taxonomies]
tags = ["備忘"]
+++
[![](https://img.maki0419.com/blog/preview/gpg.png)](https://img.maki0419.com/blog/preview/gpg.png) 

 最近我重新深入學習了git，並好好檢視了自己的github頁面  
 以前就注意到了這個酷炫的Verified標誌，在Github線上改README時會被自動加上，在本地commit就沒有  
這個標誌能顯示此commit確實是由我做出，並不是別人冒名而做  

這次我好好研究了下gpg金鑰的設定方法，並把流程記錄在此  

## 安裝GPG軟體

> Chocolatey GnuPG `choco install gnupg`

 在[GnuPG網站](https://gnupg.org/download/#binary)下載軟體  
 請往下拉到binary releases，並下載第二項「Gpg4win - Simple installer for the current GnuPG」

 「Gpg4win - Full featured Windows version of GnuPG」內含Gui金鑰管理器，我覺得並不好用  
 如果只是要對git操作簽章，直接從command line設定會比較單純  
 (這和是否使用Gui工具做git並無關係，但請於設定完成後確認運作)  

## 確認現有金鑰

gpg --list-secret-keys --keyid-format LONG

  
## 產生金鑰

> 注意: Github要求Key Size 必須是**4096** bits以上 


gpg --full-generate-key

  
## 登錄公鑰至Github

先確認剛產生的金鑰

gpg --list-secret-keys --keyid-format LONG

以純文字產出公鑰，將之複製


gpg --armor --export 你的金鑰ID

至[Github的keys設定頁面](https://github.com/settings/keys)，將GPG key加入   
  
## 設定使git預設執行簽章


git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"
git config --global user.signingkey 你的金鑰ID
git config --global commit.gpgsign true
git config --global tag.gpgSign true

  
## 備份金鑰

 金鑰產生後請妥善離線保管，這兩個檔案可用於複製金鑰至其它電腦上   

### Output


gpg --output mygpgkey_pub.gpg --armor --export 你的金鑰ID
gpg --output mygpgkey_sec.gpg --armor --export-secret-key 你的金鑰ID

### Input


gpg --import ./mygpgkey_pub.gpg
gpg --allow-secret-key-import --import ./mygpgkey_sec.gpg

  
\>> 參考連結[https://www.debuntu.org/how-to-importexport-gpg-key-pair/](https://www.debuntu.org/how-to-importexport-gpg-key-pair/ )  
  
## 延長金鑰快取驗證之有效期

 我不希望每次commit都要輸入密碼，在每次重開機後的第一次使用時問我就足夠了  

1. 首先找到gpg home  
gpg --version  
 Windows: `%AppData%\gnupg\`  
 Linux: `~\.gnupg\`
2. 在此路徑中建立gpg-agent.conf檔案，並寫入以下設定 (這是一年)  
default-cache-ttl 34560000  
max-cache-ttl 34560000

## Troubleshooting

### Windows啟動後，首次驗證時對話框不會彈出，並驗證失敗

 我最近重灌了Windows，改以choco直接安裝gnupg，並遇到了此問題  
重開機後的第一次commit必定失敗，不會跳出gnupg輸入框  
我不確定和前次安裝的具體差異為何，但有找到解法如下  
請只在遇到此問題後才做這個

1. _Win+R_，輸入`shell:startup`，以開啟_Start Menu\\Programs\\Startup_
2. 建立捷徑，路徑填入以下內容，完成  
gpgconf --launch gpg-agent
3. 右鍵捷徑修改內容: 捷徑頁籤 → 執行: **最小化**

## 參考連結

* [Managing commit signature verification - Github Docs](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/managing-commit-signature-verification)
* [如何使用 GPG (GnuPG) 對 Git Commit 與 Tag 進行簽章 - Will 保哥](https://blog.miniasp.com/post/2020/05/04/How-to-use-GPG-sign-git-commit-and-tag-object)