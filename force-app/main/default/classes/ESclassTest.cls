@isTest
private class ESclassTest {
    @TestSetup static void duplicateSpeakerTest(){
        Event_Detail__c event1=new Event_Detail__c(
            Name__c='Singing Comp 2',
            Start__c=System.now(),
            End__c=System.now().addDays(3),
            Event_Type__c='Virtual',
            Frequency__c='Daily',
            Live__c=true,
            Recurring__c=true,
            Max_Seats__c=100
        );
        insert event1;
        Event_Detail__c event2=new  Event_Detail__c(
            Name__c='Singing Comp 2',
            Start__c=System.now(),
            End__c=System.now().addDays(3),
            Event_Type__c='Virtual',
            Frequency__c='Daily',
            Live__c=true,
            Recurring__c=true,
            Max_Seats__c=100
        );
        insert event2;
        Speaker__c speaker=new Speaker__c(
            Name='Nirvana'
        );
        insert speaker;
        try{
            Event_Speaker__c es1=new Event_Speaker__c(Event__c=event1.Id,Speaker__c=speaker.Id);
            insert es1;
            Event_Speaker__c es2=new Event_Speaker__c(Event__c=event2.Id,Speaker__c=speaker.Id);
            insert es2;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    @isTest static void testDuplicateRecord(){
        Test.startTest();
        try{
            List<Event_Speaker__c> lst1=[Select Id,Event__c,Speaker__c from Event_Speaker__c where Event__r.Name__c='Singing Competetion 1'];
             ESclass.insertEventSpeaker(lst1);
            List<Event_Speaker__c> lst2=[Select Id,Event__c,Speaker__c from Event_Speaker__c where Event__r.Name__c='Singing Competetion 2'];
             ESclass.insertEventSpeaker(lst2);
        }
        catch(Exception e){
            Boolean checkError=e.getMessage().contains('Duplicate booking found') ? true : false;
            System.AssertEquals(checkError, true);
        }
        Test.stopTest();
    }
}