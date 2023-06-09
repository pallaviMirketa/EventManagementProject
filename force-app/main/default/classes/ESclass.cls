public class ESclass {
    public static void insertEventSpeaker(List<Event_Speaker__c> lst){
        List<Id> speakerIds = new List<Id>();  
        Map<Id,DateTime> requested_bookings = new Map<Id,DateTime>();
       for(Event_Speaker__c esc:lst){
           requested_bookings.put(esc.Event__c,null);
           speakerIds.add(esc.Speaker__c);
       }  
       List<Event_Detail__c> relatedEvents=[Select Id,Start__c,End__c from Event_Detail__c where Id in :requested_bookings.keySet()];
       for(Event_Detail__c related_event : relatedEvents) {
        requested_bookings.put(related_event.Id,related_event.Start__c);
       }
       List<Event_Speaker__c> related_speakers = [SELECT ID, Speaker__c, Event__c, Event__r.Start__c,Event__r.End__c from Event_Speaker__c WHERE Speaker__c IN :speakerIds];
    for(Event_Speaker__c esc:lst){
        Datetime bookingtime=requested_bookings.get(esc.Event__c);
        for(Event_Speaker__c speaker:related_speakers){
            if(speaker.Speaker__c==esc.Speaker__c && speaker.Event__r.Start__c<=bookingtime && speaker.Event__r.End__c>=bookingtime ){
                esc.addError('Duplicate booking found');
            }
        }
    }
    }
}