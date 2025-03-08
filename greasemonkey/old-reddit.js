// ==UserScript==
// @name         old reddit
// @namespace    https://www.reddit.com
// @version      1.5
// @description  redirect to old reddit
// @author       schneid3306
// @match        https://*.reddit.com/*
// @exclude      https://*.reddit.com/poll/*
// @exclude      https://*.reddit.com/gallery/*
// @exclude      https://www.reddit.com/media*
// @exclude      https://chat.reddit.com/*
// @exclude      https://www.reddit.com/appeal*
// @exclude      https://embed.reddit.com/*
// @license      MIT
// @run-at       document-start
// ==/UserScript==

if ( window.location.host != "old.reddit.com" ) {
    var oldReddit = window.location.protocol + "//" + "old.reddit.com" + window.location.pathname + window.location.search + window.location.hash;
    window.location.replace (oldReddit);
}
