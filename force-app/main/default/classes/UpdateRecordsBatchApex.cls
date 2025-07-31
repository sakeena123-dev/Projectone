public with sharing class UpdateRecordsBatchApex implements Database.batchable<Sobject>{
    private string sobjectname;
    public  UpdateRecordsBatchApex(string sobjectname ) {
  this.sobjectname = sobjectname;
    }
        public Database.Querylocator start(Database.batchableContext bc)
        {
string soql ='select id,name from' +sobjectname +'where createdDate = today';
return Database.getqueryLocator(soql);
        }
public static void execute(Database.BatchableContext bc,List<SObject> scope)
{
    Database.update(scope,false);
}
public static void finish(Database.BatchableContext bc){
System.debug('Finished');
}

    }
