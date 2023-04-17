public class mfclass {
    public static Id InsertErrorLog(String PName, String Details){
       Error_Log__c elogs = new Error_Log__c(); 
        elogs.Log_date__c= Datetime.now();
        elogs.Log_Details__c= Details;
        elogs.Process_Name__c= PName;      
        insert elogs;
        return elogs.Id;
    }


}