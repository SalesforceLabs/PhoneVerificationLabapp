public with sharing class CmdSettings {

public Static String authykey {get; set;}

public CmdSettings(){
}

public PageReference save() {
        
    try {
        
       List<phoneverify__PhoneVerifySettings__c> o = [select Id, phoneverify__authykey__c from phoneverify__PhoneVerifySettings__c];
       
       if(o.size() > 0){
           o[0].phoneverify__authykey__c = authykey;
           upsert o[0];
       }else{
           phoneverify__PhoneVerifySettings__c newo = new phoneverify__PhoneVerifySettings__c();
           newo.phoneverify__authykey__c = authykey;
           insert newo;
       }
        
       apexpages.addMessage(new ApexPages.message(Apexpages.Severity.INFO,'authykey updated!'));
        
    } catch(Exception e) {
        ApexPages.addMessages(e);
        
    }
    
    return null;
}


}