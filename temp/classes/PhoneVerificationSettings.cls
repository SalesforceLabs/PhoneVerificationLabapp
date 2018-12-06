public with sharing class PhoneVerificationSettings {

public PhoneVerificationSettings(){
}

public static String getAuthyKey() {
       
    String authykey = 'NOT_FOUND';    
    try {
        
       List<phoneverify__PhoneVerifySettings__c> o = [select Id, phoneverify__authykey__c from phoneverify__PhoneVerifySettings__c];
       
       if(o.size() > 0){
           authykey = o[0].phoneverify__authykey__c;
           
       }
        
    } catch(Exception e) {
        System.debug(LoggingLevel.INFO, 'PhoneVerificationSettings getAuthyKey exception:' + e);
        
    }
    
    return authykey;
}


}