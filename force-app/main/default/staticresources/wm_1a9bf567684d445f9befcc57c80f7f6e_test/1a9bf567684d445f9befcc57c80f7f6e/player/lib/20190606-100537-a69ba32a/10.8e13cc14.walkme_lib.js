window._walkmeWebpackJP&&(window._walkmeWebpackJP=window._walkmeWebpackJP||[]).push([[10],{708:function(t,e,n){(function(n,e){(function(){n.register("ActionBotInitializer").asCtor(function(g,d,p,S,w,v,f,m,C,b,M,h,A,y,P,E,k,F,I,W,L,j,B,U,G,J,Q,x){this.start=function(l){return new e(function(e,n){try{var t=C.getSettingsFile(),r=C.getCdnServerName();if(E.isSelfHosted){if(!w.isFeatureEnabled(R))return e();r=t.PlayerApiServer&&t.PlayerApiServer.replace("papi","cdn")}var a=(c=r,F&&F.getItem("wm-actionbot-dialog-ui-public-path")||c+"/chatbot/3/"),i=(s=C.getSettingsFile(),F&&F.getItem("wm-actionbot-dialog-ui-api-base-url")||s.PlayerApiServer),o=a+"main.js";g.addScriptWithCallback(o,"onActionBotReadyCb",function(){return{resolve:e,reject:n,wmDependencies:{publicPath:a,apiBaseUrl:i,dataFile:l,clientStorageManager:p,jQuerySelectorRunner:S,actionStagesFactory:v,inputGenerator:f,consts:m,settingsFile:C,wmjQuery:b,wmLogger:d,eventSender:M,userGuidContainer:h,endUsersManager:A,auditSourceManager:y,classWalkMeAPI:P,launchersModule:k,wmInternals:E,wmAjax:I,eventsTrigger:W,commonEvents:L,topContainerProvider:j,newApiEventsConfigProvider:B,siteConfigManager:U,shuttlesManager:G,shoutOutsManager:J,eventSenderErrorLogger:Q,win:x,eventsListener:{bind:function(){return E.bind.apply(undefined,arguments)},unbind:function(){return E.unbind.apply(undefined,arguments)}}}}},function(){n(new Error("Failed to addScriptWithCallback for: "+o))})}catch(u){n(u)}var s,c})}}).dependencies("CommonUtils, Logger, ClientStorageManager, JQuerySelectorRunner, FeaturesManager,ActionStagesFactory, InputGenerator, Consts, SettingsFile, wmjQuery, EventSender,UserGuidContainer, EndUsersManager, AuditSourceManager, ClassWalkMeAPI, WmInternals, LaunchersModule, LocalStorageService, WmAjax, EventsTrigger, CommonEvents, TopContainerProvider, NewApiEventsConfigProvider, SiteConfigManager, ShuttlesManager,ShoutOutsManager, EventSenderErrorLogger, win");var R="ActionBotsAllowedInSelfHosted";t.exports={init:function(e){return n.get("ActionBotInitializer").start(e)["catch"](function(e){n.get("Logger").error(e)})}}}).call(window)}).call(this,n(2),n(29))}}]);