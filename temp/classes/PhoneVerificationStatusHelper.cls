global with sharing class PhoneVerificationStatusHelper {

global class VerificationStatusRequest{

       @InvocableVariable(required=false)
    public String phone;
    @InvocableVariable(required=false)
    public String apiKey;
     @InvocableVariable(required=false)
    public String verificationCode;
        
}

global class VerificationStatusResponse{
     @InvocableVariable(required=false)
    public String message;
    @InvocableVariable(required=false)
    global Boolean status;
   @InvocableVariable(required=false)
    global String debugInfo;
}

public class VerificationStatus {
        public String message;
        public String status;
}

@InvocableMethod(label='PhoneVerificationStatus')
global static List<VerificationStatusResponse> PhoneVerificationStatus(List<VerificationStatusRequest> requests)
{
    List<VerificationStatusResponse> oList = new List<VerificationStatusResponse>();
    
    String authykey = PhoneVerificationSettings.getAuthyKey();
    
    String payLoad =  '?phone_number=' + requests[0].phone + '&verification_code=' + requests[0].verificationCode +'&country_code=1';
   
    String url = 'https://api.authy.com/protected/json/phones/verification/check'+ payLoad;
   
    
    VerificationStatusResponse o = new VerificationStatusResponse();
    o.status = false;
    o.debugInfo = url;
    
    try{
    
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
         request.setHeader('X-Authy-API-Key', authykey);
        request.setMethod('GET');
              
        Http http = new Http();
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
           
            o.message = response.getBody();
            
        } else {
            System.debug(response.getBody());
            // Parse the data according to the AccountList class
            VerificationStatus data = (VerificationStatus)JSON.deserialize(response.getBody(), VerificationStatus.class);
            o.status = true;
            
            o.message = response.getBody();
        }
        
    }catch(Exception e){
        System.debug('VerifyPhone Error:' + e);
    }
    
     
   
    oList.add(o);
    
    return oList;
}

}