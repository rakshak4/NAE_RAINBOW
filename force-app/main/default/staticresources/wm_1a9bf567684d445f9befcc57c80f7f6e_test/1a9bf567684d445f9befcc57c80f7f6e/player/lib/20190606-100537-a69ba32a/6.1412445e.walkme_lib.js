(window._walkmeWebpackJP=window._walkmeWebpackJP||[]).push([[6],{635:function(e,t,n){(function(){var e=n(246),t=function(){function e(e){this.consts=e}return e.prototype.getQuestionAndAnswerTextFromSurvey=function(e,t,n){var s=wmjQuery.grep(e.Questions,function(e){return e.Id==t})[0];switch(s.QuestionType){case this.consts.QUESTION_TYPES.NPS:return this.getAnswerAndQuestionTextForNPS(s,n);case this.consts.QUESTION_TYPES.FreeText:return this.getAnswerAndQuestionTextForFreeText(s);case this.consts.QUESTION_TYPES.RadioButton:case this.consts.QUESTION_TYPES.CheckBox:return this.getAnswerAndQuestionTextForMultipleAnswersQuestion(s,n)}},e.prototype.getAnswerAndQuestionTextForNPS=function(e,t){return{questionText:e.Title,answerText:t}},e.prototype.getAnswerAndQuestionTextForFreeText=function(e){return{questionText:e.Title}},e.prototype.getAnswerAndQuestionTextForMultipleAnswersQuestion=function(e,t){var n=wmjQuery.grep(e.Answers,function(e){return e.Id==t})[0];return{questionText:e.Title,answerText:n.Title}},e}();e.register("SurveyQuestionAndAnswerText").asCtor(t).dependencies("Consts")}).call(window)}}]);