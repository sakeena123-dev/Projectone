public with sharing class DeleteRecordsController {
    @AuraEnabled
    public static void DeleteRecords(string sobjectname) {
    List<string> objectlist = sobjectname.split(';');
    system.debug('sobjectname' +objectlist);
     //List<SObject> sobjects;
   // list<sobject> records = new list<sobject>();
    for(string obtname : objectlist)
    {
    system.debug('obtname' +obtname);
    DeleteRecordsBatchClass btc = new DeleteRecordsBatchClass(obtname);
    Database.executeBatch(btc,2000);
   // String soql = 'select id from ' +obtname +' where createddate =today';
   // system.debug('soql' +soql);
     //List<SObject> sobjects= database.query(soql);
      //system.debug('sobjects' +sobjects);
      //records.addAll(sobjects);
    }
    
   
    //Database.DeleteResult[] results = Database.delete(records, false);
    //system.debug('records' +records);
}
}