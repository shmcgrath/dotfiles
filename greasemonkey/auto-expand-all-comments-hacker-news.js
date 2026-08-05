// ==UserScript==
// @name         Hacker News - Expand Absolutely Everything
// @namespace    https://example.com
// @version      1.2
// @description  Expands all collapsed comments
// @match        https://news.ycombinator.com/item?id=*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function () {
    "use strict";

    const CHECK_INTERVAL = 1000;
    const IDLE_LIMIT = 10;

    let idle = 0;

    const timer = setInterval(() => {
        let didSomething = false;

        document.querySelectorAll("a.togg.clicky").forEach((link) => {
            const text = link.textContent.trim();

            // Click anything that isn't already expanded ("[–]")
            if (text !== "[–]") {
                link.click();
                didSomething = true;
            }
        });

        if (didSomething) {
            idle = 0;
        } else {
            idle++;

            if (idle >= IDLE_LIMIT) {
                clearInterval(timer);
                console.log("Finished expanding all Hacker News comments.");
            }
        }
    }, CHECK_INTERVAL);
})();
