+++
title = "以 Google 試算表作為簡易資料庫 (下) —— 資料庫的讀取"
description = "以 Google 試算表作為簡易資料庫 (下) —— 資料庫的讀取"
date = 2015-06-26T07:22:00.005Z
updated = 2015-06-26T07:22:00.005Z
draft = false
aliases = [ "/2015/06/google-database2.html" ]

[taxonomies]
tags = [
  "Database",
  "Google",
  "Google Apps Script",
  "JavaScript",
  "Excel/SpreadSheets"
]
licenses = [ "GFDL 1.3" ]

[extra]
featured = true
+++

## 續篇

此篇為系列文之 (下) 篇，建議各位先閱讀 (上) 篇:

[以 Google 試算表作為簡易資料庫 (上) —— 資料庫的建立及寫入](@/Database/google-spreadsheets-as-database/index.md)

這篇我會簡化一些上篇做過的步驟，不會一一截圖示範，請適當的舉一反三\~
<!-- more -->
**※圖片若不易閱讀請點擊放大※**

## 步驟大綱

1. 在 Google Drive 上建立一個程式
2. 程式內容可以對特定 Google 試算表文件進行存取
3. 架一個網頁，對應用程式 GET 送資料
4. 應用程式接收到資料後，將資料顯示在網頁上

## 正文

首先把資料庫準備好

我已經輸入了一些資料，其中 6 號是故意跳過的，模擬 "座號不連續" 及 "查詢座號" 不存在的狀況

[![](2015-06-26%2015%2006%2035.JPG)](2015-06-26%2015%2006%2035.JPG)

新建一個 Google Apps Script，並新增空白專案

[![](2015-06-26%2013%2013%2048.JPG)](2015-06-26%2013%2013%2048.JPG)

將專案命名，並改成 doGet (e)

[![](2015-06-26%2013%2015%2000.JPG)](2015-06-26%2013%2015%2000.JPG)

從上篇建立的程式碼上半部直接複製過來改\~  
參數只需要留一個 number

[![](2015-06-26%2013%2016%2038.JPG)](2015-06-26%2013%2016%2038.JPG)

接著是程式主體: 比對到正確資訊後將資料輸出  
此處我採用循序比對法，簡單明瞭  
若資料量過多，請自己選用適合的演算法  
※注意陣列是 zero-based，跟行數不同※

[![](2015-06-26%2013%2034%2006.JPG)](2015-06-26%2013%2034%2006.JPG)

加上沒找到的狀況  
並且直接把 return 塞進迴圈

[![](2015-06-26%2013%2041%2003.JPG)](2015-06-26%2013%2041%2003.JPG)

建立 debug 用程式碼

也是可以跳過這步直接發佈啦\~

[![](2015-06-26%2013%2035%2000.JPG)](2015-06-26%2013%2035%2000.JPG)

debug 程式碼內容照舊，只是參數只送一個座號  
紅框處兩個按鍵都可以執行

[![](2015-06-26%2014%2021%2026.JPG)](2015-06-26%2014%2021%2026.JPG)

執行結束後來看看結果，打開執行紀錄查看

[![](2015-06-26%2014%2021%2052.JPG)](2015-06-26%2014%2021%2052.JPG)

紅框處顯示有正確抓到資料\~\~  
一次成功爽･\*:.｡..｡.:\*･゜ヽ (´∀｀) 人 (´∀｀ ) ノ･゜ﾟ･\*:.｡..｡.:\*

[![](2015-06-26%2014%2022%2013.JPG)](2015-06-26%2014%2022%2013.JPG)

改成不存在的 6，有成功顯示錯誤資訊

[![](2015-06-26%2014%2022%2050.JPG)](2015-06-26%2014%2022%2050.JPG)

將程式部屬為網路應用程式，詳細步驟看[上篇](@/Database/google-spreadsheets-as-database/index.md)

[![](2015-06-26%2014%2024%2004.JPG)](2015-06-26%2014%2024%2004.JPG)

一樣以 W3School 的 javascript 測試平台模擬架好的網站

如果自己有 Server 請舉一反三

打開 : <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>

範例網頁我就不一一講解了，簡而言之也是一個 "會透過 jquery 送 GET Request 的網頁"。

範例網頁如下，請全選複製覆蓋左半邊，將裡面的網址換成你的，再按提交代碼:

```html
<!DOCTYPE html>
<html>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    NO: <input type="text" id="numberInput"><br><br>
    <input type="button" value="查詢" onclick="Search()">
    <script type="text/javascript">
        function Search(){
            $.get("※你的網址放這邊※", {
                        "number": document.getElementById("numberInput").value
                    },
                    function (data) {
                        document.write("--------------------------<br>");
                        document.write("No.,Name,Score <br>"+data+"<br>");
                        document.write("--------------------------<br>");
                    });
        }
    </script>
</body>
</html>
```

接下來試試看查詢吧\~

[![](2015-06-26%2014%2029%2054.JPG)](2015-06-26%2014%2029%2054.JPG)

成功\~

[![](2015-06-26%2014%2030%2008.JPG)](2015-06-26%2014%2030%2008.JPG)

輸入不存在的 6

[![](2015-06-26%2014%2030%2032.JPG)](2015-06-26%2014%2030%2032.JPG)

有顯示出不存在信息\~

[![](2015-06-26%2014%2030%2041.JPG)](2015-06-26%2014%2030%2041.JPG)

## 結尾

至此系列文結束。

與其說資料庫相關，這兩篇文章主要是在演示簡易的 Google Apps Script 的使用方式。Google 的[使用說明書](https://developers.google.com/apps-script/reference/spreadsheet/)寫的淺顯易懂，不過對入門者來講還是略深。其餘資料庫的運用請各位自己舉一反三吧! 希望這兩篇文章對各位有所幫助\~

※上篇請戳: [以 Google 試算表作為簡易資料庫 (上) —— 資料庫的建立及寫入](@/Database/google-spreadsheets-as-database/index.md)※
