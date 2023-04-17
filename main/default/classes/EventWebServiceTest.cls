@isTest
private class EventWebServiceTest {
    @TestSetup
 static void createData(){
        
        //Organiser Details

        Event_Organizer__c organob = new Event_Organizer__c(
        Name= 'Ted Talks',E_mail__c= 'tedtalks@jhfx.com');

        insert organob;

            //Event Details

       Event_Detail__c eventob= new Event_Detail__c(
        Name__c='The rock',
        Start__c=System.now(),
        End__c=System.now().addDays(10),Max_Seats__c=10,
        Organizer__c=organob.Id
        );
    insert eventob;
    }

    @isTest
    static void eventWebServiceTest(){
    RestRequest request = new RestRequest();
    request.requestURI='https://mirketa24-dev-ed.develop.lightning.force.com/services/apexrest/EventDetails';
    request.httpMethod= 'GET';
    RestContext.request= request;

    Event_Detail__c eventdata= [Select Id,Name__c,Start__c, Max_Seats__c,Organizer__r.name, Organizer__r.E_mail__c from Event_Detail__c];
    
    List<Event_Detail__c> responselist= EventWebService.getEventMethod();
    Event_Detail__c response = responselist.get(0);
    
    System.assert(responselist != null);
    System.assertEquals(eventdata.id, response.id);
    System.assertEquals(eventdata.Start__c, response.Start__c);
    System.assertEquals(eventdata.Max_Seats__c, response.Max_Seats__c);
    System.assertEquals(eventdata.Organizer__r.Name, response.Organizer__r.Name);
    
    
    }
}