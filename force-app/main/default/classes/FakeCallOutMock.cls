@isTest
global class FakeCallOutMock implements HttpCalloutMock{
  global HttpResponse respond (HttpRequest request){

    HttpResponse response = new HttpResponse();
    response.setHeader('content-type', 'application/json');
   // String result = res.getBody();
    response.setBody('[{"id":"1","title":"Anything-1", "description":"this is first desc.","price":19000}, {"id":"2","title":"Anything-2", "description":"this is second desc.","price":1900}]');//body on our end point
    response.setstatusCode(200);
    
    return response;

  }


}