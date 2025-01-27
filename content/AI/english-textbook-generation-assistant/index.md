+++
title = "從一小時到一分鐘：重塑父親的 AI 英文教材產製工作流 —— 「AI 英文教材產生助手」"
description = "見證 AI 工作流如何將一小時的英文教材製作時間縮短為一鍵生成！本文完整揭露筆者如何在 Coze 平台上實作自動化教材產製工作流，並分享實際應用成效與技術實現細節。"
date = "2025-01-27T23:14:42.442Z"
updated = "2025-01-27T23:14:43.178Z"

[taxonomies]
licenses = [ "GFDL 1.3" ]
tags = [ "AI" ]

[extra]
banner = "preview.png"
withAI = "本篇文章透過「[筆韻智匠 Quill Sage🖋️✨](https://www.coze.com/s/Zs8k6GASu/)」和 Claude 3.5 Sonnet 聯合創作"

  [extra.preview]
  withAI = true
  url = "https://civitai.com/images/54269254"
+++
## ChatGPT 🤖 幫我產生一份英文教材

在探索 AI 應用的過程中，前段時間我發現了一個值得優化的日常工作流程。

> 老爸的英文教材
>
> ---
> {{ youtube(id="RveajhHL7Q4") }}

我爸每天會使用 **ChatGPT** 為我兩個就讀建中的弟弟製作英文教材。他每天都會發一篇在我們家的 Messenger 群組裡，他已經做了一整個系列。

深入了解後，我發現我爸每天會花費{{ cr(body="約 50 分鐘")}}製作這些教材，大部分時間用於與 ChatGPT 互動，以產生所需的文章內容並確保格式一致。

50 分鐘！  
這是一個相當可觀的時間，尤其是在他每天都重複進行的情況之下 😮

作為 AI 應用開發者，我認為這是一個很適合通過 AI workflow 來自動化的需求案例。因此，我開發了「英文教材產生助手 (English Textbook Generation Assistant)」 Coze bot ，{{cg(body="目標是將我爸的需求轉成工作流，實現高度自動化。")}}

在接下來的章節中，我會介紹這個 AI 助手的核心功能、Workflow 設計和技術選擇，以及實際應用效果。這個案例展示了日常任務的自動化，也為 AI 在教育領域的應用提供了一個範例。我希望能展示 AI 在提升日常工作效率方面的潛力，並激發更多人思考如何在自己的領域中應用 AI 技術。

<!-- more -->

## 英文教材產生助手 English textbook generation assistant

> {{ image(url="coze.png", alt="Coze store screenshot") }}
> 英文教材產生助手 - Coze AI Agent
>
> ---
> <https://www.coze.com/s/Zs8U1oerD/>

<aside>

{{ image(url="logo.png", alt="Logo of English textbook generation assistant") }}
</aside>

**它能夠根據給定的單字和概念自動產生英文課文。這篇課文包含了目標單字，並能巧妙地融入指定的主題或概念。** 課文設計以對話的形式呈現，確保內容生動有趣，易於理解和記憶。**另一個主要功能是中文翻譯。** AI 助手會為產生的英文課文提供逐句對照的中文翻譯。這種對照形式有助於學習者理解英文句子的結構和意義。

這個工具的一大特點是其靈活性。**使用者可以根據自己的需求自定義單字列表和要傳達的概念。** 如果使用者沒有特定要求，AI 助手會自動從高中 7000 單隨機選取 20 個單字，並確保單字的難度分佈均衡。教師可以根據需求產生不同主題的課文，以滿足不同的教學需求。

除了課文，**AI 助手還會產生單字解釋和例句**，幫助學習者更好地理解每個單字的意思。

最終成品的形式也值得一提。**除了文本形式的教材外，AI 助手還能產生 TTS (文字轉語音) 音檔。** 這個音檔能夠幫助學習者提高聽力技能，文本和音檔的結合為學習者提供了全方位的學習體驗。

AI 英文教材產生助手通過自動化和個性化，提高了英語教材的製作效率。它節省了教育工作者的時間，也為學習者提供了高品質、多樣化的學習資源。在下一章中，我將深入探討這個 AI 助手的技術實現過程，讓大家了解它是如何運作的。

## 揭秘 AI 教材生成的六步曲

在開發 AI 英文教材產生助手時，我設計了一個六步驟的工作流程，以確保能自動化的產生高品質的教材。

### 輸入處理

{{ image(url="1.png", alt="輸入處理") }}

首先，系統接收使用者的輸入。使用者可以提供特定的單字列表和文章主題。如果使用者沒有提供，系統會自動從預設的高中 7000 單字庫中隨機選取 20 個單字。

### 單字解釋

{{ image(url="2.png", alt="單字解釋") }}

在這一步驟中，我選擇使用 Gemini 模型。Gemini 1.5 Flash 在處理跟「語言、翻譯」相關的任務上非常出色，能夠快速產生正確的單字解釋和例句。這個模型真的是又快又便宜，非常適合這個任務。

### 英文課文

{{ image(url="3.png", alt="英文課文") }}

這是整個流程中最關鍵的步驟，我選擇了 Claude 3.5 Sonnet 模型。Claude 在文章產生跟脈絡理解方面表現優異，能夠根據給定的單字和主題創作出連貫、有趣的課文。它的創意寫作能力使得產生的內容更加生動有趣。

### 中文翻譯

{{ image(url="4.png", alt="中文翻譯") }}

課文產生後，我再次使用 Gemini 1.5 Flash 模型進行翻譯。Gemini 的翻譯能力強大，能夠準確捕捉原文的細微語義，提供很棒的逐句中文翻譯。在每個不同的任務使用不同的 AI 模型，充分發揮各個模型的優勢，以獲得最佳的性價比。

### 內容整合

{{ image(url="5.png", alt="內容整合") }}

最後，將前面產生的所有內容 (單字解釋、英文課文、中文翻譯) 整合到一個固定格式的文字檔中，讓每次產生的教材格式統一。

### TTS 音檔

{{ image(url="6.png", alt="TTS 音檔") }}

這是一個附加功能，我會使用 TTS (文字轉語音) 技術，將英文課文轉換為音檔。我利用了微軟免費提供的 Edge TTS 服務來達成這個任務。

在實作這個流程時遇到了一個小小的地雷，那就是微軟的 Edge TTS 服務有時會發生 Timeout。{{cr(body="Coze 的文件明寫了 Plugin Timeout 時間是 3 分鐘，但我實際運行時發現在 60 秒就會 Timeout。")}}這個問題我透過拆分流程來解決，我將 TTS 部份獨立出來為另一個指令，這樣使用者可以單獨運行，而不怕在最後發生 Timeout 時會使整個流程失敗。

**所有的 LLM 提示詞都公開在我的 [GitHub](https://github.com/jim60105/prompt/tree/master/english-textbook-generation-assistant) 上，歡迎大家參考。**

## 成果展示

以下是 AI 英文教材產生助手生成的一份教材：

<audio controls preload="auto" style="width: 100%">
  <source src="audio.mp3" type="audio/mpeg">
  Your browser does not support the audio element.
</audio>

<details>
<summary>點擊展開教材全文</summary>

As the first rays of dawn kissed the horizon, Sarah and Mark stood hand in hand, ready to wed. Their journey to this moment had been filled with unexpected twists and turns. "Remember when we had to postpone because of that ridiculous bug infestation?" Sarah chuckled, her eyes twinkling with mirth. Mark nodded, grinning. "How could I forget? The exterminator said it was roughly the worst case he'd seen in years." Their wedding planner, Lisa, approached with a tick in her step, her clipboard clutched tightly. "We need to implement the final touches now," she advised, her voice tinged with urgency. "The flower arrangements are your top priority." Mark's brow furrowed as he glanced at the sound equipment. "But what about the audio system? Isn't that equally important?" Lisa sighed, her expression a mix of patience and exasperation. "We can't discriminate. Each activity has its respective importance, but we must focus on what guests will notice first."

Suddenly, a shout arose from the pavilion, cutting through the morning air. "The ice sculpture is melting too fast!" Lisa's assistant cried out, panic evident in his voice. Sarah's face fell, her excitement momentarily dampened. "Oh no, all that conservation effort for the intricate design..." she murmured, her voice trailing off. Mark squeezed her hand reassuringly. "Don't worry, love. It's just a liquid state of our solid love," he quipped, earning a playful shove from his bride-to-be. Despite the setback, they couldn't help but laugh, the sound of their joy echoing across the venue. Lisa, ever the professional, quickly dispatched her team to handle the situation, her calm demeanor a stark contrast to the frenzied activity around them.

As guests began to arrive, filling the air with excited chatter, the couple retreated to their respective dressing rooms for final preparations. Sarah opened her book of vows, her hands shaking slightly as she reviewed the words she'd penned. Her maid of honor, noticing her friend's nervous disorder, approached and said softly, "Your words are beautiful and credible, Sarah. Don't let anxiety endanger this moment." She gently squeezed Sarah's shoulder, offering silent support. Meanwhile, in the adjacent room, Mark adjusted his tie for the umpteenth time, glancing at his groomsmen with a mix of excitement and trepidation. "Remember, guys, no embarrassing stories during the toast," he warned, only half-jokingly. "My followers on social media will never let me live it down!" The laughter that followed eased the tension, reminding them all that amidst the chaos of wedding preparations, their friendship remained a steadfast anchor.

As the ceremony drew near, Sarah and Mark took a moment to center themselves. They reflected on the journey that had brought them to this point - the challenges they'd overcome, the love they'd nurtured, and the future they were about to build together. Outside, the venue hummed with anticipation, a testament to the careful planning and hard work of countless individuals. From the meticulously arranged flowers to the perfectly tuned sound system, every detail had been thoughtfully implemented. As they prepared to step out and greet their guests, Sarah and Mark shared a quiet moment, their hearts beating in unison. "Ready to start our forever?" Mark asked, his voice soft with emotion. Sarah nodded, her eyes shining with unshed tears of joy. "With you? Always," she replied. And with that, they stepped out into the sunlight, ready to embrace their new life together, surrounded by the love and support of their family and friends.

---

以下是一句英文一句中文的故事翻譯。

---

As the first rays of dawn kissed the horizon, Sarah and Mark stood hand in hand, ready to wed.  
當第一縷曙光親吻地平線時，莎拉和馬克手牽手站著，準備結婚。

Their journey to this moment had been filled with unexpected twists and turns.  
他們走到這一刻的旅程充滿了意想不到的曲折。

"Remember when we had to postpone because of that ridiculous bug infestation?" Sarah chuckled, her eyes twinkling with mirth.  
「還記得我們因為那場荒謬的蟲害而不得不延期嗎？」莎拉咯咯地笑著，眼睛閃爍著歡樂的光芒。

Mark nodded, grinning.  
馬克點點頭，咧嘴一笑。

"How could I forget? The exterminator said it was roughly the worst case he'd seen in years."  
「怎麼可能忘記？滅蟲員說這大約是他幾年來見過最糟糕的案例。」

Their wedding planner, Lisa, approached with a tick in her step, her clipboard clutched tightly.  
他們的婚禮策劃師麗莎快步走來，緊緊地握著她的剪貼板。

"We need to implement the final touches now," she advised, her voice tinged with urgency.  
「我們現在需要完成最後的收尾工作。」她建議道，語氣中帶著一絲急迫。

"The flower arrangements are your top priority."  
「花卉佈置是你的首要任務。」

Mark's brow furrowed as he glanced at the sound equipment.  
馬克皺起眉頭，望向音響設備。

"But what about the audio system? Isn't that equally important?"  
「但音響系統呢？那不是同樣重要嗎？」

Lisa sighed, her expression a mix of patience and exasperation.  
麗莎嘆了口氣，表情混合著耐心和惱怒。

"We can't discriminate. Each activity has its respective importance, but we must focus on what guests will notice first."  
「我們不能歧視。每個活動都有其各自的重要性，但我們必須專注於客人最先注意到的東西。」

Suddenly, a shout arose from the pavilion, cutting through the morning air.  
突然，一聲喊叫從涼亭傳來，劃破了清晨的空氣。

"The ice sculpture is melting too fast!" Lisa's assistant cried out, panic evident in his voice.  
「冰雕融化得太快了！」麗莎的助理驚呼道，語氣中充滿恐慌。

Sarah's face fell, her excitement momentarily dampened.  
莎拉的臉垮了下來，她的興奮情緒瞬間減弱。

"Oh no, all that conservation effort for the intricate design..." she murmured, her voice trailing off.  
「哦，不，為了這個精緻的設計，我們付出了那麼多努力……」她喃喃自語，聲音漸漸消失。

Mark squeezed her hand reassuringly.  
馬克安撫地握住她的手。

"Don't worry, love. It's just a liquid state of our solid love," he quipped, earning a playful shove from his bride-to-be.  
「別擔心，親愛的。這只是我們堅固愛情的液態形式。」他開玩笑地說，換來未婚妻的嬉戲推搡。

Despite the setback, they couldn't help but laugh, the sound of their joy echoing across the venue.  
儘管遭遇了挫折，他們還是忍不住笑了起來，他們的歡笑聲在整個場地迴盪。

Lisa, ever the professional, quickly dispatched her team to handle the situation, her calm demeanor a stark contrast to the frenzied activity around them.  
麗莎，一如既往地專業，迅速派遣她的團隊處理這個問題，她鎮定的態度與周圍的狂熱活動形成鮮明對比。

As guests began to arrive, filling the air with excited chatter, the couple retreated to their respective dressing rooms for final preparations.  
當賓客們開始陸續抵達，興奮的交談聲充滿了空氣，這對新人退回到各自的更衣室進行最後的準備。

Sarah opened her book of vows, her hands shaking slightly as she reviewed the words she'd penned.  
莎拉打開她的誓言本，手微微顫抖，仔細閱讀著她寫下的文字。

Her maid of honor, noticing her friend's nervous disorder, approached and said softly, "Your words are beautiful and credible, Sarah. Don't let anxiety endanger this moment."  
她的伴娘注意到她朋友的緊張狀態，走上前去，輕聲說道：「莎拉，你的話語很美，也很可信。不要讓焦慮危及這個時刻。」

She gently squeezed Sarah's shoulder, offering silent support.  
她輕輕地握住莎拉的肩膀，默默地支持著她。

Meanwhile, in the adjacent room, Mark adjusted his tie for the umpteenth time, glancing at his groomsmen with a mix of excitement and trepidation.  
同時，在隔壁房間，馬克第 N 次調整領帶，帶著興奮和忐忑的神情望向他的伴郎們。

"Remember, guys, no embarrassing stories during the toast," he warned, only half-jokingly.  
「記住，夥計們，在致詞時不要說任何令人尷尬的故事。」他警告道，只不過是半開玩笑。

"My followers on social media will never let me live it down!"  
「我的社交媒體粉絲永遠不會讓我忘記！」

The laughter that followed eased the tension, reminding them all that amidst the chaos of wedding preparations, their friendship remained a steadfast anchor.  
隨後的笑聲緩解了緊張，提醒他們所有人，在婚禮準備的混亂中，他們的友誼仍然是堅定的錨。

As the ceremony drew near, Sarah and Mark took a moment to center themselves.  
隨著婚禮儀式即將開始，莎拉和馬克花了一點時間讓自己平靜下來。

They reflected on the journey that had brought them to this point - the challenges they'd overcome, the love they'd nurtured, and the future they were about to build together.  
他們回顧了讓他們走到這一步的旅程——他們克服的挑戰、他們培養的愛以及他們即將共同創造的未來。

Outside, the venue hummed with anticipation, a testament to the careful planning and hard work of countless individuals.  
在外面，場地充滿了期待，這是無數人精心策劃和辛勤工作的證明。

From the meticulously arranged flowers to the perfectly tuned sound system, every detail had been thoughtfully implemented.  
從精心佈置的花卉到完美調諧的音響系統，每個細節都經過精心設計。

As they prepared to step out and greet their guests, Sarah and Mark shared a quiet moment, their hearts beating in unison.  
當他們準備走出去迎接賓客時，莎拉和馬克分享了一個安靜的時刻，他們的內心同步跳動。

"Ready to start our forever?" Mark asked, his voice soft with emotion.  
「準備好開始我們的永遠了嗎？」馬克問道，聲音中帶著情感。

Sarah nodded, her eyes shining with unshed tears of joy.  
莎拉點點頭，眼中閃爍著未流出的喜悅淚水。

"With you? Always," she replied.  
「和你在一起？永遠。」她回答道。

And with that, they stepped out into the sunlight, ready to embrace their new life together, surrounded by the love and support of their family and friends.  
就這樣，他們走進陽光中，準備擁抱他們共同的新生活，周圍是家人和朋友的愛與支持。

---

以下是各單字用法介紹。

---

[kiss]  
To touch with the lips as a sign of affection, greeting, or respect.  
用嘴唇觸碰作為表示愛意、問候或尊敬的表示。

[例句]  
The boy kissed his mother goodbye.  
男孩吻別了他的母親。

[book]  
A set of written or printed pages bound together and containing written or printed matter.  
一組裝訂在一起的書寫或印刷頁面，其中包含書寫或印刷的內容。

[例句]  
I am reading a book about history.  
我正在閱讀一本關於歷史的書。

[bug]  
A small insect, especially one that is harmful or annoying.  
一種小型昆蟲，尤其是一種有害或討厭的昆蟲。

[例句]  
There are many bugs in the garden.  
花園裡有很多蟲子。

[dawn]  
The first appearance of light in the sky after night.  
夜晚過後天空中出現的第一縷曙光。

[例句]  
We woke up at dawn.  
我們在黎明時分醒來。

[wed]  
To marry.  
結婚。

[例句]  
They were wed in a beautiful ceremony.  
他們在一個美麗的儀式中舉行了婚禮。

[liquid]  
A substance that flows freely, such as water or oil.  
一種可以自由流動的物質，例如水或油。

[例句]  
Water is a liquid.  
水是一種液體。

[follower]  
A person who supports or admires another person or a cause.  
支持或欽佩某人或某事業的人。

[例句]  
The politician has many followers.  
這位政治家有許多追隨者。

[postponement]  
The act of delaying something until a later time.  
將某事推遲到以後的時間的行為。

[例句]  
The meeting was postponed due to the weather.  
會議因天氣原因而延期。

[activity]  
Something that a person does or is involved in.  
一個人做或參與的事情。

[例句]  
There are many activities for children at the park.  
公園裡有許多適合兒童的活動。

[disorder]  
A state of confusion, untidiness, or lack of organization.  
混亂、不整潔或缺乏組織的狀態。

[例句]  
The room was in a state of disorder.  
房間處於混亂狀態。

[endanger]  
To put someone or something at risk of harm or danger.  
使某人或某事物處於受到傷害或危險的風險之中。

[例句]  
The fire endangered the lives of the people in the building.  
火災危及了大樓裡人們的生命。

[roughly]  
Approximately or nearly.  
大約或幾乎。

[例句]  
The trip took roughly three hours.  
這趟旅行大約花了三個小時。

[tick]  
A small, blood-sucking insect.  
一種小型吸血昆蟲。

[例句]  
The dog had a tick on its ear.  
這隻狗的耳朵上有一隻壁蝨。

[shove]  
To push someone or something forcefully.  
用力推動某人或某物。

[例句]  
He shoved his way through the crowd.  
他推開人群前進。

[priority]  
Something that is more important than other things.  
比其他事物更重要的事情。

[例句]  
Safety is our top priority.  
安全是我們的首要任務。

[discriminate]  
To treat a person or group differently from another person or group in an unfair way.  
以不公平的方式差別待遇某人或某群體。

[例句]  
It is illegal to discriminate against people on the basis of their race.  
根據種族歧視他人是非法的。

[credible]  
Believable or trustworthy.  
可信的或值得信賴的。

[例句]  
The witness gave a credible account of the accident.  
證人對事故作出了可信的陳述。

[conservation]  
The protection of natural resources.  
對自然資源的保護。

[例句]  
Conservation is important for the environment.  
保護環境很重要。

[respective]  
Belonging or relating to each of the people or things mentioned.  
屬於或關於所提及的每個人或事物。

[例句]  
The students went to their respective classrooms.  
學生們去了各自的教室。

[implement]  
To put something into effect or action.  
將某事付諸實施或行動。

[例句]  
The government will implement new policies to improve the economy.  
政府將實施新政策以改善經濟。

</details>

## AI 助手的實戰成效

在實際應用中，AI 英文教材生成助手展現了令人滿意的效果。我爸使用這個工具後，教材製作的時間從原本的 50 分鐘大幅縮短。現在他能將更多的精力放在教材設計跟內容創作上，而不必花費大量時間與 ChatGPT 互動。

想想看，日常生活中還有哪些方面可以透過 AI 來自動化呢？**關鍵在於識別那些重複性高、有規律性，且適合 AI 參與其中的任務**，這些通常是以 AI 自動化的好選擇。

如果你也有學習英文的需求，不妨親自試試這個工具。簡單的按幾下按鈕，幾分鐘後，你就能獲得一份包含單字解釋、英文課文、中文翻譯和音檔的完整教材。這個工具非常適合教師、家長、學生使用。

技術創新確實能顯著提升我們的生活品質。AI 英文教材生成助手只是眾多可能性中的一個例子。它展示了我如何利用 AI 工作流來解決實際問題，提高效率並創造價值。鼓勵大家以創新的視角看待周圍的事物，思考如何將 AI 技術應用到自己的生活中。
