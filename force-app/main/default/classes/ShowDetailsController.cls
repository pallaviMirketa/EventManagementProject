public class ShowDetailsController {
 public Event_Detail__c eventob{get;set;}
 public List<Event_Speaker__c> espeakerob{get;set;}
    
  public ShowDetailsController(){
  Id currId= ApexPages.CurrentPage().getparameters().get('id');
  //this.eventob = [SELECT Id
  this.eventob= [Select Id,Name__c,Organizer__r.Name,Locations__r.Name,Start__c,End__c From Event_Detail__c where Id=:currId];
  this.espeakerob= [Select Id, Speaker__r.Name, Speaker__r.Profile_URL__c, Speaker__r.About_Me__c from Event_Speaker__c where Event__c=: currId];
  
  }
}