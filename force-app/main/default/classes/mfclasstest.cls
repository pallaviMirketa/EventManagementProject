@istest
public class mfclasstest {
    public static testmethod void InsertErrorLog(){
       String LogDetails='Semicolon is missing.', Processname='Syntax Error';
       Test.startTest();
       Id errorId= mfclass.InsertErrorLog(Processname, LogDetails);
       Test.stopTest();
       List<Error_Log__c> ob=[SELECT Id, Name, Log_date__c,Log_Details__c,Process_Name__c from Error_Log__c where Id=: errorId ];

       System.assertEquals(1, ob.size());
       System.assertEquals(Datetime.now(), ob[0].Log_Date__c);
        System.assertEquals(LogDetails, ob[0].Log_Details__c);
        System.assertEquals(Processname, ob[0].Process_Name__c);
    }
}