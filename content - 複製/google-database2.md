+++
title = "以Google試算表作為簡易資料庫(下)--資料庫的讀取"
description = "以Google試算表作為簡易資料庫(下)--資料庫的讀取"
date = 2015-06-26T07:22:00.005Z
updated = 2021-01-30T16:25:02.776Z
draft = false
aliases = [ "/2015/06/google-database2.html" ]

[taxonomies]
tags = [ "Google Apps Script" ]

[extra]
banner = "https://1.bp.blogspot.com/-_RISMX-7gQE/VYz6jQe5ELI/AAAAAAAAKxo/sClrGuKdqmY/s1600/2015-06-26%2B15%2B06%2B35.JPG"
+++
## 續篇

此篇為系列文之(下)篇，建議各位先閱讀(上)篇:

[以Google試算表作為簡易資料庫(上)--資料庫的建立及寫入](/2015/06/google-database.html)

  
這篇我會簡化一些上篇做過的步驟，不會一一截圖示範，請適當的舉一反三\~

  
**※圖片若不易閱讀請點擊放大※**

  
## 步驟大綱

1. 在Google Drive上建立一個程式
2. 程式內容可以對特定Google試算表文件進行存取
3. 架一個網頁，對應用程式GET送資料
4. 應用程式接收到資料後，將資料顯示在網頁上
  
  
## 正文

首先把資料庫準備好

我已經輸入了一些資料，其中6號是故意跳過的，模擬"座號不連續"及"查詢座號"不存在的狀況

  
[![](https://1.bp.blogspot.com/-_RISMX-7gQE/VYz6jQe5ELI/AAAAAAAAKxo/sClrGuKdqmY/s1600/2015-06-26%2B15%2B06%2B35.JPG)](http://1.bp.blogspot.com/-%5FRISMX-7gQE/VYz6jQe5ELI/AAAAAAAAKxo/sClrGuKdqmY/s1600/2015-06-26%2B15%2B06%2B35.JPG)

  
新建一個Google Apps Script，並新增空白專案

  
[![](https://2.bp.blogspot.com/-d4VBq4_81NI/VYz0woXQBbI/AAAAAAAAKvs/W9kARed8Zuo/s1600/2015-06-26%2B13%2B13%2B48.JPG)](http://2.bp.blogspot.com/-d4VBq4%5F81NI/VYz0woXQBbI/AAAAAAAAKvs/W9kARed8Zuo/s1600/2015-06-26%2B13%2B13%2B48.JPG)

  
將專案命名，並改成doGet(e)  
  
  
[![](https://3.bp.blogspot.com/-wwgN2RAzhLc/VYz0ws6fFqI/AAAAAAAAKvo/WvWHb6mB3nc/s1600/2015-06-26%2B13%2B15%2B00.JPG)](http://3.bp.blogspot.com/-wwgN2RAzhLc/VYz0ws6fFqI/AAAAAAAAKvo/WvWHb6mB3nc/s1600/2015-06-26%2B13%2B15%2B00.JPG)

  
從上篇建立的程式碼上半部直接複製過來改\~  
參數只需要留一個number  
  
  
[![](https://3.bp.blogspot.com/-DgR112gaRnE/VYz0wnaYqPI/AAAAAAAAKvw/v-p6hE4BXbk/s1600/2015-06-26%2B13%2B16%2B38.JPG)](http://3.bp.blogspot.com/-DgR112gaRnE/VYz0wnaYqPI/AAAAAAAAKvw/v-p6hE4BXbk/s1600/2015-06-26%2B13%2B16%2B38.JPG)

  
接著是程式主體:比對到正確資訊後將資料輸出  
此處我採用循序比對法，簡單明瞭  
若資料量過多，請自己選用適合的演算法  
※注意陣列是zero-based，跟行數不同※  
  
  
[![](https://4.bp.blogspot.com/-G6-fTBr4log/VYz0zcf1TqI/AAAAAAAAKwE/wToeQENvZKw/s1600/2015-06-26%2B13%2B34%2B06.JPG)](http://4.bp.blogspot.com/-G6-fTBr4log/VYz0zcf1TqI/AAAAAAAAKwE/wToeQENvZKw/s1600/2015-06-26%2B13%2B34%2B06.JPG)

  
加上沒找到的狀況  
並且直接把return塞進迴圈  
  
  
[![](https://2.bp.blogspot.com/-D_dJyDsXWwo/VYz00dU_1pI/AAAAAAAAKwQ/SyIiexhnICc/s1600/2015-06-26%2B13%2B41%2B03.JPG)](http://2.bp.blogspot.com/-D%5FdJyDsXWwo/VYz00dU%5F1pI/AAAAAAAAKwQ/SyIiexhnICc/s1600/2015-06-26%2B13%2B41%2B03.JPG)

  
建立debug用程式碼

也是可以跳過這部直接發布啦\~

  
[![](https://4.bp.blogspot.com/-eChbd08Ud4o/VYz0zW2WKZI/AAAAAAAAKwA/UXG9aQMiYoc/s1600/2015-06-26%2B13%2B35%2B00.JPG)](http://4.bp.blogspot.com/-eChbd08Ud4o/VYz0zW2WKZI/AAAAAAAAKwA/UXG9aQMiYoc/s1600/2015-06-26%2B13%2B35%2B00.JPG)

  
debug程式碼內容照舊，只是參數只送一個座號  
紅框處兩個按鍵都可以執行  
  
  
[![](https://4.bp.blogspot.com/-FH9BD0iLS0o/VYz00q0O6kI/AAAAAAAAKwU/LPqNFZjuQk8/s1600/2015-06-26%2B14%2B21%2B26.JPG)](http://4.bp.blogspot.com/-FH9BD0iLS0o/VYz00q0O6kI/AAAAAAAAKwU/LPqNFZjuQk8/s1600/2015-06-26%2B14%2B21%2B26.JPG)

  
執行結束後來看看結果，打開執行紀錄查看  
  
  
[![](https://4.bp.blogspot.com/-zX6xU1eSkq4/VYz006JswlI/AAAAAAAAKwY/hwsQ2cLLALY/s1600/2015-06-26%2B14%2B21%2B52.JPG)](http://4.bp.blogspot.com/-zX6xU1eSkq4/VYz006JswlI/AAAAAAAAKwY/hwsQ2cLLALY/s1600/2015-06-26%2B14%2B21%2B52.JPG)

  
紅框處顯示有正確抓到資料\~\~  
一次成功爽･\*:.｡..｡.:\*･゜ヽ( ´∀｀)人(´∀｀ )ノ･゜ﾟ･\*:.｡..｡.:\*  
  
  
[![](https://2.bp.blogspot.com/-St5x9Nnokts/VYz02denyqI/AAAAAAAAKwo/NLDgEs3tol8/s1600/2015-06-26%2B14%2B22%2B13.JPG)](http://2.bp.blogspot.com/-St5x9Nnokts/VYz02denyqI/AAAAAAAAKwo/NLDgEs3tol8/s1600/2015-06-26%2B14%2B22%2B13.JPG)

  
改成不存在的6，有成功顯示錯誤資訊  
  
  
[![](https://4.bp.blogspot.com/-dlEKdguUgdc/VYz03CmgqYI/AAAAAAAAKw0/oZXPLxPrxb8/s1600/2015-06-26%2B14%2B22%2B50.JPG)](http://4.bp.blogspot.com/-dlEKdguUgdc/VYz03CmgqYI/AAAAAAAAKw0/oZXPLxPrxb8/s1600/2015-06-26%2B14%2B22%2B50.JPG)

  
將程式部屬為網路應用程式，詳細步驟看[上篇](/2015/06/google-database.html)  
  
  
[![](https://1.bp.blogspot.com/-KXEynBKRDSA/VYz02vs0fMI/AAAAAAAAKws/9VcpeMNXEOw/s1600/2015-06-26%2B14%2B24%2B04.JPG)](http://1.bp.blogspot.com/-KXEynBKRDSA/VYz02vs0fMI/AAAAAAAAKws/9VcpeMNXEOw/s1600/2015-06-26%2B14%2B24%2B04.JPG)
  
  
一樣以W3School的javascript測試平台模擬架好的網站

如果自己有Server請舉一反三
  
  
打開 : <http://www.w3school.com.cn/tiy/t.asp?f=jseg%5Fformattext>

  
範例網頁我就不一一講解了，簡而言之也是一個"會透過jquery送GET Request的網頁"。  
  
範例網頁如下，請全選複製覆蓋左半邊，將裡面的網址換成你的，再按提交代碼:  

<!DOCTYPE html>
    

    NO:   

  
接下來試試看查詢吧\~
  
  
[![](https://4.bp.blogspot.com/-aZOdbOeCIZQ/VYz093qEx_I/AAAAAAAAKxA/w40_dtDflXw/s1600/2015-06-26%2B14%2B29%2B54.JPG)](http://4.bp.blogspot.com/-aZOdbOeCIZQ/VYz093qEx%5FI/AAAAAAAAKxA/w40%5FdtDflXw/s1600/2015-06-26%2B14%2B29%2B54.JPG)

  
成功\~  
  
  
[![](https://3.bp.blogspot.com/-ypO2vWFVrCM/VYz0995nOOI/AAAAAAAAKxE/MYuvgS05KSU/s1600/2015-06-26%2B14%2B30%2B08.JPG)](http://3.bp.blogspot.com/-ypO2vWFVrCM/VYz0995nOOI/AAAAAAAAKxE/MYuvgS05KSU/s1600/2015-06-26%2B14%2B30%2B08.JPG)

  
輸入不存在的6  
  
  
[![](https://3.bp.blogspot.com/-lMMp2lCy5u0/VYz0-mBuKjI/AAAAAAAAKxI/UzJK1ZP4mCo/s1600/2015-06-26%2B14%2B30%2B32.JPG)](http://3.bp.blogspot.com/-lMMp2lCy5u0/VYz0-mBuKjI/AAAAAAAAKxI/UzJK1ZP4mCo/s1600/2015-06-26%2B14%2B30%2B32.JPG)

  
有顯示出不存在信息\~  
  
  
[![](https://2.bp.blogspot.com/-seG0lNYwe4w/VYz1BOLgfDI/AAAAAAAAKxY/VkCq7cjT6gU/s1600/2015-06-26%2B14%2B30%2B41.JPG)](http://2.bp.blogspot.com/-seG0lNYwe4w/VYz1BOLgfDI/AAAAAAAAKxY/VkCq7cjT6gU/s1600/2015-06-26%2B14%2B30%2B41.JPG)
  
  
## 結尾

至此系列文結束。

與其說資料庫相關，這兩篇文章主要是在演示簡易的Google Apps Script的使用方式。Google的[使用說明書](https://developers.google.com/apps-script/reference/spreadsheet/)寫的淺顯易懂，不過對入門者來講還是略深。其餘資料庫的運用請各位自己舉一反三吧!希望這兩篇文章對各位有所幫助\~

  
※上篇請戳: [以Google試算表作為簡易資料庫(上)--資料庫的建立及寫入](/2015/06/google-database.html)※