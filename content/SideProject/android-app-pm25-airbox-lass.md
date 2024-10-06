+++
title = "[Android App] PM2.5 環境空氣顯示器 ( Airbox 、 LASS 等民間Maker站點 )"
description = ""
date = 2019-01-09T07:57:00.009Z
updated = 2020-11-24T14:56:53.458Z
draft = false
aliases = ["/2019/01/android-app-pm25-airbox-lass.html"]

[taxonomies]
tags = ["Android"]
+++
[![](https://3.bp.blogspot.com/-ZHW_AFOFLAU/XDWtXA-gUvI/AAAAAAAAL8A/d2iC9j9j9yw4fKau0TGkHtc7TebRAwztgCLcBGAs/s2340/lung.png)](https://3.bp.blogspot.com/-ZHW%5FAFOFLAU/XDWtXA-gUvI/AAAAAAAAL8A/d2iC9j9j9yw4fKau0TGkHtc7TebRAwztgCLcBGAs/s1600/lung.png) 

  
###  前言

2018年底寫了一個手機App，專門用來看我家窗外的PM測站。功能很簡單，用App Inventor兩天就寫完了。  
後來想想，既然參與了LASS這個開源專案，就讓我也做點貢獻吧！  
就把App補齊了一些地圖功能，還有針對不知道測站名稱的一般使用者做了一些調整。  
整個操作流程算是流暢，如果有哪裡不順歡迎反映。  
  
###  Google Play

<https://play.google.com/store/apps/details?id=appinventor.ai%5Fjim60105.air>

  
###  個人雲端 (apk和AppInventor原始碼)

<https://cloud.maki0419.com/s/oGLSLqn7b6aaWZa>  
  
###  功能描述

1. 串接 「PM2.5 開放資料入口網站」 之自造社群資料做顯示
2. 選擇測站的方式
   1. 由GPS、地址定位，尋找臨近測站 (適合一般使用者)
   2. 從device\_id清單選擇 (適合擁有測站的Maker夥伴)
   3. 從地圖選擇 (適合看周邊測站位置)
3. 在地圖上呈現所有測站
   1. Marker依照空氣狀況改變顏色顯示
  
###  截圖

| [![](https://1.bp.blogspot.com/-NJXI7hQEKrc/XuXoB3jNfGI/AAAAAAAAMe0/iwZR1L86XLMdIoZKYhaiONWjfTn_pwe3wCK4BGAsYHg/s2340/1.jpg)](https://1.bp.blogspot.com/-NJXI7hQEKrc/XuXoB3jNfGI/AAAAAAAAMe0/iwZR1L86XLMdIoZKYhaiONWjfTn%5Fpwe3wCK4BGAsYHg/s2340/1.jpg)   | [![](https://1.bp.blogspot.com/-sNYo1l_ft8g/XuXoCaq63RI/AAAAAAAAMe4/AJIxjzQ_clQ-a9t--qOdlheOC3c6srGawCK4BGAsYHg/s2340/2.jpg)](https://1.bp.blogspot.com/-sNYo1l%5Fft8g/XuXoCaq63RI/AAAAAAAAMe4/AJIxjzQ%5FclQ-a9t--qOdlheOC3c6srGawCK4BGAsYHg/s2340/2.jpg)   |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![](https://1.bp.blogspot.com/-Nlab_G-xJv8/XuXoCvG0KDI/AAAAAAAAMe8/t7Sqe6f7bzIP_VrLULJ5tUyxWFXWuM6PQCK4BGAsYHg/s2340/3.jpg)](https://1.bp.blogspot.com/-Nlab%5FG-xJv8/XuXoCvG0KDI/AAAAAAAAMe8/t7Sqe6f7bzIP%5FVrLULJ5tUyxWFXWuM6PQCK4BGAsYHg/s2340/3.jpg) | [![](https://1.bp.blogspot.com/-sHXRcmTLGWo/XuXoDNd2pdI/AAAAAAAAMfA/rEffNBelFV4lyMYk_hQE0kflLm18KIsQgCK4BGAsYHg/s2340/4.jpg)](https://1.bp.blogspot.com/-sHXRcmTLGWo/XuXoDNd2pdI/AAAAAAAAMfA/rEffNBelFV4lyMYk%5FhQE0kflLm18KIsQgCK4BGAsYHg/s2340/4.jpg)     |
| [![](https://1.bp.blogspot.com/-Ng91hX8W5Mw/XuXoDgZKcNI/AAAAAAAAMfE/wHJKNTJd0JkC0GqY-Z7R34G_S56G1xHIACK4BGAsYHg/s2340/5.jpg)](https://1.bp.blogspot.com/-Ng91hX8W5Mw/XuXoDgZKcNI/AAAAAAAAMfE/wHJKNTJd0JkC0GqY-Z7R34G%5FS56G1xHIACK4BGAsYHg/s2340/5.jpg)   | [![](https://1.bp.blogspot.com/-3LO6kEDKcwo/XuXoD0_0EsI/AAAAAAAAMfI/MiR2Ks_SyH0vmH_rGsNp9F0hDuOXngBWACK4BGAsYHg/s2340/6.jpg)](https://1.bp.blogspot.com/-3LO6kEDKcwo/XuXoD0%5F0EsI/AAAAAAAAMfI/MiR2Ks%5FSyH0vmH%5FrGsNp9F0hDuOXngBWACK4BGAsYHg/s2340/6.jpg) |

###  後記

在撰寫的時候遇到一個值得一提的瓶頸: Map載入時的效能問題  
  
要在Map上繪製三千多個Marker，會整個hang住，應用程式無回應數秒後Android會關閉他。

App Inventer沒有類似Multi-thread之類的功能可以使用，非常頭痛。

苦思一晚，最後使用Clock Interval搭配List shift的方式做呼叫，變相達成一樣的效果。

  
[![](https://1.bp.blogspot.com/-FFIULlGdnYU/XDWr5r8mo2I/AAAAAAAAL7w/Hyy4rJBwXN0gmgb9BcxyKZjxMy9OeZRiwCLcBGAs/s400/%25E6%2588%2591%25E5%25A4%25AA%25E4%25BB%2596%25E5%25AA%25BD%25E7%259A%2584%25E6%25A9%259F%25E6%2599%25BA%25E4%25BA%2586.png)](https://1.bp.blogspot.com/-FFIULlGdnYU/XDWr5r8mo2I/AAAAAAAAL7w/Hyy4rJBwXN0gmgb9BcxyKZjxMy9OeZRiwCLcBGAs/s1600/%25E6%2588%2591%25E5%25A4%25AA%25E4%25BB%2596%25E5%25AA%25BD%25E7%259A%2584%25E6%25A9%259F%25E6%2599%25BA%25E4%25BA%2586.png) 

  
現在這App完全融入我的日常生活。

早起看一次，決定今天要不要呼吸......我是說戴口罩；回家看一次，看看要不要關窗開清淨機。

搭配上畢業專題做的空氣品質通報，我感覺整個人都變乾淨了。

  
[![](https://2.bp.blogspot.com/-aorWIxCiGYA/XDWsunXHPgI/AAAAAAAAL74/AKg-jIiDMhklpRPfcBa8LfHJJ8TViKavQCLcBGAs/s400/%25E4%25B8%25A6%25E6%25B2%2592%25E6%259C%2589%2B%25E5%259F%25BA%25E5%25BE%25B72.jpg)](https://2.bp.blogspot.com/-aorWIxCiGYA/XDWsunXHPgI/AAAAAAAAL74/AKg-jIiDMhklpRPfcBa8LfHJJ8TViKavQCLcBGAs/s1600/%25E4%25B8%25A6%25E6%25B2%2592%25E6%259C%2589%2B%25E5%259F%25BA%25E5%25BE%25B72.jpg) 