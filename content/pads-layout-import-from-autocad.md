+++
title = "PADS LAYOUT 複雜板框繪製 - 從AUTOCAD導入"
description = "PADS LAYOUT 複雜板框繪製 - 從AUTOCAD導入"
date = 2013-10-09T00:50:00.004Z
updated = 2020-11-24T14:56:53.456Z
draft = false
aliases = ["/2013/10/pads-layout-autocad.html"]

[taxonomies]
tags = []

[extra]
banner = "http://4.bp.blogspot.com/-tRv_moNThgc/UlScjBC_yLI/AAAAAAAAAtg/qMs0ti0UVic/s640/%E4%BD%BF%E7%94%A8%E8%AA%AA%E6%98%8E.jpg"
+++
這是教學文兼說明文，免得將來自己忘記 \_(-ω-\`\_)⌒)\_  
  
使用的工具:  
<http://tinyurl.com/l6h3uvc>  
  
部分工具取自:<http://blog.yam.com/jack60455867/article/20814657>  
若作者覺得不妥我會拿掉  
  
\----------------------------  
  
再開始前  
先講解一下PADS的巨集使用方法PADS的巨集副檔名為".mcr"  
一張圖解決  
  
  
[![](http://4.bp.blogspot.com/-tRv_moNThgc/UlScjBC_yLI/AAAAAAAAAtg/qMs0ti0UVic/s640/%E4%BD%BF%E7%94%A8%E8%AA%AA%E6%98%8E.jpg)](http://4.bp.blogspot.com/-tRv%5FmoNThgc/UlScjBC%5FyLI/AAAAAAAAAtg/qMs0ti0UVic/s1600/%E4%BD%BF%E7%94%A8%E8%AA%AA%E6%98%8E.jpg)

  
還有附件裡有兩個EXCEL的增益集  
實測EXCEL 2010可用  
增益集添加方法，一樣一張圖  

[![](http://4.bp.blogspot.com/-yyOOyv42f3w/UlSd8u0DShI/AAAAAAAAAts/rPaLFdFflTI/s640/2013-10-09+08+03+33.png)](http://4.bp.blogspot.com/-yyOOyv42f3w/UlSd8u0DShI/AAAAAAAAAts/rPaLFdFflTI/s1600/2013-10-09+08+03+33.png)

瀏覽後選擇剛剛的兩個增益集即可  
  
\------------------------------  
  
OK，開始(ง •̀\_•́)ง  
  
1.PADS開啟新檔後載入"開新檔案後動作.mcr"並執行  
  
2.開啟AutoCAD欲繪製的板框原稿  
在此以附件中的"Drawing1.dxf"為例  
  
3.Excel開啟新檔後選擇到剛剛的增益集((記得要啟用  

[![](http://2.bp.blogspot.com/-ecaYzR-zcuU/UlSf89OhQGI/AAAAAAAAAt4/GrH_KHaJFjE/s640/2013-10-09+08+13+54.png)](http://2.bp.blogspot.com/-ecaYzR-zcuU/UlSf89OhQGI/AAAAAAAAAt4/GrH%5FKHaJFjE/s1600/2013-10-09+08+13+54.png)

  
4.左邊選上面的選項，按啟動  

[![](http://4.bp.blogspot.com/-TtYHYjjQuL0/UlSgThR5GUI/AAAAAAAAAuA/AF_52oCBtvM/s1600/2013-10-09+08+15+14.png)](http://4.bp.blogspot.com/-TtYHYjjQuL0/UlSgThR5GUI/AAAAAAAAAuA/AF%5F52oCBtvM/s1600/2013-10-09+08+15+14.png)

  
5.出現"取點待命中..."後回到剛剛開的AutoCAD檔案，將"外板框"的所有"端點"點選一遍。請從原點開始，這張圖的左下角  
((外板框即圖中高亮標示處  

[![](http://1.bp.blogspot.com/-MBmDq9ZKoHg/UlShKj4lvrI/AAAAAAAAAuM/Ta88Eg1qzmY/s640/2013-10-09+08+18+00.png)](http://1.bp.blogspot.com/-MBmDq9ZKoHg/UlShKj4lvrI/AAAAAAAAAuM/Ta88Eg1qzmY/s1600/2013-10-09+08+18+00.png)
  
  
6.最後記得回到開始位置，形成一個完整的封閉圈，建議固定從左上或右上開始避免混淆  
  
7.結束後按Esc，接著回到Excel  
  
8.你會發現獲得了一長串的座標值，但是他從一兩千起跳，明明我UCS已經移到了板框左下角的說..  

[![](http://2.bp.blogspot.com/-aOGTAf85dOI/UlSiwe1KztI/AAAAAAAAAuY/xVz8wKm50SA/s640/2013-10-09+08+26+25.png)](http://2.bp.blogspot.com/-aOGTAf85dOI/UlSiwe1KztI/AAAAAAAAAuY/xVz8wKm50SA/s1600/2013-10-09+08+26+25.png)

  
9.這時要找到原點，我是從左下角開始的，所以第一個座標就是真正的原點  
((若是你是從左上角開始，那就是倒數第二個座標，以此類推  
  
10.運用Excel運算功能得出正確座標值  

[![](http://3.bp.blogspot.com/-A0FcZX5U2pE/UlSjoxwGWaI/AAAAAAAAAug/rrc0_GrHWRI/s640/2013-10-09+08+29+55.png)](http://3.bp.blogspot.com/-A0FcZX5U2pE/UlSjoxwGWaI/AAAAAAAAAug/rrc0%5FGrHWRI/s1600/2013-10-09+08+29+55.png)
  
  
至此我們已獲得了所有端點的座標

  
11.將座標值複製，貼上至"...\\複雜板框繪製\\版框繪製程式\\Position.txt"內，並儲存

[![](http://4.bp.blogspot.com/-Hl_yoWgdD8Q/UlSkd8hub5I/AAAAAAAAAuo/MoMu6BZoSJY/s640/2013-10-09+08+33+43.png)](http://4.bp.blogspot.com/-Hl%5FyoWgdD8Q/UlSkd8hub5I/AAAAAAAAAuo/MoMu6BZoSJY/s1600/2013-10-09+08+33+43.png)
  
  
12.執行"...\\複雜板框繪製\\版框繪製程式\\RWFiles.exe"，出現此視窗即為成功

[![](http://3.bp.blogspot.com/-1YB3N3H75Po/UlSkypPRGRI/AAAAAAAAAuw/tiKAX8TIUmk/s640/2013-10-09+08+34+51.png)](http://3.bp.blogspot.com/-1YB3N3H75Po/UlSkypPRGRI/AAAAAAAAAuw/tiKAX8TIUmk/s1600/2013-10-09+08+34+51.png)
  
  
13.切換到步驟1.的PADS，載入並執行""...\\複雜板框繪製\\版框繪製程式\\Out.mcr"

  
14.板框GET ｷｬ━━━━(ﾟ∀ﾟ)━━━━!!

[![](http://3.bp.blogspot.com/-rVnr3khtOqc/UlSlbirofaI/AAAAAAAAAu4/VJSC7z5pygg/s640/2013-10-09+08+37+21.png)](http://3.bp.blogspot.com/-rVnr3khtOqc/UlSlbirofaI/AAAAAAAAAu4/VJSC7z5pygg/s1600/2013-10-09+08+37+21.png)

  
15.接下來輪到板框挖洞，請看到步驟3.\~  
這次改成選擇中間的洞，共有四個洞但是一次只能做一個  
((我從左邊開始

[![](http://1.bp.blogspot.com/-7tewoM6qQa8/UlSmM3vqrPI/AAAAAAAAAvA/2EeNDmRie_s/s640/2013-10-09+08+40+40.png)](http://1.bp.blogspot.com/-7tewoM6qQa8/UlSmM3vqrPI/AAAAAAAAAvA/2EeNDmRie%5Fs/s1600/2013-10-09+08+40+40.png)

  
16.還記得剛剛取得的原點座標嗎?把它拿出來再用一次

算出真實座標

[![](http://1.bp.blogspot.com/-gW_mdZfP8j4/UlSm25nRi6I/AAAAAAAAAvI/5meu4Fi37Jw/s640/2013-10-09+08+43+04.png)](http://1.bp.blogspot.com/-gW%5FmdZfP8j4/UlSm25nRi6I/AAAAAAAAAvI/5meu4Fi37Jw/s1600/2013-10-09+08+43+04.png)

  
17.接下來是類似的步驟，不過改成使用"...\\複雜板框繪製\\版框挖洞繪製程式\\Position.txt"這邊

  
18.執行"...\\複雜板框繪製\\版框挖洞繪製程式\\RWFiles.exe"

  
19.切換到已經有板框的PADS，載入並執行""...\\複雜板框繪製\\版框挖洞繪製程式\\Out.mcr"

  
20.洞洞就挖好了\~\~

  
不過還沒完請把其他的洞也挖一挖吧(・∀・)

\-------------------------------------------------------

全部挖完後你就會得到成品:

[![](http://4.bp.blogspot.com/-QG462Akd1tA/UlSn6o3WtBI/AAAAAAAAAvU/LPdH-ZzZgaI/s640/2013-10-09+08+48+04.png)](http://4.bp.blogspot.com/-QG462Akd1tA/UlSn6o3WtBI/AAAAAAAAAvU/LPdH-ZzZgaI/s1600/2013-10-09+08+48+04.png)

應該要跟我一樣除非你偷懶了(´-ω-\`)

  
\--

\\ 教 程 結 束 /

  
\-----

相信沒人想要，不過轉載請註明原網址:<http://jim60105.blogspot.tw/2013/10/pads-layout-autocad.html>