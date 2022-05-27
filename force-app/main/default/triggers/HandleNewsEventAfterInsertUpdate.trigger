//creates blog post 
trigger HandleNewsEventAfterInsertUpdate on News_Events__c (after insert, after update, before delete) {
    if(trigger.isInsert || trigger.isUpdate){
        list<News_Events__c> newsEventListForBlogPost = new list<News_Events__c>();
        list<News_Events__c> newsEventListForReminder = new list<News_Events__c>();
        list<News_Events__c> newsEventListForReminderErrorHandling = new list<News_Events__c>();
        for(News_Events__c newsevent:trigger.new){
            if(newsevent.Publish_in_Portal_School_Hub__c && newsevent.Related_Class_Blog_Available__c && newsevent.Post_Entry_in_Related_Blog__c != null && newsevent.Post_Entry_in_Related_Blog__c != 'No' && newsevent.Blog_Post_Preview__c != null && newsevent.Blog_Post_Preview__c != '' && newsevent.Posted_in_Blog__c == false){
                newsEventListForBlogPost.add(newsevent);
            }
            if(trigger.isInsert){
                //if(newsevent.Send_Automated_Reminder_Email__c == true && newsevent.Automated_Reminder_Email_Sent__c == null){
                if(newsevent.Send_Automated_Reminder_Email__c == true && newsevent.Automated_Reminder_Email_Sent__c == null){
                    newsEventListForReminder.add(newsevent);
                }
            }
            if(trigger.isUpdate){
                //if(newsevent.Send_Automated_Reminder_Email__c == true && trigger.oldMap.get(newsevent.Id).Send_Automated_Reminder_Email__c == false && newsevent.Automated_Reminder_Email_Sent__c == null){
                if(newsevent.Send_Automated_Reminder_Email__c == true && trigger.oldMap.get(newsevent.Id).Send_Automated_Reminder_Email__c == false){
                    newsEventListForReminder.add(newsevent);
                }
                if(newsevent.Error_Ids__c != null && newsevent.Retry_Sending_Email__c == true && trigger.oldMap.get(newsevent.Id).Retry_Sending_Email__c == false){
                    newsEventListForReminderErrorHandling.add(newsevent);
                }
            }
        } 
        if(newsEventListForBlogPost.size() > 0){
            //populate schools setting map
            Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
            List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
            for(School_Logo_Mapping__c setting:settings){
                schoolSettingMap.put(setting.School_Full_Name__c,setting);
            }
            set<Id> neIds = new set<Id>();
            for(News_Events__c ne:newsEventListForBlogPost){
                if(schoolSettingMap.get(ne.School__c) != null){
                    if(schoolSettingMap.get(ne.School__c).Community_Id__c != null){
                        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
                
                        
                        ConnectApi.MessageBodyInput body = new ConnectApi.MessageBodyInput();
                        List<ConnectApi.MessageSegmentInput> segmentList = new List<ConnectApi.MessageSegmentInput>();
                        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
                        textSegment.text = ne.Blog_Post_Preview__c;
                        segmentList.add((ConnectApi.MessageSegmentInput)textSegment);
                        //add blank lines
                        string blankLines = '\n\n';
                        ConnectApi.TextSegmentInput textSegmentBlank = new ConnectApi.TextSegmentInput();
                        textSegmentBlank.text = blankLines;
                        segmentList.add((ConnectApi.MessageSegmentInput)textSegmentBlank);
                        /*if(ne.Blog_Post_Hashtag__c != null && ne.Blog_Post_Hashtag__c != ''){
                            ConnectApi.HashtagSegmentInput tagSegment = new ConnectApi.HashtagSegmentInput();
                            tagSegment.tag = ne.Blog_Post_Hashtag__c;
                            segmentList.add((ConnectApi.MessageSegmentInput)tagSegment);
                        }*/
                        if(ne.Post_Entry_in_Related_Blog__c != null){
                            if(ne.Post_Entry_in_Related_Blog__c.equalsIgnoreCase('Yes - And tag as Essential Communication')){
                                if(schoolSettingMap.get(ne.School__c).Topic_Name__c != null){
                                    ConnectApi.HashtagSegmentInput tagSegment = new ConnectApi.HashtagSegmentInput();
                                    tagSegment.tag = schoolSettingMap.get(ne.School__c).Topic_Name__c;
                                    segmentList.add((ConnectApi.MessageSegmentInput)tagSegment);
                                }
                            }
                        }
                        
                        body.messageSegments = segmentList;
                        input.body = body;
                        
                        ConnectApi.FeedItem postFeedResult = ConnectApi.ChatterFeeds.postFeedItem(schoolSettingMap.get(ne.School__c).Community_Id__c,ConnectApi.FeedType.Record, ne.Related_Chatter_Group_ID__c,input,null);
                        neIds.add(ne.Id);
                        
                    }
                }
            }
            //update related record
            if(neIds.size() > 0){
                list<News_Events__c> neList = new list<News_Events__c>();
                for(Id neId:neIds){
                    News_Events__c ne1= new News_Events__c(Id=neId);
                    ne1.Posted_in_Blog__c = true;
                    neList.add(ne1);
                }
                update neList;
            }
        }
        if(newsEventListForReminder.size() > 0 || newsEventListForReminderErrorHandling.size() > 0){
            list<News_Events__c> newsEventListForUpdate = new list<News_Events__c>();
            //fetch school settings
            map<string,School_Logo_Mapping__c> schoolSettingsMap = new map<string,School_Logo_Mapping__c>();
            for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){
                schoolSettingsMap.put(schoolMapping.School_Full_Name__c, schoolMapping);
            }
            if(newsEventListForReminder.size() > 0){ 
                /*set<Id> neIds = new set<Id>();
                for(News_Events__c ne:newsEventListForReminder){
                    neIds.add(ne.Id);
                }
                system.debug('***HandleNewsEventAfterInsertUpdate***neIds='+neIds);
                EventEmailReminderBatch batch = new EventEmailReminderBatch(neIds);
                Database.executeBatch(batch,1);
                system.debug('***HandleNewsEventAfterInsertUpdate***batch executed');*/
                //execute batch
                for(News_Events__c ne:newsEventListForReminder){
                    //check for school
                    if(schoolSettingsMap.get(ne.School__c) != null && schoolSettingsMap.get(ne.School__c).Automated_Calendar_Emails_On__c == true){
                        EventEmailReminderBatch batch = new EventEmailReminderBatch(ne.Id, ne.Student_Group__c, ne.Fst_Email_Notification_Text__c);
                        Database.executeBatch(batch,50);
                    }else{
                        newsEventListForUpdate.add(new News_Events__c(Id = ne.Id, Send_Automated_Reminder_Email__c = false));
                    }
                }
                
            }
            
            if(newsEventListForReminderErrorHandling.size() > 0){
                for(News_Events__c ne:newsEventListForReminderErrorHandling){
                    //check for school
                    if(schoolSettingsMap.get(ne.School__c) != null && schoolSettingsMap.get(ne.School__c).Automated_Calendar_Emails_On__c == true){
                        EventEmailReminderBatchErrorHandling batch = new EventEmailReminderBatchErrorHandling(ne.Id, ne.Student_Group__c, ne.Fst_Email_Notification_Text__c, ne.Error_Ids__c);
                        Database.executeBatch(batch,50);
                    }else{
                        newsEventListForUpdate.add(new News_Events__c(Id = ne.Id, Send_Automated_Reminder_Email__c = false));
                    }
                }
            }
            
            if(newsEventListForUpdate.size() > 0){
                update newsEventListForUpdate;
            }
        }
    }
    if(trigger.isBefore && trigger.isDelete){
        //check for Qualifies_for_Automatic_Email_Reminder__c    
        for(News_Events__c newsevent:trigger.old){
            if(newsevent.Qualifies_for_Automatic_Email_Reminder__c){
                newsevent.addError('This date falls within the next 2 weeks and can not be deleted from the calendar. Please cancel it instead, using the \'Cancel\' button at the top of the record. Note that this will automatically send an email to all related parents informing them of the cancellation.');
            }
        }
        
        //check for self refrenced lookup
        for(News_Events__c nw:[Select n.Id, (Select Id From translated_records__r) From News_Events__c n where Id IN:trigger.oldMap.keySet()]){
            if(nw.translated_records__r.size() > 0){
                trigger.oldMap.get(nw.Id).addError('You cannot delete this record because it has related child records. Please delete the child records first and then try again.');
            }
        }
    }
}