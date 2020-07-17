// ==UserScript==
// @name         New Userscript
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://karachan.org/b/res/19057902.html
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
$('teraz').remove();
$('style').remove();
document.getElementById("czaj").remove()
document.getElementById("kurwy").remove();
document.getElementById("teraz").remove();
document.getElementById("korona").remove();
document.getElementById("regulamin").remove();
})();