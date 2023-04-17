public class oldrecords implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, Name from Event_Detail__c where End__c <= LAST_N_MONTHS:2 AND Live__c=true]);
    }
    public void  execute(Database.BatchableContext BC,List<sObject> scope){
        delete scope;
   }
   public void finish(Database.BatchableContext BC){
    AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {a.CreatedBy.Email};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Apex Job Status:- ' + a.Status);
    mail.setPlainTextBody ('The batch Apex job processed');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 }
}