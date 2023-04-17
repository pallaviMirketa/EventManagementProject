@RestResource(urlMapping='/EventDetails/*')
global with sharing class EventWebService {
 @HttpGet
  //global static Event_Detail__c doGet(){
   // RestRequest req= RestContext.request;
    //RestResponse res= RestContext.response;
    //String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

    global static list<Event_Detail__c> getEventMethod(){

    list<Event_Detail__c> allevents=[select Id,Name__c,Start__c, Max_Seats__c,Organizer__r.name, Organizer__r.E_mail__c from Event_Detail__c];
   return allevents;
    }
  }