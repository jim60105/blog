+++
title = "Handshake domain 區塊鏈網域 —— 如何設定網域"
description = "Handshake domain 區塊鏈網域 —— 如何設定網域"
date = 2022-03-05T20:37:00.011Z
updated = 2022-12-15T20:31:35.247Z
draft = false
aliases = [ "/2022/03/handshake-blockchain-domain-how-to-setup.html" ]

[taxonomies]
tags = [ "區塊鏈" ]

[extra]
banner = "https://img.maki0419.com/blog/blockchain-domain/handshake/preview.png"
+++
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/preview.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/preview.png)

> 前篇  
> [Handshake domain 區塊鏈網域 —— 如何訪問網域](/2022/01/handshake-blockchain-domain-how-to-access.html)

在前兩篇我們成功競標到了網域，也設定好了環境使可訪問Handshake domain，這篇我們要實際寫DNS位置到鏈上，讓網站上線，最後會提及一些Namebase的加值服務，值得一試。

## 事前準備

在開始以前，我們需要有一個簡單的Hello World網站、一台網頁伺服器，和一台Name Server。選擇很多，為了方便Demo，我將使用Github Pages做為網頁和網頁伺服器，並在DigitalOcean租一台VPS，安裝BIND以做為NameServer。

### 範例網頁伺服器

* [建立Github帳號](https://github.com/)
* Fork以下Repo: <https://github.com/digitalocean/sample-html>  
> 我們不使用DigitalOcean Apps做網頁服務，因為它不支援Handshake domain  
> 但它的Sample真的蠻漂亮的，借來一用  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/1.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/1.png)
* 點右上的「Settings」
* 點左側的「Pages」，在右方選擇「main」這個branch  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/2.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/2.png)  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/3.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/3.png)
* 「Save」後等約兩分鐘，等Github將你的網站部署上去  
Github提供的網址為:` https://<你的username>.github.io/sample-html/ `，而我們後面要把它對應到Handshake domain  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/4.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/4.png)

### 範例Name Server

> 為方便演示，本文使用別人包裝好，包含GUI界面的docker image: [sameersbn/bind](https://hub.docker.com/r/sameersbn/bind/)  
> 資訊安全保護不良的Name Server常成為駭客眼中的肥羊  
> 請將此章節視為功能演示就好

* 開一台VPS  
> 請參考本文建置主機，安裝Docker環境  
> [琳的備忘手札: \[Docker\] Linux主機之Docker安裝和ReveseProxy建置](/2020/11/linux-docker-setup-revese-proxy.html)  
配置新主機請參考此設定  
[點擊放大 ![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/5.png)](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/5.png)
* 安裝BIND
   * docker pull sameersbn/bind
   * 關閉 systemd-resolved  
   systemctl disable systemd-resolved  
   systemctl stop systemd-resolved
   * docker run --name bind -d --restart=always \  
     --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \  
     --volume /srv/docker/bind:/data \  
     sameersbn/bind
   * 在服務成功啟動後，新增防火牆規則，開啟UDP 53、TCP 53、10000 port，配置到VPS上  
   [![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/6.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/6.png)
   * 瀏覧器打開VPS的10000 port，預設密碼為`root/password`  
   [![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%281%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%281%29.png)

## 設定Bob Wallet中的網域

* 由左側的Domain Manager選擇目標domain，Add Records  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/9.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/9.png)
* 新增兩條記錄，NS記錄和GLUE4記錄  
注意勿遺漏在網域後面的那個點(.)  
| NS    | ns1.chenchun.                 |
|-------|-------------------------------|
| GLUE4 | ns1.chenchun. 178.128.XXX.XXX |
> Handshake records的詳細說明請見此  
> Handshake Resource Record Guide - Handshake Developer Documentation<https://hsd-dev.org/guides/resource-records.html>  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/10.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/10.png)
* 寫到鏈上要15分鐘，但更新入Handshake domain要6小時以上。總之等個半天再來做測試吧  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/11.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/11.png)

## 設定Namebase中的網域

> Namebase有提供DNS服務，功能使用上沒什麼問題  
> 但如果託管在Namebase就變成使用另一個中心化服務，失去了去中心化的優點  
> 你可以選擇「網域託管在Namebase，並使用Namebase的DNS」、  
> 「網域託管在Namebase，並指向私人DNS」、  
> 「網域轉出至Bob Wallet」等不同的配置
>
> 本章節將示範「網域託管在Namebase，並指向私人DNS」的配置模式

* 來到[Dashboard → Domain Manager](https://www.namebase.io/manage/owned?page=1) → Manage  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/12.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/12.png)
* 在「Blockchain DNS records」中的ns1填入VPS的IP，ns2刪除  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/13.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/13.png)
* 寫到鏈上要15分鐘，但更新入Handshake domain要6小時以上。總之等個半天再來做測試吧

## 在Name Server上添加網域和Record

> 參考資料  
> [Deploying a DNS Server using Docker - SAMEER NAIK](http://www.damagehead.com/blog/2015/04/28/deploying-a-dns-server-using-docker/)

* 左側「Server」→「BIND DNS Server」→「Create master zone」  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%282%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%282%29.png)
* 填寫如圖，按Create  
| Domain name                          | chenchun    |
|--------------------------------------|-------------|
| Master server                        | ns.chenchun |
| Use zone template?                   | Yes         |
| Add reverses for template addresses? | No          |
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%283%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%283%29.png)
* 選擇「Address」，填寫如圖，按Create  
| Name    | ns.chenchun     |
|---------|-----------------|
| Address | 178.128.XXX.XXX |
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%284%29.png)](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%284%29.png)  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%285%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%285%29.png)
* 選擇「Name Alias」，填寫如圖，按Create  
| Name      | color                                           |
|-----------|-------------------------------------------------|
| Real Name | <你的username>.github.io. (注意最後面有一個點！) |
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%286%29.png)](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%286%29.png)  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%287%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%287%29.png)
* 最後，點右上角的「Apply configuration」！  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%288%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%288%29.png)
* 在主機上確認能否解析`color.chenchun`至jim60105.github.io.  
[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%289%29.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/bind%20%289%29.png)

## 將網域設定至Github Pages

> 設定Github Pages的詳細官方文件請見此  
> [Managing a custom domain for your GitHub Pages site - GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)

來到剛才的「Settings」→「Pages」頁面，在「Custom Domain」填入網域名稱  
這會在Repo根目錄建立一個「CNAME」檔  

[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/15.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/15.png)

不用理會下方的設定失敗，Github不能解析Handshake domains

[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/16.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/16.png)

## 結語

[![](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/17.png) ](https://img.maki0419.com/blog/blockchain-domain/handshake/setup/17.png)

至此，Handshake domain介紹告一段落。本系列文從原理、競標、訪問，至設定都介紹了一輪，也實際演示下標了兩個網域並實際上架了一個網站。希望各位對Handshake domain都有了大致的了解。

但是，區塊鏈可還沒介紹完！下篇將繼續介紹Unstoppable Domains和Ethereum Name Service

## 附註: Namebase的其它加值服務

> 以下章節待補，我之後再補上  
> 我最近真的忙爆了

### dLinks

### Redirects 轉址

### Handshake Login

### 販賣、贈送Handshake網域

### 販賣、贈送你的子網域

iscn://likecoin-chain/TW11huUVHy5Bsg0S3prnXNNYKzj0iabfmREUOaGla1w