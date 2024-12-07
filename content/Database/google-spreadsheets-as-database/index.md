+++
title = "以 Google 試算表作為簡易資料庫 (上) —— 資料庫的建立及寫入"
description = "以 Google 試算表作為簡易資料庫 (上) —— 資料庫的建立及寫入"
date = 2015-06-14T21:12:00.003Z
updated = 2015-06-14T21:12:00.003Z
draft = false
aliases = [ "/2015/06/google-database.html" ]

[extra]
hot = true

[taxonomies]
tags = [
  "Database",
  "Google",
  "Google Apps Script",
  "JavaScript",
  "Excel/SpreadSheets"
]
licenses = [ "GFDL 1.3" ]
+++

## 前言

此篇文章主要是利用 Google Apps Script 配合 Google 試算表，製作簡易資料庫。在開始前，請確認你擁有以下能力 :

1. 看得懂英文
2. 有基礎 Javascript 能力，最好是略懂 jQuery
3. 有閱讀 API 說明書能力
4. 有一個 Google 帳號
5. 有一個調教好的 HTTP Server (可選)

我將分成上下篇進行講解:

上: [資料庫的建立及寫入 (本篇)](@/Database/google-spreadsheets-as-database/index.md)

下: [資料庫的讀取](@/Database/google-spreadsheets-as-database2/index.md)
<!-- more -->
**※圖片若不易閱讀請點擊放大※**

## 工具

1. Google : <https://www.google.com/>
2. W3School : <http://www.w3school.com.cn/jsref/index.asp>
3. jQuery API : <http://api.jquery.com/>
4. W3School 的 javascript 測試平台 : <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>
5. Google Script API : <https://developers.google.com/apps-script/reference/spreadsheet/>

## 步驟大綱

1. 在 Google Drive 上建立一個程式
2. 程式內容可以對特定 Google 試算表文件存取並寫入
3. 架一個網頁，對應用程式 GET 送資料
4. 應用程式接收到資料後，將資料寫入到 Google 試算表

## Google Script 簡介

Google Script 基本上是一個以 JavaScript 為底的語言。詳細教學請參考[說明文件](https://developers.google.com/apps-script/)。此篇教學主要使用到 "建立網路應用程式" 的部分，也請參考此處[說明文件](https://developers.google.com/apps-script/guides/web)。

## 正文

首先，將你的 Google 雲端連結 Google Apps Script  
請進入你的 Google 雲端帳號，在左上角選擇 "新增"→"更多"→"+ 連結更多應用程式"

※此處一個帳號只需要做一次，因為我已經做過了，所以選項已經出現，請見諒※

[![](2015-06-16%2005%2029%2057.png)](2015-06-16%2005%2029%2057.png)

在右上角搜尋 "Google Apps Script"，點下 "+ 連接"  
※此處因為我已做過，所以顯示的是評分，請見諒※

[![](2015-06-16%2005%2031%2024.png)](2015-06-16%2005%2031%2024.png)

連接後，回到這裡應該就會有選項出來，新增一個 Google Apps Script

[![](2015-06-16%2005%2031%2055.png)](2015-06-16%2005%2031%2055.png)

選擇新增空白專案

[![](2015-06-16%2005%2033%2059.png)](2015-06-16%2005%2033%2059.png)

接著把 `myfunction()` 改成 `doGet(e)`

此處必須注意，**不能使用其他名稱**

依照[說明文件](https://developers.google.com/apps-script/guides/web)，應用程式收到 GET Request 以後會執行 `doGet(e)` 函數，`e` 為 GET 網址帶入參數，也就是我們送的資料

[![](2015-06-16%2005%2034%2052.png)](2015-06-16%2005%2034%2052.png)

點擊左上角給專案命名

[![](2015-06-16%2005%2035%2049.png)](2015-06-16%2005%2035%2049.png)

命名後他就會進行儲存，之後打 code 也要養成常常 Ctrl+S 的習慣\~

[![](2015-06-16%2005%2036%2024.png)](2015-06-16%2005%2036%2024.png)

接著建立一個試算表，位置不限，如果是在別人的帳號內記得開啟共用權限

[![](2015-06-16%2005%2037%2037.png)](2015-06-16%2005%2037%2037.png)

將試算表打開，網址列紅框處就是此試算表的 ID，請記錄下來

此處示範為 :  
`1t_8cv-b9W94LJItGzNfcsAsO-BfWvyqelr686seQt_Y`  
(每個文件都有不同的 ID，此文件事後不會保留)

[![](2015-06-16%2005%2038%2044.png)](2015-06-16%2005%2038%2044.png)

在這裡給我們的資料庫輸入三個欄位

我就用萬年例子: 學號分數來舉例拉\~\~\~

[![](2015-06-16%2005%2041%2013.png)](2015-06-16%2005%2041%2013.png)

---

回到 Script 這邊

首先我要對送進來的參數進行解析

e 的[內容格式](https://developers.google.com/apps-script/guides/web#url%5Fparameters)如下:

```
{
  "parameter": {
    "number": "25252",
    "name": "NicoNicoNi",
    "score": "20"
  },..(省略)..
}
```

將 e 裡面的 number、name、score 塞進新變數

[![](2015-06-16%2005%2046%2040.png)](2015-06-16%2005%2046%2040.png)

接著要取得試算表

請打開 [Google Script API](https://developers.google.com/apps-script/reference/spreadsheet/) 進行查詢

新變數取得試算表、頁籤、最後一行行數

[![](2015-06-16%2005%2053%2008.png)](2015-06-16%2005%2053%2008.png)

寫入資料的部分

[![](2015-06-16%2006%2000%2016.png)](2015-06-16%2006%2000%2016.png)

在最後結束時傳回 `true`  
這裡可以傳回任何文字，換句話說，可以讀取試算表內容後回傳。

[![](2015-06-16%2006%2001%2032.png)](2015-06-16%2006%2001%2032.png)

上圖之完整程式碼:

```javascript
//輸入學生成績
function doGet(e) {
  var params = e.parameter;
  var number = params.number;
  var name = params.name;
  var score = params.score;
  
  //將Sheet指定為"資料庫"試算表     SpreadSheet = 試算表
  var SpreadSheet = SpreadsheetApp.openById("1t_8cv-b9W94LJItGzNfcsAsO-BfWvyqelr686seQt_Y");
  //取得頁籤:"工作表1"              Sheet = 頁籤
  var Sheet = SpreadSheet.getSheetByName("工作表1");
  //取得有資料的最後一行的"行數"(目的要在最後一行插入新資料)
  var LastRow = Sheet.getLastRow();
  
  //--開始寫入資料--
  
  //在最後一行的下一行寫入資料
  //首先寫入number
  Sheet.getRange(LastRow+1, 1).setValue(number); //意即最後一行的加一行處，左邊數來第一格，寫入數值為number
  //寫入name
  Sheet.getRange(LastRow+1, 2).setValue(name); //意即最後一行的加一行處，左邊數來第二格，寫入數值為name
  //寫入score
  Sheet.getRange(LastRow+1, 3).setValue(score); //意即最後一行的加一行處，左邊數來第三格，寫入數值為score
  
  //寫入結束後傳回true
  return ContentService.createTextOutput(true);
}
```

新增一個指令碼檔案，debug 使用

[![](2015-06-16%2006%2001%2056.png)](2015-06-16%2006%2001%2056.png)

先嘗試對剛剛寫的 `doGet()` 進行 debug

參數如圖

[![](2015-06-16%2006%2008%2051.png)](2015-06-16%2006%2008%2051.png)

debug 程式碼:

```javascript
function debug() {
  var Result = doGet(
    {
      "parameter": {
        "number": "25252",
        "name": "NicoNicoNi",
        "score": "20"
      }
    }
  );
  Logger.log("Result: %s" , Result);
}
```

按小蟲圖案即可進行 debug，注意函式名稱要選對

[![](2015-06-16%2006%2009%2040.png)](2015-06-16%2006%2009%2040.png)

第一次執行時會要求授權，必須同意

[![](2015-06-16%2006%2010%2047.png)](2015-06-16%2006%2010%2047.png)

一次執行成功ﾟ･\*:.｡..｡.:\*･゜ヽ (´∀｀) 人 (´∀｀ ) ノ･゜ﾟ･\*:.｡..｡.:\*

[![](2015-06-16%2006%2011%2031.png)](2015-06-16%2006%2011%2031.png)

"檢視"→"執行紀錄" 這裡可以看剛剛的執行狀況  
debug 時請善用

[![](2015-06-16%2006%2013%2007.png)](2015-06-16%2006%2013%2007.png)

像這裡可以看到執行時間

做大型 Project 需要優化可以參考

[![](2015-06-16%2006%2013%2025.png)](2015-06-16%2006%2013%2025.png)

確認程式沒問題以後來進行發布吧

也可以發布後再從外側做 debug，不過這樣 Error 訊息會不太容易看

"檔案"→"管理版本"

[![](2015-06-16%2006%2012%2014.png)](2015-06-16%2006%2012%2014.png)

左邊可以打版本備忘  
版本號只能往上累加

點擊 "儲存新版本" 以後會多出一條，請記住你發布的版本號

[![](2015-06-16%2006%2014%2007.png)](2015-06-16%2006%2014%2007.png)

"發布"→"部屬為網路應用程式"

[![](2015-06-16%2006%2015%2011.png)](2015-06-16%2006%2015%2011.png)

此處請選擇 "剛剛的版本號"、執行者是 "我"、**權限授權給 "匿名"**

[![](2015-06-16%2006%2015%2041.png)](2015-06-16%2006%2015%2041.png)

這樣就完成發布拉\~

將他給的網址複製起來，等下有用

此範例為:  
`https://script.google.com/macros/s/AKfycbwmm2iXGgsvqULpxwprsHuI_r4HjPjLq4RJwnfQBXsJPQ3VcgY/exec`

[![](2015-06-16%2006%2018%2028.png)](2015-06-16%2006%2018%2028.png)

---

至此你的應用程式已經建立，接下來我們來試試在外部使用吧\~

此處我們以 W3School 的 javascript 測試平台模擬架好的網站

如果自己有 Server 請舉一反三

打開: <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>

範例網頁我就不一一講解了，簡而言之就是一個 "會透過 jquery 送 GET Request 的網頁"。

範例網頁如下，請全選複製覆蓋左半邊，將裡面的網址換成你的，再按提交代碼:

```html
<html>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    NO: <input type="text" id="numberInput"><br><br>
    Name: <input type="text" id="nameInput"><br><br>
    Score: <input type="text" id="scoreInput"><br><br><br>
    <input type="button" value="送出" onclick="SendScore()">
    <script type="text/javascript">
        function SendScore(){
            $.get("※你的網址放這邊※", {
                        "number": document.getElementById("numberInput").value,
                        "name": document.getElementById("nameInput").value,
                        "score": document.getElementById("scoreInput").value
                    },
                    function (data) {
                        document.write("--------------------------");
                        document.write("Result = "+data);
                        document.write("--------------------------");
                    });
        }
    </script>
</body>
</html>
```

試著輸入內容以後案 "送出"  
注意左邊！

[![](2015-06-16%2006%2042%2007.png)](2015-06-16%2006%2042%2007.png)

成功拉\~

右邊 Result 後面的 `true` 就是返回值。可以改成傳其他文字，再捕捉進行解析。

[![](2015-06-16%2006%2043%2030.png)](2015-06-16%2006%2043%2030.png)

## 結尾

至此教學上篇結束，已經簡單的做出了一個可以對 Google 試算表送資料的網站了。下篇預計會示範資料的讀取，不過跟這篇內容其實大同小異。將 Script 內容改為讀取並回傳就行，有興趣的人可以自己試試。

※下篇請戳: [以 Google 試算表作為簡易資料庫 (下) —— 資料庫的讀取](@/Database/google-spreadsheets-as-database2/index.md)※
