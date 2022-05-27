//controller class for news event page
public class PortalNewsEvents_Controller extends PortalReportFilter { 
	public date fromDate {get;set;}
	public date toDate {get;set;}
	private boolean fetchEventsWithOutDate {get;set;}
	
	public string fromDateString {get{
		
		string s = '';
		if(fromDate != null){
			integer day = fromDate.day();
			if(day < 10){
				s += '0'+day;
			}else{
				s += ''+day;
			}
			
			integer month = fromDate.month();
			if(month < 10){
				s += '/0'+month;
			}else{
				s += '/'+month;
			}
			
			s += '/'+fromDate.year();
			
		}
		return s;
	}set{
		if(value != null && value != ''){
			list<string> s_split = value.split('/');
			if(s_split.size() == 3){
				try{
					fromDate = date.newInstance(integer.valueOf(s_split[2]),integer.valueOf(s_split[1]),integer.valueOf(s_split[0]));
				}catch(Exception e){fromDate = null;}
			}else{
				fromDate = null;
			}
		}else{
			fromDate = null;
		}
	}}
	public string toDateString {get{
		string s = '';
		if(toDate != null){
			integer day = toDate.day();
			if(day < 10){
				s += '0'+day;
			}else{
				s += ''+day;
			}
			
			integer month = toDate.month();
			if(month < 10){
				s += '/0'+month;
			}else{
				s += '/'+month;
			}
			
			s += '/'+toDate.year();
			
		}
		return s;
	}set{
		if(value != null && value != ''){
			list<string> s_split = value.split('/');
			if(s_split.size() == 3){
				try{toDate = date.newInstance(integer.valueOf(s_split[2]),integer.valueOf(s_split[1]),integer.valueOf(s_split[0]));}
				catch(Exception e){toDate = null;}
			}else{
				toDate = null;
			}
		}else{
			toDate = null;
		}
	}}
	public map<Id,set<Id>> studentGroupIdMap {get;set;}
	public map<Id,set<String>> groupIdStudentMap {get;set;}
	public set<String> allStudentNames {get;set;}
	public set<Id> allGroupIds {get;set;}
	public set<Id> selectedGroupIds {get;set;}
	public list<NewsEventWrapper> wrapperList {get;set;}
	public boolean hasItems{get{boolean flag = false;if(wrapperList != null){if(wrapperList.size() > 0){flag = true;}}return flag;}}
	public String schoolName {get;set;}
    public String schoolLogoURL {get;set;}
    public String studentName {get;set;}
	//for filter
	public list<SelectOption> termOptions {get;set;}
	public String selectedTermFilter {get;set;}
	
	public PortalNewsEvents_Controller(){
		initializeParameters();
	}
	
	private void initializeParameters(){ 
		fetchEventsWithOutDate =  true;
		//populate student list again
		studentList = new list<SelectOption>();
		studentList.add(new SelectOption('-','All'));
		studentIds =  new Set<Id>();
		studentGroupIdMap = new map<Id,set<Id>>();
		groupIdStudentMap = new map<Id,set<String>>();
		allStudentNames = new set<String>();
		allGroupIds = new set<Id>();
		list<Registration__c> rList = new list<Registration__c>();
		//for(Registration__c r:[Select r.Student__c,r.Student__r.Student_Name_in_Portal__c, r.Id, r.Group__r.Subject_Name__c, r.Group__r.Academic_Year__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__r.Id, r.Group__c, r.Active__c From Registration__c r where r.Student__r.Main_Parent_File__c=:parentAccountId  AND (r.Parents_Included_in_Community_Group__c = true OR r.Active__c = true) order by r.Student__r.FirstName]){
		for(Registration__c r:[Select r.Student__c,r.Student__r.Student_Name_in_Portal__c, r.Id, r.Group__r.Subject_Name__c, r.Group__r.Academic_Year__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__r.Id, r.Group__c, r.Active__c From Registration__c r where r.Student__r.Main_Parent_File__c=:parentAccountId  AND r.Parents_Included_in_Community_Group__c = true  order by r.Student__r.FirstName]){
        	allGroupIds.add(r.Group__c);
        	allStudentNames.add(r.Student__r.Student_Name_in_Portal__c);
        	if(!studentIds.contains(r.Student__c)){
        		studentList.add(new SelectOption(r.Student__c,r.Student__r.Student_Name_in_Portal__c));
        		studentIds.add(r.Student__c);
        		set<Id> groupIds = new set<Id>();
        		groupIds.add(r.Group__c);
        		studentGroupIdMap.put(r.Student__c,groupIds);
        	}else{
        		studentGroupIdMap.get(r.Student__c).add(r.Group__c);
        	}
        	//populate groupIdStudentMap
        	if(groupIdStudentMap.containsKey(r.Group__c)){
        		groupIdStudentMap.get(r.Group__c).add(r.Student__r.Student_Name_in_Portal__c);	
        	}else{
        		set<String> temp = new set<String>();
        		temp.add(r.Student__r.Student_Name_in_Portal__c);
        		groupIdStudentMap.put(r.Group__c,temp);
        	}
        }
		//populate from date
		termOptions = new list<SelectOption>();
		termOptions.add(new SelectOption('This Term','This Term'));
		termOptions.add(new SelectOption('This Year','This Year'));
		termOptions.add(new SelectOption('More','More'));
		selectedTermFilter = 'This Term';
		//fromDate = date.today();
		//toDate = date.today().addDays(14);
		//populate to date
		//fetch recent event date
		/*for(News_Events__c e:[select Id, Event_Start_Date__c from News_Events__c where Student_Group__c IN:allGroupIds AND Standard_Portal_Event__c = true order by Event_Start_Date__c desc limit 1]){
			toDate = e.Event_Start_Date__c;
			
		}
		if(toDate <= fromDate){
			toDate = null;
			
		}*/
		selectedStudentId = '-';
	}
	
	//function to search assessments
	public PageReference filterNewsEvents(){
		fromDate = null;
		toDate = null;
		createTabClickEvent('newsevents');
		
		wrapperList =  new List<NewsEventWrapper>();
		
		if(fromDate == null){
			fromDate = date.today();
		}
		
		System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**selectedStudentId='+selectedStudentId);
		System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**fromDate='+fromDate);
		System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**toDate='+toDate);		
		System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**schoolLogoMap='+schoolLogoMap);
		//set cookie to current selected student
		if(selectedStudentId != '-'){
			Cookie cookie_sid = new Cookie('sid', selectedStudentId,null,-1,false);
			ApexPages.currentPage().setCookies(new Cookie[]{cookie_sid});
		}
		//make list of assessment report types
		List<String> selectedReportTypes =  new List<String>();
		for(PortalReportFilter.ReportTypeWrapper rt:newsEventTypeOptions){
			if(rt.selected){
				//check for term / holidays 
				if(rt.reportTypeValue.contains(';')){
					list<string> slist = rt.reportTypeValue.split(';');
					for(string s:slist){
						selectedReportTypes.add(s.trim());
					}
				}else{
					selectedReportTypes.add(rt.reportTypeValue);
				}
			}
		}
		System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**selectedReportTypes='+selectedReportTypes);
		
		
		//fetch school name basis student selection
		if(selectedStudentId != null && selectedStudentId != '' && fromDate != null){
			if(selectedStudentId != '-'){
				schoolName = [Select c.Admissions_File__r.School__c, c.Admissions_File__r.Id, c.Admissions_File__c From Contact c where c.Id=:selectedStudentId].Admissions_File__r.School__c;
				System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**schoolName='+schoolName);
				studentName = [Select Name from Contact where Id=:selectedStudentId].Name;
				schoolLogoURL = schoolLogoMap.get(schoolName);
				System.debug('*****PortalNewsEvents_Controller**filterAsfilterNewsEventssessments**schoolLogoURL='+schoolLogoURL);
				//fetch student group Ids
				selectedGroupIds = studentGroupIdMap.get(selectedStudentId);
			}else if(selectedStudentId == '-'){
				selectedGroupIds = allGroupIds;
				studentName = 'All';
			}
			System.debug('*****PortalNewsEvents_Controller**filterNewsEvents**selectedGroupIds='+selectedGroupIds);
			//fetch news and events
			string query = 'Select n.Video_4_URL__c, n.Video_4_TITLE__c, n.Video_3_URL__c, n.Video_3_TITLE__c, n.Video_2_URL__c, n.Video_2_TITLE__c, n.Video_1_URL__c, n.Video_1_TITLE__c, n.Subtitle__c, n.Student_Group__c, n.School__c, n.RecordType.Name, n.RecordTypeId, n.OwnerId, n.Name, n.Main_Text__c, n.Link_3__c, n.Link_3_Title__c, n.Link_2__c, n.Link_2_Title__c, n.Link_1__c, n.Link_1_Title__c, n.Id, n.Event_Start_Month__c, n.Event_Start_Date__c, n.Event_End_Month__c, n.Event_End_Date__c, n.CreatedDate, n.Academic_Year__c From News_Events__c n where n.Student_Group__c IN:selectedGroupIds AND n.Standard_Portal_Event__c = true AND n.RecordType.Name IN:selectedReportTypes ';
			//if(!fetchEventsWithOutDate){
				/*if(fromDate != null){
					query += ' AND ( ( Event_Start_Date__c >=:fromDate) OR  (Event_End_Date__c != null AND Event_End_Date__c >=:fromDate)) ';				
				}
				if(toDate != null){
					query += ' AND (Event_Start_Date__c <=:toDate ) ';
				}*/
				if(selectedTermFilter != null){
					if(selectedTermFilter == 'This Term'){
						query += ' AND Is_This_Term_Record__c  = true ';
					}else if(selectedTermFilter == 'This Year'){
						query += ' AND Is_This_Year_Record__c  = true ';
					}else if(selectedTermFilter == 'More'){
						query += ' AND Is_More_Date__c   = true ';
					}
				}
				
				query += 'order by Sort_Order__c asc limit 100';
				
				
			/*}else if(fetchEventsWithOutDate){
				query += 'order by Event_Start_Date__c asc limit 20';
				fetchEventsWithOutDate = false;
			}*/
			set<Id> fetchedRecordIds = new set<Id>();
			for(News_Events__c ne:Database.query(query)){			
				string rType  ;
				if(ne.RecordType.Name == 'Term' || ne.RecordType.Name == 'Holiday'){
					rType = 'Term / Holidays';
				}else if(ne.RecordType.Name == 'Event'){
					rType = 'Events';
				}
				else if(ne.RecordType.Name == 'Notice'){
					rType = 'Notices';
				}
				if(rType != null){
					//check for students names
                    string studentNamesString = '';
                    set<String> studentNameSet = groupIdStudentMap.get(ne.Student_Group__c);
                    if(studentNameSet != null){
                    	if(allStudentNames.size() > 1){
	                    	//if(studentNameSet.size() == allStudentNames.size() ){
	                    		//studentNamesString = 'All Students';
	                    	//}else{
	                    		for(String s:studentNameSet){
	                    			if(studentNamesString == ''){
	                    				studentNamesString = s;
	                    			}else{
	                    				studentNamesString += ', '+s;
	                    			}
	                    		}
	                    	//}
                    	}
                    }
					wrapperList.add(new NewsEventWrapper(ne,rType,wrapperList.size(),studentNamesString));	
					fetchedRecordIds.add(ne.Id);
				}
			}
			//fetch images
			if(fetchedRecordIds.size() > 0){
				//fetch attachments
				map<Id,list<Attachment>> imageMap = new map<Id,list<Attachment>>();
				for(Attachment a:[Select a.ParentId, a.Name, a.Id, a.ContentType From Attachment a where a.ParentId IN:fetchedRecordIds AND a.ContentType like 'image%' order by CreatedDate desc]){
					if(imageMap.containsKey(a.ParentId)){
						imageMap.get(a.ParentId).add(a);	
					}else{
						list<Attachment> aList = new list<Attachment>();
						aList.add(a);
						imageMap.put(a.ParentId,aList);
					}
				}
				for(NewsEventWrapper w:wrapperList){
					for(Id neId:imageMap.keySet()){
						if(neId == w.newsEvent.Id){
							for(Attachment a:imageMap.get(neId)){
								w.imageURLs.add(new ImageWrapper('/parents/servlet/servlet.FileDownload?file='+a.Id,null));
							}
						}
					}
				}
			}
		}	
		return null;
	}
	/*
	public PageReference handleStudentChange(){
		return null;
	}
	public PageReference handleFromDateChange(){
		return null;
	}
	public PageReference handleToDateChange(){
		return null;
	}
	public PageReference handleReportTypeChange(){
		return null;
	}
	*/
	
	
	//wrapper class for news and event data
	public class NewsEventWrapper{
        public News_Events__c newsEvent {get;set;}
        public String reportType {get;set;}
        public Integer index {get;set;}
        public Integer rt {get;set;}
        public string css_class {get;set;}
        public string title {get;set;}
        public string teaser {get;set;}
        public string mainText {get;set;}
        public string studentString {get;set;}
        public string eventStartDateMonth{
        	get{
        		return newsEvent.Event_Start_Month__c;
        	}
        }
        public string eventStartDateDay{
        	get{
        		string s = '';
        		if(newsEvent.Event_Start_Date__c != null){
	        		integer day = newsEvent.Event_Start_Date__c.day();
					if(day < 10){
						s += '0'+day;
					}else{
						s += ''+day;
					}
        		}
				return s;
        	}
        }
         public string eventEndDateMonth{
        	get{
        		return newsEvent.Event_End_Month__c;
        	}
        }
        public string eventEndDateDay{
        	get{
        		string s= '';
        		if(newsEvent.Event_End_Date__c != null){
	        		integer day = newsEvent.Event_End_Date__c.day();
					if(day < 10){
						s += '0'+day;
					}else{
						s += ''+day;
					}
        		}
        		return s;
        	}
        }
        public list<ImageWrapper> imageURLs {get;set;}
        public boolean showMainContent{get{
        	boolean flag = true;
        	if(newsEvent.Main_Text__c == null && imageURLs.size() == 0){
        		flag = false;
        	}
        	return flag;
        }}
        
        public boolean showImageSection{get{
        	boolean flag = true;
        	if(imageURLs.size() == 0){
        		flag = false;
        	}
        	return flag;
        }}
        
        public NewsEventWrapper(News_Events__c ne,String rtype,Integer i, string snamesStr){
            studentString = snamesStr;
            newsEvent = ne;
            index = i+1;
            reportType = rtype;
            if(reportType.equalsIgnoreCase('Term / Holidays')){
            	rt = 1;
            	css_class = 'month term';
            }else if(reportType.equalsIgnoreCase('Events')){
            	rt = 2;
            	css_class = 'month event';
            }else if(reportType.equalsIgnoreCase('Notices')){
            	rt = 4;
            	css_class = 'month reminder';
            }
            //populate variables
            title = newsEvent.Name;
            teaser = newsEvent.Subtitle__c;
            mainText = newsEvent.Main_Text__c;
            //populate imageURLs
            imageURLs = new list<ImageWrapper>();
            /*
            if(newsEvent.Link_1__c != null){imageURLs.add(new ImageWrapper(newsEvent.Link_1__c,newsEvent.Link_1_Title__c));}
            if(newsEvent.Link_2__c != null){imageURLs.add(new ImageWrapper(newsEvent.Link_2__c,newsEvent.Link_2_Title__c));}
            if(newsEvent.Link_3__c != null){imageURLs.add(new ImageWrapper(newsEvent.Link_3__c,newsEvent.Link_3_Title__c));}            
        	*/
        	
        }
    }
    
    public class ImageWrapper{
    	public string linkName{get;set;}
    	public string linkURL{get;set;}
    	public ImageWrapper(string u, string l){
    		linkURL = u;
    		if(l == null){
    			linkName = '';
    		}else{
    			linkName = l;
    		}
    	}
    }
	
	
}