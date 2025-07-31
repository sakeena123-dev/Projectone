public  class DeleteRecordsBatchClass implements  Database.Batchable<sobject>{
    private string sobjectname;
    public DeleteRecordsBatchClass(string sobjectname ) {
this.sobjectname = sobjectname;  
    }
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getquerylocator('select id from ' +sobjectname +' where createddate =today');
    }
    public void execute(Database.BatchableContext bc,list<sobject> scope)
    {
        Database.delete(scope,false);
    }

 public void finish(Database.BatchableContext bc){
    System.debug('Finished');
 }
   
}