// ==UserScript==
// @name         Youtube Ad Cleaner(Include Non-Skippable Ads- works)
// @namespace    http://tampermonkey.net/
// @version      1.39.2
// @description  (Chrome ONLY) Bypass all youtube ads including in video ads, skippable and non-skippable Ads
// @author       BjDanny
// @run-at          document-start
// @match        *://*.youtube.com/*
// ==/UserScript==
'use strict';
setInterval(adMonitor ,500);
setInterval(killAd ,1);
setInterval(()=>{counter = 0; console.log("Counter is reset by timer");} ,60000);
window.addEventListener("click", ()=>{setTimeout(()=>{counter = 0; console.log("Counter is reset by mouse click");},2000);});
var counter = 0;
var fixLoopInvoked = false;

function adMonitor()
{
    if (fixLoopInvoked){fixLoopInvoked=false;}
    try
    {
      let ytplayer = document.getElementById("movie_player");
      let adState = ytplayer.getAdState();
      if (adState === 1)
      {
          counter +=1;
          Ads.cancelVdoAd();
          if (ytplayer.getPlayerState() === -1) Ads.stopVdoAd();
          console.log("Current counter is:" + counter);
          if (counter >=2) {counter=0;console.log("Invoked fixLoop");fixLoopInvoked = true;Ads.fixLoop();}; //remove stubbon video ad
      }
    }
    catch(e)
    {
        return;
    }
}

function killAd()
{
    Ads.removeByID();
    Ads.removeByClassName();
    Ads.removeByTagName();
}

var Ads = {
    "aId":["masthead-ad","player-ads","top-container","offer-module","pyv-watch-related-dest-url","ytd-promoted-video-renderer"],
    "aClass":["style-scope ytd-search-pyv-renderer","video-ads","ytd-compact-promoted-video-renderer"],
    "aTag":["ytd-promoted-sparkles-text-search-renderer"],
    "removeByID":function(){this.aId.forEach(i=>{ var AdId = document.getElementById(i);if(AdId) AdId.remove();})},
    "removeByClassName":function(){this.aClass.forEach(c=>{ var AdClass = document.getElementsByClassName(c);if(AdClass[0]) AdClass[0].remove();})},
    "removeByTagName":function(){this.aTag.forEach(t=>{ var AdTag = document.getElementsByTagName(t);if(AdTag[0]) AdTag[0].remove();})},
    "cancelVdoAd":function(){ console.log('cancelled video ad'); document.getElementById("movie_player").cancelPlayback();setTimeout(()=>{document.getElementById("movie_player").playVideo();},1);},
    "stopVdoAd":function(){ console.log('stopped video ad'); document.getElementById("movie_player").stopVideo();setTimeout(()=>{document.getElementById("movie_player").playVideo();},1);},
    "fixLoop":function(){console.log('fixLoop is triggered');let myWin = window.open('', '_blank');myWin.document.write("<script>function closeIt(){window.close();} window.onload=setTimeout(closeIt, 1000);<\/script><p>Skipping Ad ... auto close!!<\/p>");myWin.focus();}
}
