public with sharing class ContactPhotoUpdateController {
	public Contact con {get;set;}
	public blob fileBody {get;set;}
	public transient Attachment attachment {get;set;}
	public String fileName {get;set;}
	public String contentType {get;set;}
	public Integer fileSize {get;set;}
	private Integer maxSize_Bits = 1048576;
    public ContactPhotoUpdateController(ApexPages.StandardController controller) {
		con = [select Id, Name , Photo_Attachment_Id__c,Contact_Photo_URL__c from Contact where Id=:controller.getId()];
    	
    }
	public PageReference saveAttachment(){
    	try{
	    	if(fileName != null && contentType != null){
		    	
		    	if(validate()){
		    		return null;
		    	}else{
		    		deleteExistingImage();
		    		attachment = new Attachment();
					attachment.ParentId = con.Id;
		    		attachment.Name = fileName;
		    		attachment.Body = fileBody;
		    		
		    		insert attachment;
		    		Id attachmentId = attachment.Id;
		    		
		    		con.Photo_Attachment_Id__c = attachmentId;
		    		update con;
		    		
		    		
		    		
		    		PageReference pg = new PageReference('/'+con.Id);
					return pg;
		    		
		    	}
	    	}else{
	    		ApexPages.Message errorMessage1 = new ApexPages.Message(ApexPages.severity.FATAL, 'No file selected.');
				ApexPages.addMessage(errorMessage1);
	    	}
    	}catch(Exception e){
    		ApexPages.Message errorMessage1 = new ApexPages.Message(ApexPages.severity.FATAL, 'Error Uploading File: '+e.getMessage());
			ApexPages.addMessage(errorMessage1);
    	}finally{
    		fileBody = null;
    		attachment = null;
    	}
    	
    	return null;
    }
    
    private boolean validate(){
    	boolean flag = false;
    	string errorMessage ;
    	set<string> contentImageTypes =  new set<string>();
    	contentImageTypes.add('image/gif');
    	contentImageTypes.add('image/jpeg');
    	contentImageTypes.add('image/jpg');
    	contentImageTypes.add('image/pjpeg');
    	contentImageTypes.add('image/png');
    	
    	if(filebody == null || fileName == null){
    		errorMessage = 'No image file provided.';
    		flag = true;
    	}else if(!contentImageTypes.contains(contentType)){
    		errorMessage = 'Provide file is not an image.';
    		flag = true;
    	}else if(fileSize > maxSize_Bits){
    		errorMessage = 'You can not uplaod photo more than 1 MB in size.';
    		flag = true;
    	}
    	if(flag){
    		ApexPages.Message errorMessage1 = new ApexPages.Message(ApexPages.severity.FATAL, errorMessage);
			ApexPages.addMessage(errorMessage1);	
    	}
    	return flag;
    }
    
    private void deleteExistingImage(){
    	if(con.Photo_Attachment_Id__c != null){
    		try{
    			Attachment a = new Attachment(Id=con.Photo_Attachment_Id__c);
    			delete a;
    			con.Photo_Attachment_Id__c = null;
    			update con;
    		}catch(Exception e){
    			//do nothing
    		}
    	}
    }
    
    public PageReference deletePhoto(){
    	deleteExistingImage();
    	return cancel();
    }
    
    //page reference function
	public PageReference cancel(){
		PageReference pg = new PageReference('/'+con.Id);
		return pg;
	}
    
}