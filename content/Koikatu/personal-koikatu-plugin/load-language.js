async function loadLanguage(lang) {
  try {
    const response = await fetch(`${lang}.html`);
    if (!response.ok) {
      throw new Error(`Failed to load ${lang} content`);
    }
    document.getElementById(`container_${lang}`).innerHTML =
      await response.text();
  } catch (error) {
    console.error(error);
  }
}

addEventListener("DOMContentLoaded", async function () {
  await loadLanguage("zh");
  await loadLanguage("en");
  await loadLanguage("ja");
});
