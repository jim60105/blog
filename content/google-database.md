+++
title = "以Google試算表作為簡易資料庫(上)--資料庫的建立及寫入"
description = ""
date = 2015-06-14T21:12:00.003Z
updated = 2021-01-30T16:24:47.045Z
draft = false
aliases = ["/2015/06/google-database.html"]

[taxonomies]
tags = ["Google Apps Script"]
+++
## 前言

此篇文章主要是利用Google Apps Script配合Google試算表，製作簡易資料庫。在開始前，請確認你擁有以下能力 :  
1. 看得懂英文
2. 有基礎Javascript能力，最好是略懂jQuery
3. 有閱讀API說明書能力
4. 有一個Google帳號
5. 有一個調教好的HTTP Server(可選)

我將分成上下篇進行講解:

上:[資料庫的建立及寫入(本篇)](/2015/06/google-database.html)

下:[資料庫的讀取](/2015/06/google-database2.html)

  
**※圖片若不易閱讀請點擊放大※**
  
  
## 工具

1. Google : <https://www.google.com/>
2. W3School : <http://www.w3school.com.cn/jsref/index.asp>
3. jQuery API : <http://api.jquery.com/>
4. W3School的javascript測試平台 : <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>
5. Google Script API : <https://developers.google.com/apps-script/reference/spreadsheet/>

  
## 步驟大綱

1. 在Google Drive上建立一個程式
2. 程式內容可以對特定Google試算表文件存取並寫入
3. 架一個網頁，對應用程式GET送資料
4. 應用程式接收到資料後，將資料寫入到Google試算表

  
## Google Script簡介

Google Script基本上是一個以JavaScript為底的語言。詳細教學請參考[說明文件](https://developers.google.com/apps-script/)。此篇教學主要使用到"建立網路應用程式"的部分，也請參考此處[說明文件](https://developers.google.com/apps-script/guides/web)。

  
##  正文

首先，將你的Google雲端連結Google Apps Script  
請進入你的Google雲端帳號，在左上角選擇"新增"→"更多"→"+ 連結更多應用程式"  
  
※此處一個帳號只需要做一次，因為我已經做過了，所以選項已經出現，請見諒※  
  
  
[![](https://2.bp.blogspot.com/-cDNcx9gmJ88/VX9XmP94egI/AAAAAAAAKrs/GlTRRMQgG2w/s1600/2015-06-16%2B05%2B29%2B57.png)](http://2.bp.blogspot.com/-cDNcx9gmJ88/VX9XmP94egI/AAAAAAAAKrs/GlTRRMQgG2w/s1600/2015-06-16%2B05%2B29%2B57.png)

  
在右上角搜尋"Google Apps Script"，點下"+ 連接"  
※此處因為我已做過，所以顯示的是評分，請見諒※  
  
  
[![](https://3.bp.blogspot.com/-Hznl-BYT6EA/VX9XmEu3L1I/AAAAAAAAKro/xVGWK8kKWN0/s1600/2015-06-16%2B05%2B31%2B24.png)](http://3.bp.blogspot.com/-Hznl-BYT6EA/VX9XmEu3L1I/AAAAAAAAKro/xVGWK8kKWN0/s1600/2015-06-16%2B05%2B31%2B24.png)

  
連接後，回到這裡應該就會有選項出來，新增一個Google Apps Script  
  
  
[![](https://3.bp.blogspot.com/-GY8McSlpcas/VX9XmFyiMGI/AAAAAAAAKrk/BSvAiaD10LQ/s1600/2015-06-16%2B05%2B31%2B55.png)](http://3.bp.blogspot.com/-GY8McSlpcas/VX9XmFyiMGI/AAAAAAAAKrk/BSvAiaD10LQ/s1600/2015-06-16%2B05%2B31%2B55.png)
  
  
選擇新增空白專案

  
[![](https://1.bp.blogspot.com/-l7N2Yp3eQHU/VX9Xmxqg-9I/AAAAAAAAKr0/_O4EaIwgaS0/s1600/2015-06-16%2B05%2B33%2B59.png)](http://1.bp.blogspot.com/-l7N2Yp3eQHU/VX9Xmxqg-9I/AAAAAAAAKr0/%5FO4EaIwgaS0/s1600/2015-06-16%2B05%2B33%2B59.png)

  
接著把myfunction()改成 doGet(e)

此處必須注意，不能使用其他名稱

  
依照[說明文件](https://developers.google.com/apps-script/guides/web)，應用程式收到GET Request以後會執行doGet(e)函數，"e"為GET網址帶入參數，也就是我們送的資料
  
  
[![](https://2.bp.blogspot.com/-FcIidCpJ7No/VX9XnHrot6I/AAAAAAAAKr4/yJN14BMOgZI/s1600/2015-06-16%2B05%2B34%2B52.png)](http://2.bp.blogspot.com/-FcIidCpJ7No/VX9XnHrot6I/AAAAAAAAKr4/yJN14BMOgZI/s1600/2015-06-16%2B05%2B34%2B52.png)
  
  
點擊左上角給專案命名
  
  
[![](https://3.bp.blogspot.com/-LiIF9uAtw94/VX9XnfbIUCI/AAAAAAAAKsA/gcRunXQ9DOQ/s1600/2015-06-16%2B05%2B35%2B49.png)](http://3.bp.blogspot.com/-LiIF9uAtw94/VX9XnfbIUCI/AAAAAAAAKsA/gcRunXQ9DOQ/s1600/2015-06-16%2B05%2B35%2B49.png)

  
命名後他就會進行儲存，之後打code也要養成常常Ctrl+S的習慣\~
  
  
[![](https://1.bp.blogspot.com/-bne7zSJIhSc/VX9XnuUMpSI/AAAAAAAAKsI/baCbv8t9FR0/s1600/2015-06-16%2B05%2B36%2B24.png)](http://1.bp.blogspot.com/-bne7zSJIhSc/VX9XnuUMpSI/AAAAAAAAKsI/baCbv8t9FR0/s1600/2015-06-16%2B05%2B36%2B24.png)
  
  
接著建立一個試算表，位置不限，如果是在別人的帳號內記得開啟共用權限
  
  
[![](https://1.bp.blogspot.com/-w5RGNKFbFks/VX9XnwJGZNI/AAAAAAAAKsE/Msb12Zj0Wic/s1600/2015-06-16%2B05%2B37%2B37.png)](http://1.bp.blogspot.com/-w5RGNKFbFks/VX9XnwJGZNI/AAAAAAAAKsE/Msb12Zj0Wic/s1600/2015-06-16%2B05%2B37%2B37.png)
  
  
將試算表打開，網址列紅框處就是此試算表的ID，請記錄下來

此處示範為 :   
"1t\_8cv-b9W94LJItGzNfcsAsO-BfWvyqelr686seQt\_Y"  
(每個文件都有不同的ID，此文件事後不會保留)
  
  
[![](https://2.bp.blogspot.com/-gELfKTsURcU/VX9XoUZbHlI/AAAAAAAAKsc/XVDcSdE0Fv8/s1600/2015-06-16%2B05%2B38%2B44.png)](http://2.bp.blogspot.com/-gELfKTsURcU/VX9XoUZbHlI/AAAAAAAAKsc/XVDcSdE0Fv8/s1600/2015-06-16%2B05%2B38%2B44.png)
  
  
在這裡給我們的資料庫輸入三個欄位

我就用萬年例子:學號分數來舉例拉\~\~\~
  
  
[![](https://2.bp.blogspot.com/-qUZwTZj7o0k/VX9XomhhSeI/AAAAAAAAKsY/R1kn2lUwOxs/s1600/2015-06-16%2B05%2B41%2B13.png)](http://2.bp.blogspot.com/-qUZwTZj7o0k/VX9XomhhSeI/AAAAAAAAKsY/R1kn2lUwOxs/s1600/2015-06-16%2B05%2B41%2B13.png)
  
  
\---------------------------分隔線---------------------------

回到Script這邊

首先我要對送進來的參數進行解析

  
e的[內容格式](https://developers.google.com/apps-script/guides/web#url%5Fparameters)如下:

    {
      "parameter": {
        "number": "25252",
        "name": "NicoNicoNi",
        "score": "20"
      },..(省略)..
    }
  
  
將e裡面的number、name、score塞進新變數
  
  
[![](https://1.bp.blogspot.com/-jUjBgXWQ47g/VX9Xoj_H3QI/AAAAAAAAKsg/a2mtz3-Xg4g/s1600/2015-06-16%2B05%2B46%2B40.png)](http://1.bp.blogspot.com/-jUjBgXWQ47g/VX9Xoj%5FH3QI/AAAAAAAAKsg/a2mtz3-Xg4g/s1600/2015-06-16%2B05%2B46%2B40.png)

  
接著要取得試算表

請打開[Google Script API](https://developers.google.com/apps-script/reference/spreadsheet/)進行查詢

新變數取得試算表、頁籤、最後一行行數
  
  
[![](https://3.bp.blogspot.com/-My4KSB-gQww/VX9XpWpMX-I/AAAAAAAAKss/UGKxMuscYmk/s1600/2015-06-16%2B05%2B53%2B08.png)](http://3.bp.blogspot.com/-My4KSB-gQww/VX9XpWpMX-I/AAAAAAAAKss/UGKxMuscYmk/s1600/2015-06-16%2B05%2B53%2B08.png)
  
  
寫入資料的部分
  
  
[![](https://3.bp.blogspot.com/-43CK2itfbkQ/VX9XqJD5QnI/AAAAAAAAKtI/FanlvxHFlFA/s1600/2015-06-16%2B06%2B00%2B16.png)](http://3.bp.blogspot.com/-43CK2itfbkQ/VX9XqJD5QnI/AAAAAAAAKtI/FanlvxHFlFA/s1600/2015-06-16%2B06%2B00%2B16.png)
  
  
在最後結束時傳回true  
這裡可以傳回任何文字，換句話說，可以讀取試算表內容後回傳。
  
  
[![](https://1.bp.blogspot.com/-FQYL4H_PPHk/VX9XqNKzIDI/AAAAAAAAKtA/UTSOp0iQcA0/s1600/2015-06-16%2B06%2B01%2B32.png)](http://1.bp.blogspot.com/-FQYL4H%5FPPHk/VX9XqNKzIDI/AAAAAAAAKtA/UTSOp0iQcA0/s1600/2015-06-16%2B06%2B01%2B32.png)
  
  
上圖之完整程式碼:  
  
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

新增一個指令碼檔案，debug使用
  
  
[![](https://3.bp.blogspot.com/-iPT_wbblf0Y/VX9XqTFUBlI/AAAAAAAAKtE/YCXxPn326tM/s1600/2015-06-16%2B06%2B01%2B56.png)](http://3.bp.blogspot.com/-iPT%5Fwbblf0Y/VX9XqTFUBlI/AAAAAAAAKtE/YCXxPn326tM/s1600/2015-06-16%2B06%2B01%2B56.png)
  
  
先嘗試對剛剛寫的doGet()進行debug

 參數如圖
  
  
[![](https://1.bp.blogspot.com/-LYUVBLzDhWo/VX9Xq6JsCuI/AAAAAAAAKtQ/Hg-snt7I75w/s1600/2015-06-16%2B06%2B08%2B51.png)](http://1.bp.blogspot.com/-LYUVBLzDhWo/VX9Xq6JsCuI/AAAAAAAAKtQ/Hg-snt7I75w/s1600/2015-06-16%2B06%2B08%2B51.png)
  
  
debug程式碼:   

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

按小蟲圖案即可進行debug，注意函式名稱要選對
  
  
[![](https://1.bp.blogspot.com/-S4MNphwhw0Y/VX9XsCsHQRI/AAAAAAAAKuE/3tMam6fBRHU/s1600/2015-06-16%2B06%2B09%2B40.png)](http://1.bp.blogspot.com/-S4MNphwhw0Y/VX9XsCsHQRI/AAAAAAAAKuE/3tMam6fBRHU/s1600/2015-06-16%2B06%2B09%2B40.png)
  
  
第一次執行時會要求授權，必須同意
  
  
[![](https://2.bp.blogspot.com/-hBc9qdus-BY/VX9XrYq0bYI/AAAAAAAAKtk/T84SGqYkPkA/s1600/2015-06-16%2B06%2B10%2B47.png)](http://2.bp.blogspot.com/-hBc9qdus-BY/VX9XrYq0bYI/AAAAAAAAKtk/T84SGqYkPkA/s1600/2015-06-16%2B06%2B10%2B47.png)
  
  
一次執行成功ﾟ･\*:.｡..｡.:\*･゜ヽ( ´∀｀)人(´∀｀ )ノ･゜ﾟ･\*:.｡..｡.:\*
  
  
[![](https://3.bp.blogspot.com/-sL-RHF1O5hs/VX9Xr1m7pqI/AAAAAAAAKto/b_drxxucHxQ/s1600/2015-06-16%2B06%2B11%2B31.png)](http://3.bp.blogspot.com/-sL-RHF1O5hs/VX9Xr1m7pqI/AAAAAAAAKto/b%5FdrxxucHxQ/s1600/2015-06-16%2B06%2B11%2B31.png)
  
  
"檢視"→"執行紀錄" 這裡可以看剛剛的執行狀況  
debug時請善用
  
  
[![](https://3.bp.blogspot.com/-jRTAoO5kmXU/VX9Xs3bXW4I/AAAAAAAAKt4/GGYKPanppZk/s1600/2015-06-16%2B06%2B13%2B07.png)](http://3.bp.blogspot.com/-jRTAoO5kmXU/VX9Xs3bXW4I/AAAAAAAAKt4/GGYKPanppZk/s1600/2015-06-16%2B06%2B13%2B07.png)
  
  
像這裡可以看到執行時間

 做大型Project需要優化可以參考
  
  
[![](https://3.bp.blogspot.com/-d1hwmKKoS8c/VX9XtQNB2XI/AAAAAAAAKuA/IoFtQGoq8I8/s1600/2015-06-16%2B06%2B13%2B25.png)](http://3.bp.blogspot.com/-d1hwmKKoS8c/VX9XtQNB2XI/AAAAAAAAKuA/IoFtQGoq8I8/s1600/2015-06-16%2B06%2B13%2B25.png)
  
  
確認程式沒問題以後來進行發布吧

也可以發布後再從外側做debug，不過這樣Error訊息會不太容易看

"檔案"→"管理版本"
  
  
[![](https://1.bp.blogspot.com/-gk2mqb8VzMM/VX9XsZ7OYtI/AAAAAAAAKts/hPn_4ULGImU/s1600/2015-06-16%2B06%2B12%2B14.png)](http://1.bp.blogspot.com/-gk2mqb8VzMM/VX9XsZ7OYtI/AAAAAAAAKts/hPn%5F4ULGImU/s1600/2015-06-16%2B06%2B12%2B14.png)
  
  
左邊可以打版本備忘  
版本號只能往上累加

點擊"儲存新版本"以後會多出一條，請記住你發布的版本號
  
  
[![](https://3.bp.blogspot.com/-aWR9tXZdSnM/VX9XthMLMJI/AAAAAAAAKuI/eOlTH3sC7Ko/s1600/2015-06-16%2B06%2B14%2B07.png)](http://3.bp.blogspot.com/-aWR9tXZdSnM/VX9XthMLMJI/AAAAAAAAKuI/eOlTH3sC7Ko/s1600/2015-06-16%2B06%2B14%2B07.png)
  
  
"發布"→"部屬為網路應用程式"
  
  
[![](https://4.bp.blogspot.com/-vSGjKRmwyCg/VX9XuATh08I/AAAAAAAAKuM/nHwEFDxguGA/s1600/2015-06-16%2B06%2B15%2B11.png)](http://4.bp.blogspot.com/-vSGjKRmwyCg/VX9XuATh08I/AAAAAAAAKuM/nHwEFDxguGA/s1600/2015-06-16%2B06%2B15%2B11.png)

  
此處請選擇"剛剛的版本號"、執行者是"我"、權限授權給"匿名"
  
  
[![](https://1.bp.blogspot.com/-BVc8L0IuS1M/VX9XuTzot1I/AAAAAAAAKuU/kR7wXjpmh10/s1600/2015-06-16%2B06%2B15%2B41.png)](http://1.bp.blogspot.com/-BVc8L0IuS1M/VX9XuTzot1I/AAAAAAAAKuU/kR7wXjpmh10/s1600/2015-06-16%2B06%2B15%2B41.png)
  
  
這樣就完成發布拉\~

將他給的網址複製起來，等下有用

此範例為:  
"https://script.google.com/macros/s/AKfycbwmm2iXGgsvqULpxwprsHuI\_r4HjPjLq4RJwnfQBXsJPQ3VcgY/exec"
  
  
[![](https://3.bp.blogspot.com/-bGJ3YsiTfoo/VX9XuQmcHzI/AAAAAAAAKuY/efjZ5CkmyHw/s1600/2015-06-16%2B06%2B18%2B28.png)](http://3.bp.blogspot.com/-bGJ3YsiTfoo/VX9XuQmcHzI/AAAAAAAAKuY/efjZ5CkmyHw/s1600/2015-06-16%2B06%2B18%2B28.png)
  
  
\---------------------------分隔線---------------------------

至此你的應用程式已經建立，接下來我們來試試在外部使用吧\~

  
此處我們以W3School的javascript測試平台模擬架好的網站

如果自己有Server請舉一反三
  
  
打開 : <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>

  
範例網頁我就不一一講解了，簡而言之就是一個"會透過jquery送GET Request的網頁"。  
  
 範例網頁如下，請全選複製覆蓋左半邊，將裡面的網址換成你的，再按提交代碼:
    

    NO:   
  

    Name:   
  

    Score:   


試著輸入內容以後案"送出"  
注意左邊！
  
  
[![](https://1.bp.blogspot.com/-gn2vDJOTLPw/VX9XwwwGeLI/AAAAAAAAKu0/xjoiLkhpozo/s1600/2015-06-16%2B06%2B42%2B07.png)](http://1.bp.blogspot.com/-gn2vDJOTLPw/VX9XwwwGeLI/AAAAAAAAKu0/xjoiLkhpozo/s1600/2015-06-16%2B06%2B42%2B07.png)

  
成功拉\~

右邊Result後面的true就是返回值。可以改成傳其他文字，再捕捉進行解析。  
  
  
[![](https://1.bp.blogspot.com/-QyE3tABphn4/VX9Xw2j3r0I/AAAAAAAAKu4/3R2Gi6HB7nI/s1600/2015-06-16%2B06%2B43%2B30.png)](http://1.bp.blogspot.com/-QyE3tABphn4/VX9Xw2j3r0I/AAAAAAAAKu4/3R2Gi6HB7nI/s1600/2015-06-16%2B06%2B43%2B30.png)
  
  
## 結尾

至此教學上篇結束，已經簡單的做出了一個可以對Google試算表送資料的網站了。下篇預計會示範資料的讀取，不過跟這篇內容其實大同小異。將Script內容改為讀取並回傳就行，有興趣的人可以自己試試。

  
※下篇請戳: [以Google試算表作為簡易資料庫(下)--資料庫的讀取](/2015/06/google-database2.html)※