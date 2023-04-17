@isTest
private class oldrecordsTest {
    @TestSetup static void insertMethod(){
        List<Event_Detail__c> eventList=new List<Event_Detail__c>();
        for(integer i=0;i<200;i++){
            Event_Detail__c ec=new Event_Detail__c();
            ec.Name__c='Event Function'+i;
            ec.Start__c=Date.parse('14/01/2023');
            ec.End__c=Date.parse('16/01/2023');
            ec.Event_Type__c='Virtual';
            ec.Frequency__c='Daily';
            ec.Live__c=true;
            ec.Recurring__c=true;
            eventList.add(ec);
        }
        insert eventList;
    }
    @isTest static void testInsertMethod(){
        Test.startTest();
        oldrecords eBatch=new oldrecords();
        Database.executeBatch(eBatch);
        Test.stopTest();
        List<Event_Detail__c> deletEventsRecord = [Select Id,Name__c from Event_Detail__c];
        System.assertEquals(0, deletEventsRecord.size(),'All records before 2 months should be deleted.');
    }
}