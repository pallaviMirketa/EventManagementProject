@isTest 
private class FakeAPICalloutTest {
   @isTest
   static void testcalloutapi(){

       // Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FakeCallOutMock());

        HttpResponse response = FakeAPICallout.createRecord();

        Pricebook2 pb = [Select Id,Name,Description from Pricebook2 where Name= 'pallavi-pricebook'];
       // list <Product2> 
        //testing the custom pricebook;
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('pallavi-pricebook', pb.Name);
        System.assertEquals('Pricebook(Custom)',pb.Description);
       //System.assertEquals(true, pb.IsActive);

        String actual_value=response.getBody();
        System.debug('actual value='+ actual_value);
        
        String expected_value= '[{"id":"1","title":"Anything-1", "description":"this is first desc.","price":19000}, {"id":"2","title":"Anything-2", "description":"this is second desc.","price":1900}]';

        System.assertEquals(expected_value, actual_value);





    }
   
}