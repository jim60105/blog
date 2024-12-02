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

function toggleLanguage(lan) {
  var toggled = false;

  var es = document.getElementsByName("languagePanel");
  es.forEach(function (element) {
    if (element.getAttribute("lan") == lan) {
      element.style.width = "100%";
      setTimeout(function () {
        element.parentNode.style.height = element.clientHeight + "px";
        /*console.log(element.parentNode.style.height+", "+element.clientHeight);*/
      }, 500);
      toggled = true;
    } else {
      element.style.width = "0%";
    }
  });

  var flips = Array.prototype.slice.call(document.getElementsByName("flip"));
  for (var j = 0; j < 2; j++) {
    var flip = flips.slice(
      (flips.length / 2) * j,
      (flips.length / 2) * (j + 1)
    );
    var index = Array.prototype.findIndex.call(
      flip,
      (element) => element.getAttribute("lan") == lan
    );
    for (var i = 0; i < flip.length; i++) {
      var element = flip[i];
      if (element.getAttribute("lan") == lan) {
        element.style.width = "55%";
        element.style.zIndex = 10;
      } else {
        element.style.width = "20%";
        element.style.zIndex = 10 - Math.abs(i - index);
      }
      if (element.getAttribute("lan") == "ja") {
        if (lan == "zh") {
          element.style.left = "55%";
        } else {
          element.style.left = "20%";
        }
      }
    }
  }
  window.location.hash = "#" + lan;
  return toggled;
}

addEventListener("DOMContentLoaded", async function () {
  await loadLanguage("zh");
  await loadLanguage("en");
  await loadLanguage("ja");

  var toggled = false;
  if (window.location.hash != "" && window.location.hash != "#") {
    toggled = toggleLanguage(window.location.hash.substring(1));
  }
  if (!toggled) {
    toggleLanguage("zh");
  }
});
