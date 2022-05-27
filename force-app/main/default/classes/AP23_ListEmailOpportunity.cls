/**
 * @File Name          : AP23_ListEmailOpportunity.cls
 * @Description        : - Get opportunity Id,
                         - Get Account related Id.
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : ZHR
 * @Last Modified On   : 10/07/2019, 19:07:21
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author                    Modification
 *==============================================================================
 * 1.0    10/07/2019, 14:59:46           ZHR                     Initial Version
**/

public class AP23_ListEmailOpportunity {
    private ApexPages.StandardSetController standardSetController;
    public string accIdStr{get;set;}
    public string oppIdStr{get;set;}
    public AP23_ListEmailOpportunity(ApexPages.StandardSetController standardSetController)
    {
        this.standardSetController = standardSetController;
        accIdStr = '';
    }
    
    public PageReference doSomething()
    {
        // Apex code for handling records from a List View goes here
        List<Opportunity> selectedListViewRecords = (List<Opportunity>) standardSetController.getSelected();
        
        Boolean hasMore = standardSetController.getHasNext();
        if(selectedListViewRecords.size()>0){
            list<string> accIds = new list<string>();
            list<string> oppIds = new list<string>();
            for(Opportunity oppRec : [select id, accountId from Opportunity WHERE Id IN: selectedListViewRecords]){
                accIds.add(oppRec.accountId);
                oppIds.add(oppRec.Id);
            }
            accIdStr = accIds.size()>0 ? String.join(accIds, ',') : '';
            oppIdStr= oppIds.size()>0 ? String.join(oppIds, ',') : '';
        }
        
        
        
        system.debug('---selectedListViewRecords ---' + selectedListViewRecords.size());
        system.debug('---accountId related ---' + accIdStr);
        system.debug('---Opportunity id  ---' + oppIdStr);
        return null;
    }
}