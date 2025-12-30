// Dynamically load mermaid only when <pre class="mermaid"> is found in <article>
(function () {
  const article = document.querySelector("article");
  if (!article) return;

  const hasMermaid = article.querySelector("pre.mermaid");
  if (!hasMermaid) return;

  import("https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs")
    .then((module) => {
      const mermaid = module.default;
      mermaid.initialize({ startOnLoad: true, theme: "dark" });
    })
    .catch((err) => {
      console.error("Failed to load mermaid:", err);
    });
})();
