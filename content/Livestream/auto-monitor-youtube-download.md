+++
title = "[Docker] 直播監控、自動影片下載筆記 (Youtube、Twitch、TwitCasting、Twitter Spaces 音訊空間)"
description = "我平時使用數個監控服務，在指定的頻道直播時自動啟動錄影，以防直播主突襲又刪檔，使我錯過直播。此文將會列出這些我使用的服務，供各位參考。"
date = 2022-01-04T17:20:00.005Z
updated = 2022-12-15T21:13:57.361Z
draft = false
aliases = [ "/2022/01/auto-monitor-youtube-download.html" ]

[taxonomies]
tags = [
  "Container",
  "Livestream",
  "TwitCasting",
  "Twitch",
  "Youtube",
  "yt-dlp"
]

[extra]
iscn = "iscn://likecoin-chain/Zyffo_xXdY9tey8jRREjFiwTdw8rntU6nCsa3t60rRk/1"
+++

![container](../auto-monitor-youtube-download.png)

## 前言

我平時使用數個監控服務，在指定的頻道直播時自動啟動錄影，以防直播主突襲又刪檔，使我錯過直播。此文將會列出這些我使用的服務，供各位參考。

此篇不會寫詳細步驟，請閱讀各專案的說明以完成設定

{% alert(important=true) %}
以下所有服務皆使用 Docker 部署  
請確保你已經[安裝好 Docker 環境](https://docs.docker.com/get-docker/)再繼續閱讀
{% end %}

> 延伸閱讀
>
> ---
> 本文的專案都是建立在前篇介紹過的工具之上  
> [影片下載、轉檔筆記 (Youtube 、 Twitch 、 TwitCasting 、 Twitter Spaces 音訊空間 、 ffmpeg)](/2022/01/youtube-download-ytdlp-ffmpeg.html)

> 延伸閱讀
>
> ---
> 如果要租 VPS 主機，請參考這篇的前半部份  
> [\[Docker\] Linux 主機之 Docker 安裝和 ReverseProxy 建置](/Container/linux-docker-setup-reverse-proxy)
<!--more-->
## Youtube 監控 - live-dl

專案: [jim60105/live-dl](https://github.com/jim60105/live-dl)  
Docker Compose: [jim60105/docker-youtube-dl](https://github.com/jim60105/docker-youtube-dl)

Youtube 監控我使用自己魔改過的 live-dl 專案，我曾寫過[專文](/2020/11/docker-youtube-dl-auto-recording-live-dl.html)介紹  
這個 Docker Compose 中還附帶有 WebUI 和 [backup-dl](/2021/06/backup-dl.html) (備份影片至 Azure Storage 的專案)

## Youtube 備份 - backup-dl

專案: [jim60105/backup-dl](https://github.com/jim60105/backup-dl)  
Docker Compose: [jim60105/docker-youtube-dl](https://github.com/jim60105/docker-youtube-dl)

此程式可以檢查 Youtube 頻道、播放清單，並備份影片至 Azure Blob Storage  
詳見此專文介紹: [\[Docker\] Backup-dl - 備份 Youtube 影片至 Azure Blob Storage](/2021/06/backup-dl.html)

## Twitch 監控 - Ancalentari Twitch Stream Recorder

專案: [Ancalentari Twitch Stream Recorder](https://github.com/ancalentari/twitch-stream-recorder)  
Docker Compose: [jim60105/docker-twitch-recorder](https://github.com/jim60105/docker-twitch-recorder)

Twitch 監控我是使用別人寫的監控專案，他是以 streamlink 去接 twitch api，我只將之做了 Dockerize

## TwitCasting 監控 - TwitCasting Recorder

專案: [TwitCasting Recorder](https://github.com/prinsss/twitcasting-recorder)  
Docker Compose: [jim60105/docker-twitcasting-recorder](https://github.com/jim60105/docker-twitcasting-recorder)

這個 TwitCasting Recorder 專案在我測了數個專案後才找到它，是唯一一個運作良好的專案。它底下使用 websocket 接串流寫檔。我加上了 ts 轉檔為 mp4、發 discord 通知等，並包成了 container

## Twitter Spaces 監控 - Twspace-dl

專案 & Docker Compose: [Twspace-dl](https://github.com/HoloArchivists/twspace-dl)

twspace-dl 以特定的方法取得音訊空間的 m3u8 網址，並塞進 ffmpeg 做下載。我為其做了 Dockerize 並提了 PR 回去，你能在原專案找到我寫的 Docker Compose 和 monitor.sh。
