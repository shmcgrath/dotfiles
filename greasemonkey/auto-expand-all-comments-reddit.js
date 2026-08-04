// ==UserScript==
// @name         Old Reddit - Expand Absolutely Everything
// @namespace    https://example.com
// @version      1.2
// @description  Expands all collapsed comments and loads all "load more comments" links.
// @match        https://old.reddit.com/*/comments/*
// @run-at       document-end
// @grant        none
// ==/UserScript==

(function () {
    "use strict";

    const CHECK_INTERVAL = 500;
    const IDLE_LIMIT = 10; // 10 × 500ms = 5 seconds

    let idle = 0;

    const timer = setInterval(() => {
        let didSomething = false;

        // Expand every collapsed comment
        document.querySelectorAll("a.expand").forEach((link) => {
            if (link.textContent.trim() === "[+]") {
                link.click();
                didSomething = true;
            }
        });

        // Click every "load more comments" link
        document
            .querySelectorAll('a.button[onclick*="morechildren"]')
            .forEach((link) => {
                link.click();
                didSomething = true;
            });

        if (didSomething) {
            idle = 0;
        } else {
            idle++;

            if (idle >= IDLE_LIMIT) {
                clearInterval(timer);
                console.log("Finished expanding all comments.");
            }
        }
    }, CHECK_INTERVAL);
})();
