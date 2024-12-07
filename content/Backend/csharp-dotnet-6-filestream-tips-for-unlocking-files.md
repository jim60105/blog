+++
title = "簡單易懂！C# .NET 6 FileStream 解鎖檔案的技巧分享"
description = "簡單易懂！C# .NET 6 FileStream 解鎖檔案的技巧分享"
date = 2023-02-28T22:22:00.001Z
updated = 2023-02-28T22:22:07.825Z
draft = true
aliases = [ ]
extra = { }

[taxonomies]
tags = [ ".NET Core", "C#" ]
licenses = [ "GFDL 1.3" ]
+++

> System.IO.IOException: The process cannot access the file 'ooxx' because it is being used by another process.

這篇文章講解 C# .NET 6 如何在 Linux 上訪問被其它執行序鎖定的檔案。

不像Windows是獨占鎖，Linux上是諮詢鎖，兩個平台對於鎖定的設計概念不一樣，Linux生態系的程式可能會在不太必要時鎖住檔案，讓其它程式自行決定是否遵守鎖定。

.NET Core把這個鎖定轉譯為C#的時候，把它轉成了獨佔鎖定，導致FileStream在打開檔案時報錯。
