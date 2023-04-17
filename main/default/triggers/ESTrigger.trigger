trigger ESTrigger on Event_Speaker__c (before insert) {
    try{
        ESclass.insertEventSpeaker(trigger.new);
    }
    catch(DmlException e){
        System.debug(e.getMessage());
    }
}