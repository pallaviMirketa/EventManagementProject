@RestResource(urlMapping='/createSpeaker/*')
global with sharing class createSpeakerRecord {
    @HttpPost
    global static String doPost(String name, String email, String phone, String company) {
        Speaker__c speakerob = new Speaker__c();
        speakerob.Name= name;
        speakerob.Phone__c= phone;
        speakerob.E_mail__c=email;
        speakerob.Company__c=company; 

        try{
            RestResponse res = RestContext.response;
            res.statusCode=200;
            insert speakerob;
            System.debug('speakerob: '+speakerob);
            return 'Success';
            
    }
    catch(Exception e){
         RestResponse res = RestContext.response;
        res.statusCode= 400;
        return  'Failed';

    }
}
}