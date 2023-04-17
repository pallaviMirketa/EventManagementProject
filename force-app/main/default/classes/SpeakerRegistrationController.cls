public class SpeakerRegistrationController {
    public Speaker__c speakerob{get;set;}
    public Event_Speaker__c espeakerob {get;set;}
    
    public SpeakerRegistrationController(){
        speakerob = new Speaker__c();
        espeakerob = new Event_Speaker__c();
    }
    public void addspeakerDetails(){
    //    Savepoint sp = Database.setSavepoint();
        try{
           
            insert speakerob;
            System.debug('Speaker Ob='+ speakerob);
             
           // insert espeakerob;
            espeakerob.Speaker__c=speakerob.Id;
            System.debug('Speaker Id='+ speakerob.Id);
            insert espeakerob;
            System.debug('Event Speaker Id='+ espeakerob);
            speakerob = new Speaker__c();
      //  espeakerob = new Event_Speaker__c();
           
        }
        catch(Exception e){
            System.debug(e.getMessage());
          //  Database.rollback(sp);
        }
    }

}