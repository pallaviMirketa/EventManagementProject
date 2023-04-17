public class AttendeeRegistrationController {
 public Attendee__c attendob{get;set;}
 public Event_Attendee__c eattendob{get;set;}
 public Location_Address_Book__c locob{get;set;}
 public AttendeeRegistrationController (){
 
 attendob= new Attendee__c();
 eattendob= new Event_Attendee__c ();
 locob= new Location_Address_Book__c();
 

}
 public void addAttendeeDetails(){
      Savepoint sp = Database.setSavepoint();
  try{
    insert locob;
    attendob.Location_Address_Book__c= locob.Id;
  locob.Name= attendob.Location_Address_Book__c;
  
  insert attendob;
  eattendob.Attendee__c= attendob.Id;
  eattendob.Name= attendob.Name;
  
  
  insert eattendob;

  attendob= new Attendee__c();
 eattendob= new Event_Attendee__c ();
 locob= new Location_Address_Book__c();

  
  }
  catch(Exception e){
  System.debug(e.getMessage());
      Database.rollback(sp);
  }
  }
 }