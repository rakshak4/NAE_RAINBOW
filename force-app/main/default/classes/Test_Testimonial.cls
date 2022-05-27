@isTest
private class Test_Testimonial{
	static testMethod void  testTestimonialDelete(){
		Testimonial__c t = new Testimonial__c();
		insert t;
		try{
			delete t;
		}catch(Exception e){
			
		}
	}
}