@isTest
public class sendEmailTest {
    @TestSetup static void makeData(){
        Event_Organizer__c eoc=new Event_Organizer__c(
            Name='Pallavi Verma',
            E_mail__c='pallavi.verma@mirketa.com',
            Phone__c='67856476'
        );
        
        insert eoc;

        Event_Detail__c ec=new Event_Detail__c(
            Name__c='Dancing Competetion',
            Start__c=System.now(),
            End__c=System.now().addDays(3),
            Event_Type__c='Virtual',
            Frequency__c='Daily',
            Live__c=true,
            Recurring__c=true,
            Max_Seats__c=10
        );
        insert ec;
        Attendee__c at=new Attendee__c(
            Name='harshil',
            Email__c='pallavi.1923cs1189@kiet.edu',
            Phone__c='9869543210'
        );
        insert at;
        Event_Attendee__c evtAtt = new Event_Attendee__c(Event__c = ec.Id, Attendee__c = at.Id);
        insert evtAtt;
    }
    @isTest static void testEventAttendee(){
        Test.startTest();
        List<Event_Attendee__c> eat=[Select Id,Event__c,Attendee__c from Event_Attendee__c where Event__r.Name__c='Dancing Competetion'];
        sendEmailClass.insertEventAttendee(eat);
        Integer invoc=Limits.getEmailInvocations();
        System.assertEquals(1, invoc,'An email should be sent to the sender');
        Test.stopTest();
    }
}