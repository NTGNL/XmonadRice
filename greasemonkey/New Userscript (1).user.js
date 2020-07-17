// ==UserScript==
// @name         New Userscript
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://karachan.org/*
// @include      http://karachan.org/*
// @exclude      http://karachan.org/
// @exclude      http://karachan.org/mitsuba.html*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    $('style').remove();
    document.getElementById("czaj").remove();
    document.getElementById("kurwy").remove();
    document.getElementById("korona").remove();
    // Your code here...
})();