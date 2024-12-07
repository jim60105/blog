+++
title = "在 bash 中組合使用變數和萬用字元的正確語法"
description = "在 bash 中組合使用變數和萬用字元的正確語法"
date = 2022-04-16T17:05:00.001Z
updated = 2022-04-16T17:06:30.280Z
draft = false
aliases = [
  "/2022/04/explain-the-correct-syntax-when-using-variables-and-wildcards-together-in-bash.html"
]

[taxonomies]
tags = [ "System Admin" ]
licenses = [ "GFDL 1.3" ]

[extra]
banner = "preview.png"
poor = true
+++

[![](preview.png)](preview.png)

## 情境

我在 [live-dl](https://github.com/jim60105/live-dl) 專案中，想要清除 yt-dlp 在 `--live-from-start` 時會殘留下的碎片檔案  
路徑和檔名被儲存在變數中，中段的 format 和碎片編號是未知的，得以萬用字元匹配，而最後以 part 結尾
<!-- more -->
bash 變數如下

```bash
OUTPUT_BASE='/youtube-dl/tama'
FILENAME='20220412 【歌枠_sing a song】その場リクエストで歌う！鼻声回避なるか...!【Vtuber_久遠たま】 2022-04-14 12_01 (P8OaEF6XDCI)'
```

資料夾狀況

[![](dir.png)](dir.png)

## 正確的匹配方法

```bash
rm "$OUTPUT_BASE/$FILENAME"*.part
```

## 解釋

> <https://stackoverflow.com/a/790245>

* In Unix, programs generally do not interpret wildcards themselves. The shell interprets unquoted wildcards, and replaces each wildcard argument with a list of matching file names. if $archivedir might contain spaces, then rm $archivedir/\*.bz2 might not do what you
* You can disable this process by quoting the wildcard character, using double or single quotes, or a backslash before it. However, that's not what you want here - you do want the wildcard expanded to the list of files that it matches.
* Be careful about writing rm $archivedir/\*.bz2 (without quotes). The word splitting (i.e., breaking the command line up into arguments) happens after $archivedir is substituted. So if $archivedir contains spaces, then you'll get extra arguments that you weren't intending. Say archivedir is /var/archives/monthly/April to June. Then you'll get the equivalent of writing rm /var/archives/monthly/April to June/\*.bz2, which tries to delete the files "/var/archives/monthly/April", "to", and all files matching "June/\*.bz2", which isn't what you want.
