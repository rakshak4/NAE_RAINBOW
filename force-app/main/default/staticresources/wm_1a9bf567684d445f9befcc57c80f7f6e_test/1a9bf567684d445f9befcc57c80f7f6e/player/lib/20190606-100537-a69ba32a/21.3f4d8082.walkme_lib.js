window._walkmeWebpackJP&&(window._walkmeWebpackJP=window._walkmeWebpackJP||[]).push([[21],{787:function(e,a,o){"use strict";e.exports=function(o){var m=[];return m.toString=function(){return function(e,a){for(var o=[],l=0,r=e.length;l<r;l++)o.push(a(e[l]));return o}(this,function(e){var a=function(e,a){var o=e[1]||"",l=e[3];if(!l)return o;if(a&&"function"==typeof btoa){var r=(m=l,"/*# sourceMappingURL=data:application/json;charset=utf-8;base64,"+btoa(unescape(encodeURIComponent(JSON.stringify(m))))+" */"),t=l.sources.map(function(e){return"/*# sourceURL="+l.sourceRoot+e+" */"});return[o].concat(t).concat([r]).join("\n")}var m;return[o].join("\n")}(e,o);return e[2]?"@media "+e[2]+"{"+a+"}":a}).join("")},m.i=function(e,a){"string"==typeof e&&(e=[[null,e,""]]);for(var o={},l=0;l<this.length;l++){var r=this[l][0];null!=r&&(o[r]=!0)}for(l=0;l<e.length;l++){var t=e[l];null!=t[0]&&o[t[0]]||(a&&!t[2]?t[2]=a:a&&(t[2]="("+t[2]+") and ("+a+")"),m.push(t))}},m}},794:function(e,a,o){(function(){var a=o(736);a.register("ColoradoCssLoader").asFunction(function(){return o(795).toString()}),a.register("ColoradoPlayer").asInstance(function(){var k,o,n,l,t,r,m,i=a.create("WalkmeOOP",this),w=a.get("BasePlayer"),p=57,d=40,s=7;i.Override("buildHtml",function(){var e=k.mustache().to_html('<div id="{{id}}" class="walkme-player walkme-colorado walkme-theme-{{theme}} walkme-direction-{{direction}} walkme-{{isIe}} walkme-position-major-{{positionMajor}} walkme-position-minor-{{positionMinor}} {{accessibleClass}} walkme-dynamic-size"><div class="walkme-in-wrapper"><div class="walkme-question-mark"></div><div class="walkme-title">{{{title}}}</div></div></div>',{id:k.id(),theme:o().TriangleTheme,direction:o().Direction,isIe:k.isIeClass(),positionMajor:k.positionMajor(),positionMinor:k.positionMinor(),title:o().ClosedMenuTitle,accessibleClass:k.accessibleClass()});return e});var c=i.Override("customSizeHandler",function(){var e,a,o,l=k.player(),r=l.find(".walkme-title"),t=l.find(".walkme-in-wrapper"),m=k.positionMajor(),i=k.positionMinor(),w="none"!=l.css("display");l.show(),"top"==m||"bottom"==m?(e=t,a=i,o=r.width()+p,e.width(o),f(a,o)):function(e,a,o,l){var r=n().getHostData().isIE(8,"lte"),t=r?a.height():a.width();a.width(t),r||(a.css(o,(t-d)/2*-1),a.css("bottom",(t-s)/2));var m=t+p;e.height(m),f(l,m)}(t,r,m,i),w||l.hide()});function f(e,a){var o=t(window);switch(e){case"center":var l=(o.width()-a)/2/o.width()*100;k.player().css("left",l+"%");break;case"middle":var r=(o.height()-a)/2/o.height()*100;k.player().css("top",r+"%")}}i.Override("addResources",function(e,a){n().ResourceManager.fonts([{id:"widgetFont",name:"widget-font",url:"/player/resources/fonts/widget-font_v3",dummeyText:"&#xe60c;"},{id:"opensans",name:"opensans",url:"/player/resources/fonts/opensans"}],t("head"),e,a)}),i.Override("show",function(){k.show(undefined,e)});function e(){l.on("resize.walkme-player",function(){var e=t(window),a=e.width(),o=e.height();o==m&&a==r||(r=a,m=o,c())})}i.Override("destroy",function(){k.destroy(),l.off("resize.walkme-player")}),i.Override("hide",function(){k.hide(),l.off("resize.walkme-player")}),i.Override("languageChanged",function(e){k.languageChanged(e),c()});(function(e){i.Extends(w,e),a=e.jQuery,t=a,i._base.name("Colorado"),k=i._base,o=k.config,n=k.utils,l=t(k.windowTopContainer());var a}).apply(null,arguments)})}).call(window)},795:function(a,e,o){(function(){var e=o(796);a.exports="string"==typeof e?e:e.toString()}).call(window)},796:function(e,a,o){(e.exports=o(787)(!1)).push([e.i,"@media print{.walkme-player{display:none !important}}@media print{.walkme-menu{display:none !important}}@media print{#walkme-attengrab{display:none !important}}.walkme-direction-ltr{direction:ltr !important;text-align:left !important}.walkme-direction-rtl{direction:rtl !important;text-align:right !important}.walkme-css-reset{padding:0 !important;margin:0 !important;vertical-align:middle !important;border-collapse:inherit !important;background:none !important;border-spacing:1px 1px !important;line-height:normal !important;border-top:none !important;border-right:none !important;border-bottom:none !important;border-left:none !important;text-shadow:none !important;overflow:visible !important;table-layout:auto !important;position:static !important;-moz-box-sizing:content-box;-webkit-box-sizing:content-box;box-sizing:content-box;color:#eb15e2 !important;width:auto;height:auto;float:none !important;transition:none !important}.walkme-player{position:fixed !important;z-index:2147483647 !important;cursor:pointer !important}.walkme-player .walkme-out-wrapper{direction:ltr !important}.walkme-player .walkme-arrow{position:absolute !important;width:10px !important;height:7px !important;z-index:2147483647 !important}.walkme-player .walkme-icon{position:absolute !important;height:27px !important;width:34px !important;background-image:url(images/player/questionmark.png) !important;z-index:2147483641 !important}.walkme-player.walkme-position-major-top{top:0px}.walkme-player.walkme-position-major-top .walkme-out-wrapper{border-radius:0px 0px 12px 12px}.walkme-player.walkme-position-major-top .walkme-in-wrapper{border-radius:0px 0px 12px 12px}.walkme-player.walkme-position-major-top .walkme-arrow{top:14px !important;right:6px !important;-moz-transform:rotate(-180deg) !important;-ms-transform:rotate(-180deg) !important;-webkit-transform:rotate(-180deg) !important;transform:rotate(-180deg) !important}.walkme-player.walkme-position-major-right{right:0px}.walkme-player.walkme-position-major-right .walkme-out-wrapper{border-radius:12px 0px 0px 12px}.walkme-player.walkme-position-major-right .walkme-in-wrapper{border-radius:12px 0px 0px 12px}.walkme-player.walkme-position-major-right .walkme-arrow{top:145px !important;right:11px !important;-moz-transform:rotate(-90deg) !important;-ms-transform:rotate(-90deg) !important;-webkit-transform:rotate(-90deg) !important;transform:rotate(-90deg) !important;filter:progid:DXImageTransform.Microsoft.gradient( startColorstr='#e2f5ff', endColorstr='#c6e3f3',GradientType=1 )}.walkme-player.walkme-position-major-bottom{bottom:0px}.walkme-player.walkme-position-major-bottom .walkme-out-wrapper{border-radius:12px 12px 0px 0px}.walkme-player.walkme-position-major-bottom .walkme-in-wrapper{border-radius:12px 12px 0px 0px}.walkme-player.walkme-position-major-bottom .walkme-arrow{bottom:11px !important;right:4px !important}.walkme-player.walkme-position-major-left{left:0px}.walkme-player.walkme-position-major-left .walkme-out-wrapper{border-radius:0px 12px 12px 0px}.walkme-player.walkme-position-major-left .walkme-in-wrapper{border-radius:0px 12px 12px 0px}.walkme-player.walkme-position-major-left .walkme-arrow{top:145px !important;left:11px !important;-moz-transform:rotate(-270deg) !important;-ms-transform:rotate(-270deg) !important;-webkit-transform:rotate(-270deg) !important;transform:rotate(-270deg) !important;filter:progid:DXImageTransform.Microsoft.gradient( startColorstr='#e2f5ff', endColorstr='#c6e3f3',GradientType=1 )}.walkme-player.walkme-ie.walkme-ie-7.walkme-position-major-top .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-8.walkme-position-major-top .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-9.walkme-position-major-top .walkme-arrow{filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=2) !important;-moz-transform:rotate(0) !important;-ms-transform:rotate(0) !important;-webkit-transform:rotate(0) !important;transform:rotate(0) !important}.walkme-player.walkme-ie.walkme-ie-7.walkme-position-major-right .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-8.walkme-position-major-right .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-9.walkme-position-major-right .walkme-arrow{filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=3) !important;-moz-transform:rotate(0) !important;-ms-transform:rotate(0) !important;-webkit-transform:rotate(0) !important;transform:rotate(0) !important}.walkme-player.walkme-ie.walkme-ie-7.walkme-position-major-left .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-8.walkme-position-major-left .walkme-arrow,.walkme-player.walkme-ie.walkme-ie-9.walkme-position-major-left .walkme-arrow{filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1) !important;-moz-transform:rotate(0) !important;-ms-transform:rotate(0) !important;-webkit-transform:rotate(0) !important;transform:rotate(0) !important}.walkme-player.walkme-colorado,.walkme-player.walkme-colorado *{font-family:'walkme-opensans', Arial !important}.walkme-player.walkme-colorado.walkme-position-minor-top,.walkme-player.walkme-colorado *.walkme-position-minor-top{top:100px}.walkme-player.walkme-colorado.walkme-position-minor-bottom,.walkme-player.walkme-colorado *.walkme-position-minor-bottom{bottom:100px}.walkme-player.walkme-colorado.walkme-position-minor-left,.walkme-player.walkme-colorado *.walkme-position-minor-left{left:100px}.walkme-player.walkme-colorado.walkme-position-minor-right,.walkme-player.walkme-colorado *.walkme-position-minor-right{right:100px}.walkme-player.walkme-colorado.walkme-position-minor-center,.walkme-player.walkme-colorado *.walkme-position-minor-center{left:50%}.walkme-player.walkme-colorado.walkme-position-minor-middle,.walkme-player.walkme-colorado *.walkme-position-minor-middle{top:50%}.walkme-player.walkme-colorado.walkme-position-minor-left_corner,.walkme-player.walkme-colorado *.walkme-position-minor-left_corner{left:0px}.walkme-player.walkme-colorado.walkme-position-minor-right_corner,.walkme-player.walkme-colorado *.walkme-position-minor-right_corner{right:0px}.walkme-player.walkme-colorado .walkme-in-wrapper,.walkme-player.walkme-colorado * .walkme-in-wrapper{position:relative !important;border-width:1px !important;border-style:solid !important;border-radius:0 !important}.walkme-player.walkme-colorado .walkme-title,.walkme-player.walkme-colorado * .walkme-title{position:absolute !important;font-size:18px !important;font-weight:normal !important;z-index:2147483640 !important;white-space:nowrap !important;display:inline-block !important}.walkme-player.walkme-colorado .walkme-question-mark,.walkme-player.walkme-colorado * .walkme-question-mark{*zoom:expression(this.runtimeStyle[ 'zoom' ] = '1', this.innerHTML = '&#xe606;');display:inline-block !important;font-family:'walkme-widget-font' !important;font-style:normal !important;font-weight:normal !important;line-height:1 !important;-webkit-font-smoothing:antialiased !important;-moz-osx-font-smoothing:grayscale !important;width:30px !important;padding-top:10px !important;height:30px !important;color:#ffffff !important;font-size:20px}.walkme-player.walkme-colorado .walkme-question-mark:before,.walkme-player.walkme-colorado * .walkme-question-mark:before{content:\"\\e606\"}.walkme-player.walkme-colorado.walkme-direction-ltr .walkme-question-mark,.walkme-player.walkme-colorado *.walkme-direction-ltr .walkme-question-mark{padding-left:10px !important}.walkme-player.walkme-colorado.walkme-direction-rtl .walkme-question-mark,.walkme-player.walkme-colorado *.walkme-direction-rtl .walkme-question-mark{padding-right:10px !important}.walkme-player.walkme-colorado.walkme-position-major-top .walkme-in-wrapper,.walkme-player.walkme-colorado *.walkme-position-major-top .walkme-in-wrapper{height:40px !important;border-top:none !important}.walkme-player.walkme-colorado.walkme-position-major-top.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-top.walkme-direction-ltr .walkme-title{top:8px !important;left:50px !important}.walkme-player.walkme-colorado.walkme-position-major-top.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-top.walkme-direction-rtl .walkme-title{top:8px !important;right:50px !important}.walkme-player.walkme-colorado.walkme-position-major-right .walkme-in-wrapper,.walkme-player.walkme-colorado *.walkme-position-major-right .walkme-in-wrapper{width:40px !important;border-right:none !important}.walkme-player.walkme-colorado.walkme-position-major-right .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-right .walkme-title{-moz-transform:rotate(90deg);-ms-transform:rotate(90deg);-webkit-transform:rotate(90deg);transform:rotate(90deg)}.walkme-player.walkme-colorado.walkme-position-major-bottom .walkme-in-wrapper,.walkme-player.walkme-colorado *.walkme-position-major-bottom .walkme-in-wrapper{height:40px !important;border-bottom:none !important}.walkme-player.walkme-colorado.walkme-position-major-bottom.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-bottom.walkme-direction-ltr .walkme-title{top:9px !important;left:49px !important}.walkme-player.walkme-colorado.walkme-position-major-bottom.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-bottom.walkme-direction-rtl .walkme-title{top:8px !important;right:49px !important}.walkme-player.walkme-colorado.walkme-position-major-left .walkme-in-wrapper,.walkme-player.walkme-colorado *.walkme-position-major-left .walkme-in-wrapper{width:40px !important;border-left:none !important}.walkme-player.walkme-colorado.walkme-position-major-left .walkme-title,.walkme-player.walkme-colorado *.walkme-position-major-left .walkme-title{-moz-transform:rotate(90deg);-ms-transform:rotate(90deg);-webkit-transform:rotate(90deg);transform:rotate(90deg)}.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-right.walkme-ie-7 .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-right.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-left.walkme-ie-7 .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-left.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-right.walkme-ie-7 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-right.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-left.walkme-ie-7 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-left.walkme-ie-8 .walkme-title{margin:10px 10px 0 !important}.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-right.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-left.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-right.walkme-ie-8 .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-left.walkme-ie-8 .walkme-title{top:37px !important}.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-right.walkme-ie-8.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-left.walkme-ie-8.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-right.walkme-ie-8.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-left.walkme-ie-8.walkme-direction-rtl .walkme-title{right:0 !important}.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-right.walkme-ie-8.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-left.walkme-ie-8.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-right.walkme-ie-8.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-left.walkme-ie-8.walkme-direction-ltr .walkme-title{left:0 !important}.walkme-player.walkme-colorado.walkme-ie.walkme-ie-7.walkme-position-major-right .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-ie-8.walkme-position-major-right .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-ie-7.walkme-position-major-right .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-ie-8.walkme-position-major-right .walkme-title{filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1)}.walkme-player.walkme-colorado.walkme-ie.walkme-ie-7.walkme-position-major-left .walkme-title,.walkme-player.walkme-colorado.walkme-ie.walkme-ie-8.walkme-position-major-left .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-ie-7.walkme-position-major-left .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-ie-8.walkme-position-major-left .walkme-title{filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1)}.walkme-player.walkme-colorado.walkme-ie.walkme-position-major-bottom .walkme-title,.walkme-player.walkme-colorado *.walkme-ie.walkme-position-major-bottom .walkme-title{top:10px !important}.walkme-player.walkme-colorado.walkme-direction-ltr .walkme-title,.walkme-player.walkme-colorado *.walkme-direction-ltr .walkme-title{direction:ltr !important}.walkme-player.walkme-colorado.walkme-direction-rtl .walkme-title,.walkme-player.walkme-colorado *.walkme-direction-rtl .walkme-title{direction:rtl !important}.walkme-player.walkme-colorado.walkme-theme-white-blue,.walkme-player.walkme-colorado.walkme-theme-white-blue *{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-blue .walkme-in-wrapper,.walkme-player.walkme-colorado.walkme-theme-white-blue * .walkme-in-wrapper{border-color:#c6c6c6 !important;-moz-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;-webkit-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important}.walkme-player.walkme-colorado.walkme-theme-white-blue .walkme-question-mark,.walkme-player.walkme-colorado.walkme-theme-white-blue * .walkme-question-mark{background-color:#369cd9 !important}.walkme-player.walkme-colorado.walkme-theme-white-blue.walkme-ie .walkme-arrow{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-blue.walkme-ie .walkme-title{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-blue.walkme-ie-10 .walkme-arrow{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-blue.walkme-ie-10 .walkme-title{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-blue .walkme-title{color:#474747 !important}.walkme-player.walkme-colorado.walkme-theme-white-orange,.walkme-player.walkme-colorado.walkme-theme-white-orange *{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-orange .walkme-in-wrapper,.walkme-player.walkme-colorado.walkme-theme-white-orange * .walkme-in-wrapper{border-color:#c6c6c6 !important;-moz-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;-webkit-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important}.walkme-player.walkme-colorado.walkme-theme-white-orange .walkme-question-mark,.walkme-player.walkme-colorado.walkme-theme-white-orange * .walkme-question-mark{background-color:#f77c2b !important}.walkme-player.walkme-colorado.walkme-theme-white-orange.walkme-ie .walkme-arrow{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-orange.walkme-ie .walkme-title{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-orange.walkme-ie-10 .walkme-arrow{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-orange.walkme-ie-10 .walkme-title{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-orange .walkme-title{color:#474747 !important}.walkme-player.walkme-colorado.walkme-theme-white-green,.walkme-player.walkme-colorado.walkme-theme-white-green *{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-green .walkme-in-wrapper,.walkme-player.walkme-colorado.walkme-theme-white-green * .walkme-in-wrapper{border-color:#c6c6c6 !important;-moz-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;-webkit-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important}.walkme-player.walkme-colorado.walkme-theme-white-green .walkme-question-mark,.walkme-player.walkme-colorado.walkme-theme-white-green * .walkme-question-mark{background-color:#76d331 !important}.walkme-player.walkme-colorado.walkme-theme-white-green.walkme-ie .walkme-arrow{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-green.walkme-ie .walkme-title{background-color:#fff !important}.walkme-player.walkme-colorado.walkme-theme-white-green.walkme-ie-10 .walkme-arrow{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-green.walkme-ie-10 .walkme-title{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-white-green .walkme-title{color:#474747 !important}.walkme-player.walkme-colorado.walkme-theme-black-blue,.walkme-player.walkme-colorado.walkme-theme-black-blue *{background-color:#363636 !important}.walkme-player.walkme-colorado.walkme-theme-black-blue .walkme-in-wrapper,.walkme-player.walkme-colorado.walkme-theme-black-blue * .walkme-in-wrapper{border-color:#7a7a7a !important;-moz-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;-webkit-box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important;box-shadow:0 0px 7px -2px rgba(50,50,50,0.4) !important}.walkme-player.walkme-colorado.walkme-theme-black-blue .walkme-question-mark,.walkme-player.walkme-colorado.walkme-theme-black-blue * .walkme-question-mark{background-color:#369cd9 !important}.walkme-player.walkme-colorado.walkme-theme-black-blue.walkme-ie .walkme-arrow{background-color:#363636 !important}.walkme-player.walkme-colorado.walkme-theme-black-blue.walkme-ie .walkme-title{background-color:#363636 !important}.walkme-player.walkme-colorado.walkme-theme-black-blue.walkme-ie-10 .walkme-arrow{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-black-blue.walkme-ie-10 .walkme-title{background-color:transparent !important}.walkme-player.walkme-colorado.walkme-theme-black-blue .walkme-title{color:#fff !important}\n",""])}}]);