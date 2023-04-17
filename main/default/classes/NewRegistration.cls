public class NewRegistration{
    public Event_Organizer__c esobj{get;set;}
    public Event_Detail__c ed{get;set;}
    public Location_Address_Book__c locobj{get;set;}
    
    public NewRegistration() {
        esobj = new Event_Organizer__c();
        ed = new Event_Detail__c();
        locobj= new Location_Address_Book__c();
      
    } 
    public void addDetailsEO(){
        Savepoint sp = Database.setSavepoint();
        try{
             if(ed.Event_Type__c!='Virtual'){
                
              ed.Locations__c= locobj.Id;
              
                insert locobj;
             //ed.Locations__c=locobj.Name;
                  
            }
            
            insert esobj;
            ed.Organizer__c= esobj.Id;
           ed.Locations__c= locobj.Id;
        //  ed.Locations__c='Virtual Event';
            
        //    insert ed;  
           
         insert ed; 
         esobj = new Event_Organizer__c();
        ed = new Event_Detail__c();
        locobj= new Location_Address_Book__c();

        }
        catch(Exception e){
            System.debug(e.getMessage());
          Database.rollback(sp);
        }
    }

}