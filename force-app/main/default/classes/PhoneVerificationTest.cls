@isTest
global class PhoneVerificationTest  {
 
@isTest
global static void testInitiatePhoneVerification() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
    
    try{
        List<PhoneVerificationHelper.VerificationRequest> requests = new List<PhoneVerificationHelper.VerificationRequest>();
        PhoneVerificationHelper.VerificationRequest o = new PhoneVerificationHelper.VerificationRequest();
        
        o.phone = '6313393998';
        o.apiKey = 'XYZ';
        
        requests.add(o);
        
        List<PhoneVerificationHelper.VerificationResponse> res = PhoneVerificationHelper.VerifyPhone(requests);
        
        System.assertEquals(true, res[0].status);
        
        System.debug('res=' + res);
    }catch(Exception e){
        System.debug('testPostCallout exception=' + e);
    }
    
}

@isTest
global static void testPhoneVerificationStatus() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new TwilioHttpCalloutMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
    
    try{
        List< PhoneVerificationStatusHelper.VerificationStatusRequest> requests = new List< PhoneVerificationStatusHelper.VerificationStatusRequest>();
        PhoneVerificationStatusHelper.VerificationStatusRequest o = new PhoneVerificationStatusHelper.VerificationStatusRequest();
        
        o.phone = '6313393998';
        o.apiKey = 'XYZ';
        o.verificationCode = '1234';
        
        requests.add(o);
        
        List< PhoneVerificationStatusHelper.VerificationStatusResponse> res = PhoneVerificationStatusHelper.PhoneVerificationStatus(requests);
        
        System.assertEquals(false, res[0].status);
        
        System.debug('res=' + res);
    }catch(Exception e){
        System.debug('testPostCallout exception=' + e);
    }
    
}

@isTest
global static void testCustomSettingUpdateVF() {
    // Set mock callout class 
    
    try{
       
      //  PageReference pageRef = Page.success;
        //Test.setCurrentPage(pageRef);
      
        CmdSettings controller = new CmdSettings();
        CmdSettings.authykey = 'dummy';
        controller.save();
             
        //System.assertEquals(false, res[0].status);
        
        //System.debug('res=' + res);
    }catch(Exception e){
        System.debug('testCustomSettingUpdateVF exception=' + e);
    }
    
}

}