window.walkMeGermany = true;(window._walkmeWebpackJP=window._walkmeWebpackJP||[]).push([[9],{384:function(n,e,t){(function(t,e){(function(){t.register("ActionBotInitializer").asCtor(function(d,g,p,S,f,w,b,m,y,h,v,A,C,M,F,I,k){this.start=function(s){return new e(function(e,t){try{var n=y.getSettingsFile(),r=y.getCdnServerName();if(I.isSelfHosted){if(!f.isFeatureEnabled(P))return e();r=n.PlayerApiServer&&n.PlayerApiServer.replace("papi","cdn")}var a=(c=r,localStorage&&localStorage.getItem("wm-actionbot-dialog-ui-public-path")||c+"/chatbot/2/"),i=(l=y.getSettingsFile(),localStorage&&localStorage.getItem("wm-actionbot-dialog-ui-api-base-url")||l.PlayerApiServer),o=a+"main.js";d.addScriptWithCallback(o,"onActionBotReadyCb",function(){return{resolve:e,reject:t,wmDependencies:{publicPath:a,apiBaseUrl:i,dataFile:s,clientStorageManager:p,jQuerySelectorRunner:S,actionStagesFactory:w,inputGenerator:b,consts:m,settingsFile:y,wmjQuery:h,wmLogger:g,eventSender:v,userGuidContainer:A,endUsersManager:C,auditSourceManager:M,classWalkMeAPI:F,launchersModule:k,eventsListener:{bind:function(){return I.bind.apply(undefined,arguments)},unbind:function(){return I.unbind.apply(undefined,arguments)}}}}},function(){t(new Error("Failed to addScriptWithCallback for: "+o))})}catch(u){t(u)}var l,c})}}).dependencies("CommonUtils, Logger, ClientStorageManager, JQuerySelectorRunner, FeaturesManager,ActionStagesFactory, InputGenerator, Consts, SettingsFile, wmjQuery, EventSender,UserGuidContainer, EndUsersManager, AuditSourceManager, ClassWalkMeAPI, WmInternals, LaunchersModule");var P="ActionBotsAllowedInSelfHosted";n.exports={init:function(e){return t.get("ActionBotInitializer").start(e)["catch"](function(e){t.get("Logger").error(e)})}}}).call(window)}).call(this,t(1),t(28))}}]);
