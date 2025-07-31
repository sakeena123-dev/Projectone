public class AccountTriggerHandler {
 //Account: If Description field is Null or less than 10 chars, set some default value to it  //before insert, before update //task-1
Public static void describSet(List<account> acc)
{
    for(account ac:acc)
    {
        if(ac.id!=null && (ac.Description==null || ac.Description.length()<10))
        {
            ac.Description='welcome to salesforce';
        }
    }
}
 // Automatically create 5 Contact records per Account
  public static void insertcontact1(List<account> acc)
    {
         List<contact> con =new  List<contact>();
        for(account a:acc)
        {
           for(integer i=1;i<=5;i++)
            {
                contact c = new contact(Lastname ='jyothi'+i,accountid = a.id);
                con.add(c);
            } 
        }
        insert con;
    }
 // When Billing City is Not Null or not blank,
 //  for each Contact under the Account, update MailingCity of Contact to Billing City of Account   
 public static void updatCity(List<account> acc)
    {  
        set<id> ids = new set<id>();
     for(account a: acc)   
     {
         ids.add(a.id);
     }
        list<contact> conlist = [select id,accountid,lastname,mailingcity,account.BillingCity from contact where accountid in :ids];
        for(contact con: conlist)
        {
            if( con.account.BillingCity!=null || string.isNotBlank(con.account.BillingCity)){
                 con.mailingcity =con.account.BillingCity;
            }
           
        }
        update conlist;
    }
  // Prevent duplicate account creation. 
  // Check if already any Account record exist with the same Name. If Yes, prevent Account record creation  
  public static void duplicatAccount(List<account> acc)
  {
      list<string> accname = new list<string>();
      for(account a:acc)
      {
          accname.add(a.name);
      }
      List<account> acclist =[select id,name from account where name =:accname];
     for(account a:acc)
     {
         if(acclist.size()>0)
         {
             a.adderror('duplicate record');
         }
     }
  }
  //Mthod -2 using map
    public static void duplicateRecord(list<account> acc){
       set<string> accname = new set<string>();
        for(account a:acc)
        {
            accname.add(a.name);
            
        }
        list<account> acclist =[select id,name from account where name=:accname];
        map<string,id> accNameMap = new map<string,id>();
        for(account accli :acclist)
        {
            accNameMap.put(accli.name,accli.id);
        }
        
        for(account a:acc )
        {
            if(accname.contains(a.name) && accNameMap.containskey(a.name) )
            {
                a.name.adderror('duplicate record');
            }
        }
    }  
  //When an Account record is Deleted, if the Account is having 3 or more related Contacts, prevent deleting it
  public static void deletecon(list<account> accountRecord)
  {
      set<id> ids = new set<id>();
      for(account acc:accountRecord)
      {
          ids.add(acc.id);
      }
      Map<string,integer> mapvalue = new Map<string,integer>();
      list<AggregateResult> Agglist =[select count(id)con,name,accountid from contact where accountid in: ids group by name,accountid];
      for(AggregateResult agg:Agglist)
      {
         string accid = (string)agg.get('accountid');
          integer conid =(integer)agg.get('con');
          mapvalue.put(accid,conid);
      }
      for(account acc:accountRecord)
      {
          if(mapvalue.get(acc.id)>=3)
          {
            acc.adderror('We cannot delete this');  
          }
      }
  }
   
    public static void validateFields(List<account> records) {
        for (account record : records) {
          if (record.Testing__c != null) {
                 //!Pattern.matches('\\d+', record.Testing__c) && !Pattern.matches('[0-9]*[.][0-9]*', record.Testing__c) && !Pattern.matches('^\\S+$', record.Testing__c)
           if ( !isNumeric(record.Testing__c)   ) {//
                record.addError('Custom validation error message: Testing should only contain numeric values.');
            }
        } else {
            record.addError('Field cannot be blank.');
        }
        }
    }
  
    public static Boolean isNumeric(String s){
        Boolean ReturnValue;
        try{
            Decimal.valueOf(s);
            ReturnValue = TRUE; 
        } catch (Exception e) {
            ReturnValue = FALSE;
        }
        return ReturnValue;
    }

   public static Boolean isValidNumber(String input) {
        // Use a regular expression to check if the string only contains numeric or decimal values
        Pattern pattern = Pattern.compile('^[0-9]+(\\.[0-9]+)?$');
        Matcher matcher = pattern.matcher(input);
        return matcher.matches();
    }

 
}