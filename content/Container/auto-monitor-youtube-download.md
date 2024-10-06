+++
title = "[Docker] 直播監控、自動影片下載筆記 ( Youtube 、 Twitch 、 TwitCasting 、 Twitter Spaces 音訊空間)"
description = ""
date = 2022-01-04T17:20:00.005Z
updated = 2022-12-15T21:13:57.361Z
draft = false
aliases = ["/2022/01/auto-monitor-youtube-download.html"]

[taxonomies]
tags = ["Container", "YouTube"]
+++
[![](https://img.maki0419.com/blog/preview/monitor.png)](https://img.maki0419.com/blog/preview/monitor.png) 

## 前言

 我平時使用數個監控服務，在指定的頻道直播時自動啟動錄影，以防直播主突襲又刪檔，使我錯過直播。此文將會列出這些我使用的服務，供各位參考。

 此篇不會寫詳細步驟，請閱讀各專案的說明以完成設定

> 以下所有服務皆使用Docker部署  
> 請確保你已經[安裝好Docker環境](https://docs.docker.com/get-docker/)再繼續閱讀

> 延伸閱讀
> 
> ---
> 
> 本文的專案都是建立在前篇介紹過的工具之上  
> [影片下載、轉檔筆記 ( Youtube 、 Twitch 、 TwitCasting 、 Twitter Spaces 音訊空間 、 ffmpeg )](/2022/01/youtube-download-ytdlp-ffmpeg.html) 

> 延伸閱讀
> 
> ---
> 
> 如果要租VPS主機，請參考這篇的前半部份  
> [\[Docker\] Linux主機之Docker安裝和ReveseProxy建置](/2020/11/linux-docker-setup-revese-proxy.html) 

## Youtube監控 - live-dl

 專案: [jim60105/live-dl](https://github.com/jim60105/live-dl)  
 Docker Compose: [jim60105/docker-youtube-dl](https://github.com/jim60105/docker-youtube-dl) 

 Youtube監控我使用自己魔改過的live-dl專案，我曾寫過[專文](/2020/11/docker-youtube-dl-auto-recording-live-dl.html)介紹  
 這個Docker Compose中還附帶有WebUI和[backup-dl](/2021/06/backup-dl.html)(備份影片至Azure Storage的專案)

## Youtube備份 - backup-dl

 專案: [jim60105/backup-dl](https://github.com/jim60105/backup-dl)  
 Docker Compose: [jim60105/docker-youtube-dl](https://github.com/jim60105/docker-youtube-dl) 

 此程式可以檢查Youtube頻道、播放清單，並備份影片至Azure Blob Storage  
 詳見此專文介紹: [\[Docker\] Backup-dl - 備份Youtube影片至Azure Blob Storage](/2021/06/backup-dl.html) 

## Twitch監控 - Ancalentari Twitch Stream Recorder

 專案: [Ancalentari Twitch Stream Recorder](https://github.com/ancalentari/twitch-stream-recorder)  
 Docker Compose: [jim60105/docker-twitch-recorder](https://github.com/jim60105/docker-twitch-recorder) 

 Twitch監控我是使用別人寫的監控專案，他是以streamlink去接twitch api，我只將之做了Dockerize

## TwitCasting監控 - TwitCasting Recorder

 專案: [TwitCasting Recorder](https://github.com/prinsss/twitcasting-recorder)  
 Docker Compose: [jim60105/docker-twitcasting-recorder](https://github.com/jim60105/docker-twitcasting-recorder) 

 這個TwitCasting Recorder專案在我測了數個專案後才找到它，是唯一一個運作良好的專案。它底下使用websocket接串流寫檔。我加上了ts轉檔為mp4、發discord通知等，並包成了container

## Twitter Spaces監控 - Twspace-dl

 專案 & Docker Compose: [Twspace-dl](https://github.com/Ryu1845/twspace-dl) 

 twspace-dl以特定的方法取得音訊空間的m3u8網址，並塞進ffmpeg做下載。我為其做了Dockerize並提了PR回去，你能在原專案找到我寫的Docker Compose和monitor.sh。

iscn://likecoin-chain/Zyffo\_xXdY9tey8jRREjFiwTdw8rntU6nCsa3t60rRk