trigger sendemailTrigger on Event_Attendee__c (after insert) {
    try{
        sendEmailClass.insertEventAttendee(trigger.new);
    }
    catch(DmlException e){
        System.debug(e.getMessage());
    }
}