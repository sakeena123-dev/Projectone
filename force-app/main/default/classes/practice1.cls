public class practice1 {
  // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Map]//after insert,update,delete
   public static void updatephone(list<account>acclist,map<id,account> oldmaplist){//trigger.new,trigger.oldMap
       
        Map<id,account> mapAcc = new map<id,account>();
        for(account acc:acclist)
        {
            if(oldmaplist.get(acc.id).phone != acc.phone){
                mapAcc.put(acc.id,acc);
            }
          
            
        }
       list<contact> conlist =[select id,name,phone,accountid,account.phone from contact where accountid in :mapAcc.keyset() ];
      // list<contact> conrecords = new list<contact>();
       for(contact con:conlist)
       {
           
         con.phone =mapacc.get(con.accountid).phone;
          // conrecords.add(con);
       }
       update conlist;
   }
   // If the Account billing address is updated then update related contacts mailing address.[Using Map]//after insert,update,delete
    public static void updatebuilding(list<account>acclist,map<id,account> oldmaplist){//trigger.new,trigger.oldMap  
    Map<id,account> maplist = new map<id,account>();
        for(account acc:acclist)
    {
        
           maplist.put(acc.id,acc);
        
    }
         list<contact> conlist =[select id,name,phone,MailingCity,accountid,account.BillingCity from contact where accountid in :maplist.keyset() ];
      for(contact con:conlist)
       {
           
         con.MailingCity =maplist.get(con.accountid).BillingCity;
          
       }
        update conlist;
    }
    
//   // If the Account billing address is updated then update related contacts mailing address.[Using Map]//after insert,update,delete
    
   /*"Delete the account when there are no contacts available in Account.This should trigger
when you delete the last contact of an account." */ //after delete,trigger.old
    public static void delectAcc(list<contact> conlist)
    {
      set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            
            ids.add(con.accountid);
        }
        list<account> acclist = [select id,name from account where id in:ids];
        if(acclist.size()>0)
        {
            delete accList;
        }
    }
    
/* " When a new contact is created for an existing account then set contact of the
otherphone as account phone. "*/ //before insert
    public static void otherphoneUpdate(list<contact> conlist)
    {
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            ids.add(con.accountid);
            
        }
        Map<id,account> maplist = new Map<id,account>([select id,name,phone from account where id in:ids]);
       
        for(contact con:conlist)
        {
            if(maplist !=null && maplist.containskey(con.accountid))
            {
                con.otherphone = maplist.get(con.accountid).phone;
            }
        }
        
    }
    // When a new Contact is inserted with out Account then throw error message//before insert
    public static void insertContact(list<contact> conlist)
    {
        for(contact con:conlist)
        {
            if(con.AccountId==null)
            {
                con.adderror('a contact must be associate with an account');
            }
        }
    }
    // Create a custom field called No of Contacts in Account object. Whenever a new Contact record is created which is related to any Account, 
    // count the total no of Contact records for that Account and update the No of Contacts field value //after update,insert,delete(old)
    public static void noOfContact(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con :conlist)
        {
            ids.add(con.AccountId);
        }
        list<AggregateResult> agglist =[select count(id)cou,lastname,accountid from contact where accountid in:ids group by lastname,accountid];
        list<account> acclist = new list<account>();
        for(AggregateResult agg:agglist)
        {
            account a  = new account();
            a.No_of_opportunity__c = (integer)agg.get('con');
            acclist.add(a);
        }
        update acclist;
    }  
  //Automatically create 5 Contact records per Account  //after insert
    public static void fiveContacts(list<account> acclist){
        list<contact> conlist= new list<contact>();
        for(account acc:acclist)
        {
            for(integer i=1;i<=5;i++)
            {
                contact c = new contact();
                c.AccountId=acc.id;
                c.lastname ='test'+i;
                conlist.add(c);
            }
        }
        insert conlist;
    }    
    
// When an Account record is Deleted, if the Account is having 3 or more related Contacts, prevent deleting it    //before delete(old)
 public static void DelectAcc1(list<account> acclist)
    {
         List<account> acc1 =[select id,name from account ];
        for(account acc:acclist)
        {
            if(acc1.size()>=3)
            {
                 acc.addError('can not delete the account having 3 contacts');
            }
        }
        
       /*set<id> ids = new set<id>();
        for(account acc :acclist)
        {
            ids.add(acc.Id);
        }
        map<id,integer> countCon = new map<id,integer>();
        list<AggregateResult> agglist =[select count(id)cou,lastname,accountid from contact where accountid in:ids group by lastname,accountid];
         for(AggregateResult agg:agglist)
        {
            countCon.put((id)agg.get('accountid'),(integer)agg.get('cou'));
        }
         for(account acc:acclist)
         {
              if(countCon.size()>=3)
              {
                  acc.adderror('you can not delete this account it having 3 contacts ');
              }
         }*/
       
             
       
    }
  //When a Contact record is Deleted, if the Contact record is related to Account record, prevent deleting it  //before delete(old)
   public static void deleteAcc(list<contact> conlist)
   {
      
        for(contact con :conlist)
        {
            if(con.AccountId!=null)
            {
                con.adderror('you can not delete the contact it is associated with account'); 
            }
            
        }
       
   }
  // Prevent duplicate account creation. Check if already any Account record exist with the same Name. If Yes, prevent Account record creation
    public static void duplicateACC(list<account> acclist){
        set<string> strgName = new set<string>();
        for(account acc:acclist)
        {
            strgname.add(acc.name);
        }
        list<account> accrecord = [select id,name from account where name in :strgname];
        for(account acc:acclist)
         {
              if(accrecord.size()!=0)
              {
                  acc.adderror('duplicate account found ');
              }
         }
    }     
  public static void preventDuplicateEmailPhone(List<contact> conList) {
        Set<String> emails = new Set<String>();
        Set<String> phones = new Set<String>();

        // Collect Email & Phone values from new records (ignore null values)
        for (contact con : conList) {
            if (con.Email != null) {
                emails.add(con.Email);
            }
            if (con.Phone != null) {
                phones.add(con.Phone);
            }
        }
      Map<String, Contact> existingEmails = new Map<String, Contact>();
        Map<String, Contact> existingPhones = new Map<String, Contact>();
      list<contact> conrecord =[select id,email,phone from contact where email in:emails or phone in :phones];
      for(contact con1:conrecord)
      {
          existingEmails.put(con1.email,con1);
          existingPhones.put(con1.phone,con1);
      }
      for(contact con:conList)
      {
          if(con.Email != null && existingEmails.containskey(con.Email.tolowercase()))
          {
              con.adderror('duplicate email found ');
          }
           if(con.phone != null && existingPhones.containskey(con.phone))
          {
              con.adderror('duplicate phone found ');
          }
      }
  }
    
    // If Description field is Null or less than 10 chars, set some default value to it
    public static void defaultAcc(list<account> acclist)
    {
        for(account acc:acclist)
        {
            if(acc.Description==null  && acc.Description.length()<10)
            {
                acc.Description=' If Description field is Null or less than 10 chars';
            }
        }
    }
    // Automatically create 5 Contact records per Account
    public static void fiverecord(list<account> acclist){
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            for(integer i=1;i<=5;i++)
            {
                contact con = new contact();
                con.accountid = acc.id;
                con.LastName =acc.Name+i;
                conlist.add(con);
            }
        }
        insert conlist;
        
    }
    // When Billing City is Not Null or not blank, for each Contact under the Account, update MailingCity of Contact to Billing City of Account
    public static void billingNul(list<account> acclist){
        set<id> ids = new set<id>();
        Map<id,account> mapAcc = new map<id,account>();
        for(account acc:acclist)
        {
            if(acc.id!=null)
            {
                ids.add(acc.id);
                mapAcc.put(acc.id,acc); 
            }
        }
        list<contact> conrecords =[select id,lastname,accountid,account.billingCity,mailingCity from contact where accountid in :ids];
        list<contact> conlist = new list<contact>();
        for(contact con: conrecords)
        {
            if(mapAcc.get(con.AccountId).billingCity!=null)
            {
                con.MailingCity =mapAcc.get(con.AccountId).billingCity; 
                
                conlist.add(con);
            }
        }
        update conrecords;
    }
 // Prevent duplicate account creation. Check if already any Account record exist with the same Name. If Yes, prevent Account record creation
    public static void acctdupli(list<account>acclist){
        set<id> ids = new set<id>();
        set<string> acctName = new set<string>();
       for(account acc:acclist)
        {
            if(acc.id!=null)
            {
                ids.add(acc.id);
                acctName.add(acc.name);
             }
        }
         list<account> accrecords =[select id,name from account where id In :ids and name in : acctName];
        for(account acc:acclist)
        {
            if(accrecords.size()!=0)
            {
                acc.adderror( 'Account cannot be inserted');
            }
        }
        
    }  
  // Whenever a Lead record is created, if the Name field does not contain either "Mr." or "Mrs.", prefix either "Mr." or "Mrs." to the Name field
  
 // Add a custom field called Min no of Contacts. Validate that this field should always be greater than or equal to 1. Automatically create Contact records 
 // when Account record is created.  No of Contact records created should be equal to the value of Min No of Contacts field on Account   
public static void minConts()
{
    
}
}