+++
title = "讓 AI 為你優化 AI：我的自動化提示詞工程神器 ——「Automated Prompt Engineering」"
description = "探索 Automated Prompt Engineering 自動化提示詞工程助手。本文深入介紹這個工具如何運用 AI 來優化 AI，大幅提升提示詞品質和效率。了解其核心功能、使用方法和最佳實踐，掌握如何利用自動化技術來優化你的 AI 應用。無論你是 AI 開發新手還是經驗豐富的工程師都能有所收獲"
date = 2024-09-22T18:52:00.011Z
updated = 2024-09-23T13:12:39.573Z
draft = false
aliases = [ "/2024/09/ai-automated-prompt-engineering.html" ]

[taxonomies]
tags = [ "AI" ]
licenses = [ "GFDL 1.3" ]

[extra]
banner = "preview.png"
iscn = "iscn://likecoin-chain/KiZc2G9UmmW17_mYPhEh_CnnS_odvEiojeUuxxumqOc/1"
featured = true

  [extra.comments]
  id = "113187155039935632"
+++
{{ image(url="APE.png", alt="Automated Prompt Engineering") }}

> 本篇文章透過「[筆韻智匠 Quill Sage🖋️✨](https://www.coze.com/s/Zs8k6GASu/)」和 Claude 3.5 Sonnet 聯合創作

## 前言：創造 AI 助手的 AI 助手

在現今的 AI 時代，提示詞工程已成為 AI 應用開發中不可或缺的關鍵環節。身為一個熟悉 AI 助手的開發者兼使用者，我深刻了解一個優質的提示詞 (prompt) 能夠將一個笨 AI 轉變為專業的問題解決專家。在創造了一大堆的 AI 助手之後，我萌生了一個想法：

**該創造一個「創造 AI 助手」的 AI 助手了😀！**

正是基於這個想法，我在 Coze 平台上實作了「自動化提示詞工程」助手。這個助手的核心是基於 Automated Prompt Engineering (APE) 技術，特別採用了 Optimization by PROmpting (OPRO) 流程來反覆優化提示詞。

> Automated Prompt Engineering 自動化提示詞工程
>
> ---
> 👉 <https://www.coze.com/s/Zs8kEec6x/>

在接下來的章節中，我將詳細介紹這個 AI 助手的功能、使用方法，以及一些實用的技巧和最佳實踐。無論你是 AI 開發新手還是經驗豐富的工程師，我相信這篇文章都能讓你有所收獲。讓我們一起探索如何運用自動化技術來進行 AI 提示詞工程。

<!-- more -->

## 什麼是 Automated Prompt Engineering？

**Automated Prompt Engineering (自動化提示詞工程，簡稱 APE) 旨在自動化大型語言模型 (LLM) 提示詞的生成和優化過程。**

在傳統的 Prompt Engineering 中，開發者需要手動設計、測試和優化提示詞，這是一個耗時且常常需要反覆嘗試的過程。APE 的目的就是要簡化並加速這個過程，讓 AI 系統能夠自動找出最有效的提示詞。

**APE 的核心原理是利用不斷疊代來優化 AI**。它通過以下步驟來實現自動化：

1. 初始化：設定任務目標和初始提示詞。
2. 生成回應：使用當前提示詞讓 LLM 生成回應。
3. 評估效果：分析生成的回應，評估其品質和相關性。
4. 優化提示詞：基於評估結果，自動調整和改進提示詞。
5. 疊代：重複上述過程，直到達到滿意的結果。

在 APE 的實踐中，Optimization by PROmpting (以大型語言模型做為優化器，OPRO) 是一種很好的提示詞優化方法。OPRO 策略來自 Google DeepMind 的論文《[Large Language Models as Optimizers](https://arxiv.org/pdf/2309.03409)》，**通過 LLM 分析先前疊代的結果並識別成功模式，從而優化提示詞。**

在這篇部落格中我僅簡短的提及它的工作原理，若讀者對 APE 技術和 OPRO 流程感興趣，我強烈推薦閱讀下面這篇非常精彩的文章。這篇文章詳細講解了 APE 和 OPRO 流程，對理解本助手的運作原理非常有幫助。

> 自動提示詞工程解放LLM潛力，APE讓LLM探索更廣闊的提示詞設計空間 | T客邦
>
> ---
> [https://www.techbang.com/posts/118175-auto-prompt-engineering-guide](https://www.techbang.com/posts/118175-auto-prompt-engineering-guide)

## 「Automated Prompt Engineering 自動化提示詞工程」助手

我的「Automated Prompt Engineering 自動化提示詞工程」助手以 Coze workflow 實作了使用 OPRO 方法的 APE 流程，以下介紹此助手的使用方式。

### 參數設置

這個 AI 助手使用四個關鍵參數來指導其運作。每個參數都在提示詞優化過程中扮演著重要角色：

1. Goal 目標：這是你希望 AI 助手達成的最終目的。明確的目標設定能夠指導整個優化過程，確保生成的提示詞符合你的需求。
2. Initial Prompt 初始提示詞：提供初始提示詞作為優化的起點。你可以提供一個初始提示詞，或者讓系統自動生成一個。
3. Scoring Criteria 評分標準：這定義了如何評估生成的回應。你可以自己設定一個 0 到 100 分的評分標準，或者讓系統自動生成一個。
4. User Input 用戶輸入：這是用於測試和評估提示詞效果的示例輸入。你可以提供一到三個用戶輸入，用來模擬真實場景下的互動。

值得一提的是，我推薦將「Initial Prompt」和「Scoring Criteria」留空，讓我的系統自動生成。你猜這個 APE 助手首先是用在哪裡？當然是優化它自己！經過我的精煉，生成這兩個值的 LLM 表現可以說是非常出色，比一般人寫得更好。

### 快捷指令

此助手使用以下三個快捷指令操作：

{{ image(url="shortcuts.png", alt="shortcuts") }}

1. New run 新任務：用於開始一個新的提示詞優化任務。當你想要啟動一個新的優化過程時使用它。
2. Continue task 繼續任務：允許你在之前執行的結果基礎上繼續疊代。由於 Coze Workflow 有單次執行 node 數量上限，我設計了在此輸入 Run ID 接續執行前面的任務。
3. Dump result 輸出結果：在每一次執行都會倒出結果，但若你需要，也可以使用這個功能單獨輸出過往的執行結果。

接下來將講解具體的操作使用流程。

### 步驟 1：設置並執行新任務

使用「**New run**」快捷指令來開始一個新的優化過程。在這一步，你需要：

{{ image(url="new_run.png", alt="new run") }}

* 明確定義你的目標 goal
* 提供一個初始提示詞 prompt (或選擇讓系統生成)
* 設定評分標準 scoring\_criteria (或讓系統自動生成)
* 輸入一到三個用戶輸入示例 user\_input

仔細考慮每個參數，確保它們準確反映了你的需求和期望。指令送出之後它會立即開始執行，請耐心等待。

### 步驟 2：分析結果和優化

任務執行完成後，助手會輸出評分最高的五個提示詞，並將所有的評估過程輸出為一個 zip 檔。請你評估優化後的提示詞是否達到了你的目標，生成的回應是否符合預期。如果需要進一步優化，可以使用「**Continue task**」指令，在現有結果的基礎上進行更多疊代。你也可以再次使用「**New run**」功能並帶入舊的 Run ID，這會讓它基於舊的提示詞評分記錄對新的目標進行優化，將產生不一樣的效果。

通過反覆使用這個助手，調整目標和提示詞，你就能創造出更優質、更精準的 AI 提示詞。

## 使用技巧和最佳實踐

**要有效地運用「Automated Prompt Engineering 自動化提示詞工程」助手，關鍵在於制定明確且可衡量的目標**。例如，與其籠統地說「改善對話」，不如具體地表述為「生成更具同理心的客戶服務回應」。

**在選擇用戶輸入示例時，應盡量涵蓋各種可能的場景**，包括簡單和複雜的查詢，以全面測試提示詞的適應性，擅用三個 User Input。

**評分標準的設定也至關重要，它應該與你的目標保持一致**，明確定義出什麼是好、什麼是不好，定出各個分數級距如何評分。

**你也可以試著微調目標再繼續疊代，或許會得到更好的結果**。此外，將你的領域知識融入優化過程中，考慮行業特定的術語、慣例和需求，這樣可以使得生成的提示詞更加貼合實際應用場景。

## 總結

本文深入探討了 Coze 平台上的「Automated Prompt Engineering 自動化提示詞工程」助手，這是一個旨在簡化和優化 AI 提示詞創建過程的革命性工具。我們介紹了 Automated Prompt Engineering (APE) 的概念，闡述了它如何通過自動化提高提示詞的品質和效率。我們詳細說明了助手的主要功能，包括四個關鍵參數和三個實用的快捷指令，並提供了使用這個 AI 助手的詳細步驟指南。

<span class="success">這個助手的價值在於顯著提升了效率，大大縮短了提示詞優化的時間，通過系統化的優化過程生成更高品質、更精準的提示詞</span>，從而提高 AI 應用的整體表現。使用這個助手的過程本身就是一個學習 prompt engineering 的絕佳機會，幫助大家更深入地理解如何讓 AI 更聽話。

你可能會好奇，為什麼我選擇在 Coze 平台上實作 APE 助手呢？原因在於 Coze 獨特的訊息計價模式。<span class="danger">OPRO 流程需要大量的 LLM 呼叫來不斷改進提示詞，這在傳統的以 token 計價的平台上會產生高昂的成本。</span>然而，在 Coze 的訊息計價模式下，我們可以更自由地進行大量的 LLM 操作，而無需過度擔心成本問題。

「Automated Prompt Engineering 自動化提示詞工程」不僅提高了開發效率和應用品質，還為開發者提供了一個強大的工具，幫助他們更好地理解和進行提示詞工程。隨著 AI 技術的不斷發展，這樣的工具將變得越來越重要，成為每個 AI 開發者的必備利器。

> 延伸閱讀
>
> ---
> [告別 AI 幻覺：一個簡單方法提升你的 RAG 系統精準度——「摘要索引與全文參考方法」](@/AI/say-goodbye-to-ai-hallucinations-a-simple-method-to-Improve-the-accuracy-of-your-rag-system/index.md)
