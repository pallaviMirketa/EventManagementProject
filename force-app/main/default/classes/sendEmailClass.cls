public class sendEmailClass {

   public static void insertEventAttendee(List<Event_Attendee__c> lst){
    set<Id> attendeeId= new set<Id>();
    set<Id> eventId= new set<Id>();
    List<Messaging.SingleEmailMessage> mails=new List<Messaging.SingleEmailMessage>();
    for(Event_Attendee__c ealist: lst){
        if(ealist.Attendee__c!=null){
            attendeeId.add(ealist.Attendee__c);
        }
        if(ealist.Event__c!=null){
            eventId.add(ealist.Event__c);
        }
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        Attendee__c ob1= [SELECT Name, Email__c, Phone__c from Attendee__c where Id in :attendeeId];
        Event_Detail__c ob2 = [SELECT Name__c, Organizer__r.Name, Locations__r.Street__c, Locations__r.City__c,Locations__r.State__c,Locations__r.Postal_Code__c, Start__c from Event_Detail__c where Id in : eventId];
        List<String> toAddress = new List<String>();
        toAddress.add(ob1.Email__c);
        mail.setToAddresses(toAddress);
        mail.setSenderDisplayName(ob2.Organizer__r.Name);

    String subject = 'Pass for the'+ ob2.Name__c;
    mail.setSubject(subject);
    String body = 'Dear '+ ob1.Name+', ';
    body += 'Thank you for registering for '+ob2.Name__c+'which will be Organized on ';
    body += ob2.Start__c + '& will be held in '+ ob2.Locations__r.Street__c+ ', ' + ob2.Locations__r.City__c+ '.';
    body+= 'We are excited to have you, see you at the event.<br>';
    body+='Thanks<br>';
    body+=ob2.Organizer__r.Name;
    mail.setHtmlBody(body);
    mails.add(mail);
    
    }
     
    Messaging.sendEmail(mails);  
}
}