@isTest
private class createSpeakerRecordTest{
    @isTest
    static void createSpeakerRecordTest(){
       Test.startTest();
       RestContext.response = new RestResponse();
       String speakerob1= createSpeakerRecord.doPost('dina','3456758','dina@james.com','AOT');
       
       String speakerob2= createSpeakerRecord.doPost('dina','3456758','dina@james.com','AOT');

       List <Speaker__c> speakerlist = [select Id, Name from Speaker__c where Name='dina'];
       System.assertNotEquals(1,speakerlist.size());
      // System.AssertEquals(200,RestContext.response.statusCode);
     System.assertEquals(400,RestContext.response.statusCode);

    
    Test.stopTest();

    }
}