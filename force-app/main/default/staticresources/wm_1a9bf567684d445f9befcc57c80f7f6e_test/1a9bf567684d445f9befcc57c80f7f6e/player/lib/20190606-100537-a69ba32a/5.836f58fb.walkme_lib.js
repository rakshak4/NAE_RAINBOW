(window._walkmeWebpackJP=window._walkmeWebpackJP||[]).push([[5],{634:function(e,t,n){(function(){n(618),n(619),n(620),n(621),n(622),n(246).register("AllQuestionsSurvey").asCtor(function(t,n,o,r,u,s,i,a,l){var c,y,v;function w(o,r){u.setSurveyBalloonActions(o,y),mtjQuery(".walkme-action-submit",o).click(function(){var e,t,n;e=o,t=r.FooterTextColor,0<wmjQuery.grep(v,function(e){return!e.getAnswers()}).length?u.showValidationErrors(e,t,y.Settings):c.submitSurvey(l,v,(n=[],wmjQuery.each(v,function(e,t){n.push(t.getAnswers())}),n),u.closeSurvey)}),mtjQuery(".walkme-action-close",o).click(function(){c.surveyExited(l,v,u.closeSurvey)})}this.show=function(){var e=o.generateMultipleQuestions(y,v),t=[i.generate(a.BALLOON_BUTTON_TYPE.Submit)],n=y.Settings&&y.Settings.fadeBackground;return s.show(y.Id,e,t,n,w)},function(){y=l.surveyJson,v=[],c=t.get(n.Survey);for(var e=0;e<y.Questions.length;e++)v.push(r.getSurveyQuestion(y.Questions[e],y))}.apply(null,[l])}).asProto().dependencies("DeployablesManagerFactory, DeployableTypes, SurveyQuestionGenerator, SurveyQuestionFactory,SurveyHelper, SurveyBalloon, BalloonButtonDataGenerator, Consts")}).call(window)}}]);