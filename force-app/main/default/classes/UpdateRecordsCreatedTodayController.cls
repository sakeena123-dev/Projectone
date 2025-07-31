public with sharing class UpdateRecordsCreatedTodayController {
    @AuraEnabled
   
    public static void UpdateRecordsCreatedTodayController(string sobjectname) {
        list<string> objectlist =sobjectname.split('/');
//string soql ='select id,name from' +objectlist +'where createdDate = today';
for(string obj:objectlist)
{
    system.debug('obj' +obj);
  UpdateRecordsBatchApex btc = new UpdateRecordsBatchApex(obj);
    database.executeBatch(btc,2000);
}
    }
}