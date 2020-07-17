// ==UserScript==
// @name         Karachan czerwone tło - usuwanie
// @version      0.2
// @description  Usuwa czerwone tło ze strony karachan.org
// @author       TomaszTerka
// @include      http://karachan.org/*
// @exclude      http://karachan.org/
// @exclude      http://karachan.org/mitsuba.html*
// @grant        none
// @namespace http://your.homepage/
// ==/UserScript==
document.getElementById("czaj").remove();
document.getElementById("kurwy").remove();
document.getElementById("korona").remove();
localStorage.xD='xD'