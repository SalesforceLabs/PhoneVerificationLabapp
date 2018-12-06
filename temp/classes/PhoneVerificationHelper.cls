global with sharing class PhoneVerificationHelper {

global class VerificationRequest{
    @InvocableVariable(required=false)
    public String phone;
    @InvocableVariable(required=false)
    public String apiKey;
    
}

global class VerificationResponse{
     @InvocableVariable(required=false)
    public String message;
    @InvocableVariable(required=false)
    global Boolean status;
   
}

    
@InvocableMethod(label='VerifyPhone')
global static List<VerificationResponse> VerifyPhone(List<VerificationRequest> requests)
{
    List<VerificationResponse> oList = new List<VerificationResponse>();

String url = 'https://api.authy.com/protected/json/phones/verification/start';

String authykey = PhoneVerificationSettings.getAuthyKey();

String payLoad = 'api_key=' + authykey +'&phone_number=' + requests[0].phone + '&via=sms&country_code=1';

VerificationResponse o = new VerificationResponse();
o.status = true;
   
try{

    HttpRequest request = new HttpRequest();
    request.setEndpoint(url);
    request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setHeader('X-Authy-API-Key', authykey);

    request.setMethod('POST');
    
    request.setBody(payLoad);
          
    Http http = new Http();
    HttpResponse response = http.send(request);
    // Parse the JSON response
    if (response.getStatusCode() != 200) {
        System.debug('The status code returned was not expected: ' +
                     response.getStatusCode() + ' ' + response.getStatus());
        o.status = false;
    } else {
        System.debug(response.getBody());
        o.status = true;
    }
    
}catch(Exception e){
    System.debug('Error:' + e);
}

    
    oList.add(o);
    
    return oList;
}

}