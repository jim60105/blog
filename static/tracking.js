function tracking(GA_TRACKING_ID, CLARITY_TRACKING_ID) {
  if (navigator.globalPrivacyControl) {
    window.gtag = () => {};
    console.log(
      "%cWe can see that you have enabled the Global Privacy Control, indicating that you do not wish to have your information sold or shared.",
      "font-weight:bold; color: lightgreen;",
      "\nYour privacy is important to us, and we completely honor your choice.",
      "As a result, we have deactivated Google Analytics and Microsoft Clarity. 😉"
    );
    return;
  }

  // Setup GA
  (function (id) {
    const gtagScript = document.createElement("script");
    gtagScript.async = true;
    gtagScript.src = "https://www.googletagmanager.com/gtag/js?id=" + id;

    document.head.appendChild(gtagScript);

    const dataLayerScript = document.createElement("script");
    dataLayerScript.innerHTML = `
				          window.dataLayer = window.dataLayer || [];
				          function gtag(){dataLayer.push(arguments);}
				          gtag('js', new Date());
				          gtag('config', '${id}');`;
    document.head.appendChild(dataLayerScript);
  })(GA_TRACKING_ID);

  // Setup Clarity
  (function (c, l, a, r, i, t, y) {
    c[a] =
      c[a] ||
      function (...args) {
        (c[a].q = c[a].q || []).push(args);
      };
    t = l.createElement(r);
    t.async = 1;
    t.src = "https://www.clarity.ms/tag/" + i;
    y = l.getElementsByTagName(r)[0];
    y.parentNode.insertBefore(t, y);
  })(window, document, "clarity", "script", CLARITY_TRACKING_ID);
}
