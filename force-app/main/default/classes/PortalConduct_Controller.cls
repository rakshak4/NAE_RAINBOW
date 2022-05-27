public class PortalConduct_Controller extends PortalReportFilter{
	public Integer awards {get;set;}
	public Integer pastoral {get;set;}
	public Integer leadership {get;set;}
	public decimal housePoints {get;set;}
	public String schoolName {get;set;}
	public List<ConductWrapper> conductWrapperList {get;set;}
	public boolean hasItems{get{boolean flag = false;if(conductWrapperList != null){if(conductWrapperList.size() > 0){flag = true;}}return flag;}}
	//function to search attendances
	public PageReference filterConducts(){
		createTabClickEvent('pastoral');
		awards = 0;
		pastoral = 0;
		leadership = 0;
		housePoints = 0;
		conductWrapperList =  new List<ConductWrapper>();		
		System.debug('*****PortalConduct_Controller**filterConducts**selectedStudentId='+selectedStudentId);
		System.debug('*****PortalConduct_Controller**filterConducts**selectedAcademicYear='+selectedAcademicYear);
		System.debug('*****PortalConduct_Controller**filterConducts**conductTypeOptions='+conductTypeOptions);
		//set cookie to current selected student
		Cookie cookie_sid = new Cookie('sid', selectedStudentId,null,-1,false);
		ApexPages.currentPage().setCookies(new Cookie[]{cookie_sid});
		//make list of assessment report types
		List<String> selectedReportTypes =  new List<String>();
		for(PortalReportFilter.ReportTypeWrapper rt:conductTypeOptions){
			if(rt.selected){
				selectedReportTypes.add(rt.reportType);
			}
		}
		//fetch school name basis student selection
		if(selectedStudentId != null && selectedStudentId != '' && selectedAcademicYear != null && selectedAcademicYear != ''){
			schoolName = [Select c.Admissions_File__r.School__c, c.Admissions_File__r.Id, c.Admissions_File__c From Contact c where c.Id=:selectedStudentId].Admissions_File__r.School__c;	
			//fetch user infiormation
			//fetch assessments
			Set<Id> ownerIds =  new Set<Id>();
			Map<Id,User> userMap =  new Map<Id,User>();
			for(Conduct__c conduct:[Select c.Display_Date__c, c.CreatedById  From Conduct__c c where c.Academic_Year__c=:selectedAcademicYear AND c.Student_Name__c=:selectedStudentId AND c.RecordType.Name IN:selectedReportTypes AND c.Display_In_Portal__c = true]){
				ownerIds.add(conduct.CreatedById );
			}
			for(User u:[Select u.Email_Copy__c,u.Title, u.Title_Copy__c , u.SmallPhotoUrl, u.School__c, u.Name, u.LastName, u.IsActive, u.Id, u.FullPhotoUrl, u.FirstName, u.Email, u.Division, u.Department, u.ContactId, u.Alias, u.AboutMe From User u  where u.Id IN:ownerIds]){
				userMap.put(u.Id,u);
			}
			//fetch conduct records 
			for(Conduct__c c:[Select c.Display_Date__c, c.Effort__c ,c.Display_Header__c, c.Display_Title__c, c.Pastoral_Date__c, c.Owner_Title__c, c.Title__c, c.Student_Name__c, c.RecordType.Name, c.RecordTypeId, c.Reason__c, c.Private_Comment__c, c.Name, c.House__c, c.House_Points__c, c.Health_Related__c,  c.CreatedDate, c.CreatedById,  c.Academic_Year__c From Conduct__c c where c.Academic_Year__c=:selectedAcademicYear AND c.Student_Name__c=:selectedStudentId AND c.RecordType.Name IN:selectedReportTypes AND c.Display_In_Portal__c = true order by Pastoral_Date__c desc]){
				String reportType ;
				String comments ;
				String title;
				String titleDescription ; 
				Integer points = 0;
		        String userInfo_Name ;
		        String userInfo_Title ;
		        String userInfo_Email ;
		        String userInfo_PicURL ;
		        System.debug('***PortalConduct_Controller***filterConducts***c='+c);
				title = c.Display_Header__c;
				titleDescription = c.Display_Title__c;
				if(c.RecordType.Name.equalsIgnoreCase('Achievements')){
					awards++;
					
					comments = c.Reason__c;
					reportType = 'Achievements';
				}else if(c.RecordType.Name.equalsIgnoreCase('Incidents')){
					pastoral++;
					
					comments = c.Reason__c;
					reportType = 'Incidents';
					points = 1;
				}/*else if(c.RecordType.Name.equalsIgnoreCase('Leadership Roles')){
					leadership++;
					title = 'Leadership Roles';
					titleDescription = c.Title__c;
					comments = c.Reason__c;
					reportType = 'Leadership Roles';
				}*/else if(c.RecordType.Name.equalsIgnoreCase('Effort & Attitude')){
					if(c.House_Points__c != null){
						housePoints += c.House_Points__c;
					}
					
					comments = c.Reason__c;
					reportType = 'Effort & Attitude';
				}
				System.debug('***PortalConduct_Controller***filterConducts***title='+title);
				userinfo_Name =  userMap.get(c.CreatedById).Name;
				userinfo_Email =  userMap.get(c.CreatedById).Email_Copy__c;
				if(c.Owner_Title__c != null && c.Owner_Title__c != ''){
					userinfo_Title =  c.Owner_Title__c;
				}else{
					userinfo_Title =  userMap.get(c.CreatedById).Title_Copy__c;
				}
				
				userInfo_PicURL =  userMap.get(c.CreatedById).SmallPhotoUrl;
				
				ConductWrapper cw =  new ConductWrapper(c,reportType,comments,title,titleDescription,c.Pastoral_Date__c,userinfo_Name,userinfo_Email,userinfo_Title,userInfo_PicURL,conductWrapperList.size());
				conductWrapperList.add(cw);
			}
		}
		return null;
	}
	 
	//function to search attendances
	public PageReference reset(){
		PageReference pg = Page.PortalConductPage;
		pg.setRedirect(true);
		return pg;
	}
	
	public class ConductWrapper{
		public Conduct__c conduct{get;set;}  
        public String rType {get;set;}
        public String title1 {get;set;}
        public String titleDescription1 {get;set;}
        public String comments {get;set;}
        public Integer points {get;set;}
        public String dateString {get;set;}
        public String userInfo_Name {get;set;}
        public String userInfo_Title {get;set;}
        public String userInfo_Email {get;set;}
        public String userInfo_PicURL {get;set;}
        public Integer index {get;set;}
        public Integer rt {get;set;}
        public ConductWrapper(Conduct__c cd, String recordType,String c,String t, String td,Date d,String name, String email, String title, String pic, Integer i){
            conduct = cd;
            rType = recordType;
            comments = c;
            title1 = t;
            titleDescription1 = td;
            /*if(d != null){
            	dateString =  d.format();
            }else{
            	dateString = (date.valueOf(cd.CreatedDate)).format();
            }*/
            dateString = cd.Display_Date__c;     
            userInfo_Name = name;
            userInfo_Title = title;
            userInfo_Email = email;
            userInfo_PicURL = pic;            
            index = i+1;
            if(rType.equalsIgnoreCase('Incidents')){
            	rt = 4;
            }else if(rType.equalsIgnoreCase('Achievements')){
            	rt = 2;
            }/*else if(rType.equalsIgnoreCase('Leadership Roles')){
            	rt = 3;
            }*/else if(rType.equalsIgnoreCase('Effort & Attitude')){
            	rt = 1;
            } 
        }
    } 
}