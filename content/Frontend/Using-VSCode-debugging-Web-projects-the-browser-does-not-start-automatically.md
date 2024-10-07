+++
title = "VSCode偵錯Web專案時，瀏覧器未自動啟動"
description = "VSCode偵錯Web專案時，瀏覧器未自動啟動"
date = 2022-04-21T21:25:00.002Z
updated = 2022-04-21T21:25:22.605Z
draft = false
aliases = [
  "/2022/04/Using-VSCode-debugging-Web-projects-the-browser-does-not-start-automatically.html"
]

[taxonomies]
tags = [ ]

[extra]
banner = "https://img.maki0419.com/blog/preview/VSCode-debugging-Web-projects.jpg"
+++
[![](https://img.maki0419.com/blog/preview/VSCode-debugging-Web-projects.jpg)](https://img.maki0419.com/blog/preview/VSCode-debugging-Web-projects.jpg)

## 本文

今天在公司開了新的.NET 6 MVC專案設定好Program.cs，加上套件Serilog(Logger)、EF Core 6(ORM)後，發現VSCode無法在F5後自動開啟瀏覧器。針對這個問題查了一下，查出問題是源自我設定LogLevel時把Microsoft覆寫為了 Fatal。

根據[這篇文件](https://code.visualstudio.com/updates/v1%5F32#%5Fautomatically-open-a-uri-when-debugging-a-server-program)，VSCode在執行`launch.json`設定的工作時，`serverReadyAction`區塊會在檢測Debug Console輸出了指定文字後，抓出指定的字串(網址)後塞入預設瀏覧器。這就是問題所在，`Now listening on: http....`是在Information層級輸出，而我把它調成Fatal後就沒了。這導致VSCode無從抓出網址，也不知道WebServer已就緒。

"serverReadyAction": {
     "action": "openExternally",
     "pattern": "\\bNow listening on:\\s+(https?://\\S+)"
},

解決方法也很簡單，把Microsoft的LogLevel調成Information以上就行了，確保Debug Console會輸出指定的字串。

appsettings.json

{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Debug",
      "Override": {
        "Microsoft": "Information",  ← Check This
        "Microsoft.AspNetCore": "Warning"
      }
    },
    "Enrich": [ "FromLogContext" ],
    "WriteTo": [
      {
        "Name": "Console",
...

## 參考資料

* <https://code.visualstudio.com/updates/v1%5F32#%5Fautomatically-open-a-uri-when-debugging-a-server-program>
* <https://github.com/OmniSharp/omnisharp-vscode/blob/master/debugger-launchjson.md#starting-a-web-browser>