/**
 * @File Name          : AP33_ContractRules.cls
 * @Description        : Contract Rules
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 22-NOV-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    22-NOV-2021, 10:00 am         FKH         Initial Version
**/
public with sharing class AP33_ContractRules {
    
    private static Map<Id,Id> mapGrandChildtoParent = new Map<Id,Id>();
    private static Map<Id,Id> mapOnlyTopParent = new Map<Id,Id>();
    private static Set<Id> allAccIdsForRegSeach = new Set<Id>();    // all accounts impacted
  
    //method to get all child and parent relationship, excluding single & top most account
    public static Map<Id,List<Account>> getTopMostParentWithAllChildren(Map<Id,Id> mapAccTopParen){
        Map<Id,List<Account>> mapParentChild = new Map<Id,List<Account>>();
        List<Account> getAllAcc = [Select id,parentid,parents__c from account where parents__c in: mapAccTopParen.values() or parentid in: mapAccTopParen.values()];

        for(Account acc: getAllAcc ){ //get all the children
            allAccIdsForRegSeach.add(acc.id);   
            List<Account> lstChildrenTemp = new List<Account>(); 

            if(id.valueOf(acc.parents__c)==acc.parentid){   //parent 2nd level in a 3 level hierarchy
                    if(mapParentChild.get(acc.parentId)!=null && mapParentChild.containsKey(acc.parentId)){
                        lstChildrenTemp = mapParentChild.get((acc.parentId));
                    }
                lstChildrenTemp.add(acc);
                mapParentChild.put(acc.ParentId,lstChildrenTemp);
            }
            if((id.valueOf(acc.parents__c)!=acc.parentid && acc.parents__c != null) ||(acc.parents__c != null && id.valueOf(acc.parents__c)==acc.parentid ) ){ //child
                mapGrandChildtoParent.put(acc.id,acc.parentid); //set child & parent relationships
                    if(mapParentChild.get(id.valueOf(acc.parents__c))!=null && mapParentChild.containsKey(id.valueOf(acc.parents__c))){
                        lstChildrenTemp = mapParentChild.get(id.valueOf(acc.parents__c));
                    }
                lstChildrenTemp.add(acc);
                mapParentChild.put(id.valueOf(acc.parents__c),lstChildrenTemp);
            }
        }
        System.debug('mapParentChild :'+ mapParentChild);
        System.debug('mapGrandChildtoParent :'+ mapGrandChildtoParent);

        return mapParentChild;
    }

    //method to update map containing region, combine regions based on child regions in hierarchy
    public static Map <Id, Set<String>> populateMapUpdateRegions (Map <Id, Set<String>> mapAccIdRegions){
        Map <Id, Set<String>> mapAccIdUpdateRegions = new Map <Id, Set<String>>();
        Set<String> setGrandChildReg;
        Id parent;
        Set<String> setParentReg;
        Set<String> setNewParent;
        Set<String> existingRegParent;

        for (Id grandChildId : mapGrandChildtoParent.keySet()){
            setGrandChildReg = mapAccIdRegions.get(grandChildId);
            parent = mapGrandChildtoParent.get(grandChildId);

            if(setGrandChildReg!=null){ // if child has a region
                setParentReg = mapAccIdRegions.get(parent);
                setNewParent = new Set<String>();
                existingRegParent = mapAccIdUpdateRegions.get(parent);

                if (setNewParent!=null && setParentReg!=null) setNewParent.addAll(setParentReg);
                if (setGrandChildReg!=null && setNewParent!=null) setNewParent.addAll(setGrandChildReg); //combined region              
                if (setNewParent!= null && existingRegParent!=null) setNewParent.addAll(existingRegParent);

                mapAccIdUpdateRegions.put(parent,setNewParent);
                if(mapAccIdUpdateRegions.get(grandChildId)==null) mapAccIdUpdateRegions.put(grandChildId,setGrandChildReg);   //add grand child

            }   
            else if(setParentReg!=null){ // child with no region - let parent keep its values
                setParentReg = mapAccIdRegions.get(parent);
                existingRegParent = mapAccIdUpdateRegions.get(parent);

                if (existingRegParent!=null && setParentReg!=null) setParentReg.addAll(existingRegParent);
                mapAccIdUpdateRegions.put(parent,setParentReg);
            }
            else{
                    if(mapAccIdUpdateRegions!=null && mapAccIdUpdateRegions.get(parent)!=null) {
                        setParentReg = mapAccIdUpdateRegions.get(grandChildId);
                        mapAccIdUpdateRegions.put(grandChildId,setParentReg); // add parent
                    } 
                    else if (mapAccIdUpdateRegions!=null && mapAccIdUpdateRegions.get(parent)==null){
                        setParentReg = mapAccIdUpdateRegions.get(grandChildId);
                        mapAccIdUpdateRegions.put(parent,setParentReg); // add parent
                    }
                }            
        }

        System.debug('mapAccIdUpdateRegions in function:'+mapAccIdUpdateRegions);
        return mapAccIdUpdateRegions;
    }

    // method to update topmost or singular parent: based on all children
    public static Map<Id,Set<String>> setTopParentRegion(Map<Id,List<Account>> mapParentChild,Map <Id, Set<String>> mapAccIdRegions, Map <Id, Set<String>> mapAccIdUpdateRegions){
        Set <String> setCombineReg;
        Set <String> setCurrentAccReg;
        Set <String> setTopMostAccReg;
        List <Account> updatedChildren;

        for(Id topAccId: mapParentChild.keySet()){  //ensure parents are populated at last - with all combined regions of their children
                updatedChildren = mapParentChild.get(topAccId);
                setCombineReg = new Set<String> ();
                setCurrentAccReg = new Set<String> ();
                setTopMostAccReg = mapAccIdRegions.get(topAccId);
                
                for(Account acc: updatedChildren){
                    setCurrentAccReg = mapAccIdUpdateRegions.get(acc.id);
                    if(setCurrentAccReg!=null && setCombineReg!=null ) setCombineReg.addAll(setCurrentAccReg);
                }

                if(setTopMostAccReg!=null && setCombineReg!=null) setCombineReg.addAll(setTopMostAccReg);
                mapAccIdUpdateRegions.put(topAccId,setCombineReg);
        }

        return mapAccIdUpdateRegions;
    }

    public static void updateAccountSpecificRegions(List <Contract> lstContracts){
        Set<ID> setAccountTrigger = new Set<ID>(); 
        Set<Id> setTriggeredAccount = new Set<id>();
        Map <Id, Set<String>> mapAccIdRegions = new Map <Id, Set<String>>(); // all account with their associated active contracts
        Map <Id, Set<String>> mapAccIdRegionsToUpdate = new Map <Id, Set<String>>();
        Map <Id, Id> mapAccTopParen = new Map <Id, Id>();
        List<String> lstTechAccountParents;
        Map<Id,List<Account>> mapParentChild;   //top mostparent -> all children below
        Map <Id, Set<String>> mapAccIdUpdateRegions;

        for(Contract con: lstContracts){ //cater for null top acc later
            if(con.TechAccountParents__c==null){    //no parents - topmost in hierarchy or single account with no parents
                setTriggeredAccount.add(con.accountid);
                allAccIdsForRegSeach.add(con.accountid);//accounts to query
                mapAccTopParen.put(con.AccountId, con.AccountId); // acc with the top level account with itself
            } 
            else{ // hierarchy present
                lstTechAccountParents = con.TechAccountParents__c.split(',');   // all parent ids on the account
                if(lstTechAccountParents.size()>0){ // first value = top most 
                    allAccIdsForRegSeach.add((id.valueOf(lstTechAccountParents[0])).to15());
                    mapAccTopParen.put(con.AccountId, ((id.valueOf(lstTechAccountParents[0])).to15())); // acc with the top level account
                }   
                if(lstTechAccountParents.size()>1){// second value = top most
                    mapAccTopParen.put(con.AccountId, (id.valueOf(lstTechAccountParents[1])).to15()); // acc with the top level account
                    allAccIdsForRegSeach.add((id.valueOf(lstTechAccountParents[1])).to15());
                }   
            }
        }

        mapParentChild = getTopMostParentWithAllChildren(mapAccTopParen);
        mapAccIdRegions = getAllAccountContracts (allAccIdsForRegSeach);    //get all contracts
        mapAccIdUpdateRegions = populateMapUpdateRegions(mapAccIdRegions);
        setTopParentRegion(mapParentChild,mapAccIdRegions,mapAccIdUpdateRegions);

        for(Id singleAccId: setTriggeredAccount){    // Topmost parent or singular account regions filled if contract trigger occurs on topmost parent only - no child impacted
            Set<String> setSingleParReg = mapAccIdRegions.get(singleAccId);

            if(mapParentChild==null || (mapParentChild!=null && !mapParentChild.containsKey(singleAccId)) ){ // if triggerred contract is on topmost parent
                mapAccIdUpdateRegions.put(singleAccId,setSingleParReg);
            } 
        }

        List<Account> lstUpdateAcc = [SELECT id, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from account where id in: allAccIdsForRegSeach];
        Set<String> setTopMostReg;  

        for(Account acc:lstUpdateAcc ){
            setTopMostReg  = mapAccIdUpdateRegions.get(acc.id);
            acc.EuropeActiveContract__c =  (setTopMostReg!=null && setTopMostReg.contains('Europe')) ? true :false;
            acc.MiddleEastActiveContract__c = (setTopMostReg!=null && setTopMostReg.contains('Middle East')) ? true :false;
            acc.SouthEastAsiaActiveContract__c = (setTopMostReg!=null && setTopMostReg.contains('South East Asia')) ? true :false;
            acc.TheAmericasActiveContract__c = (setTopMostReg!=null && setTopMostReg.contains('The Americas')) ? true :false;
            acc.ChinaActiveContract__c =  (setTopMostReg!=null && setTopMostReg.contains('China')) ? true :false;
            acc.IndiaActiveContract__c =  (setTopMostReg!=null && setTopMostReg.contains('India')) ? true :false;
        }

        if(lstUpdateAcc.size()>0) update lstUpdateAcc;
    }

    //method to get all active contracts
    public static Map<Id, Set<String>> getAllAccountContracts(Set<Id> AccId){
        Set<String> lstRegions = new Set<String>();
        Map <Id, Set<String>> mapAccIdRegions = new Map <Id, Set<String>>();
        Set<String> lstRegionCopy = new Set<String>();

        for(Contract Con:[Select id, region__c,accountid from Contract Where accountid IN: AccId and region__c!=null and status='Activated'] ){
            if(mapAccIdRegions.size()==0 || !mapAccIdRegions.containsKey(con.accountid)){
                lstRegions.add(con.region__c); 
            }
            else {  //if (mapAccIdRegions.containsKey(con.accountid))
                lstRegions = mapAccIdRegions.get(con.AccountId);
                lstRegions.add(con.region__c);      
            }     
            lstRegionCopy = lstRegions.clone();
            mapAccIdRegions.put(con.accountid,lstRegionCopy); 
            lstRegions.clear();   
        }

        return mapAccIdRegions;
    }

}