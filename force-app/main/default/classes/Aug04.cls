public class Aug04 {
    // If Description field is Null or less than 10 chars, set some default value to it -before insert/before update
    public static void descr(list<account> acclist)
    {
        for(account acc:acclist)
        {
            if(acc.description == null && acc.description.length() <10)
            {
                acc.Description='this is a sample description';
            }
        }
    }
    // Automatically create 5 Contact records per Account   - after insert
    public static void createcon(list<account> acclist)
    {
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            contact con = new contact();
            con.id = acc.id;
            con.LastName = acc.Name;
            conlist.add(con);
        }
        insert conlist;
    }    
    // When Billing City is Not Null or not blank, for each Contact under the Account, update MailingCity of Contact to Billing City of Account - after update
    public static void accbilling(list<account> acclist){
        set<id> ids = new set<id>();
        map<id,account> maplist = new map<id,account>();
        for(account acc:acclist)
        {
            ids.add(acc.id);
            maplist.put(acc.id,acc);
        }
        list<contact> conlist = [select id,name,accountid,account.billingcity,MailingCity from contact where accountid in: ids];
        for(contact con: conlist)
        {
            con.mailingcity = maplist.get(con.AccountId).billingcity;
            
        }
        update conlist;
    }   
    // Prevent duplicate account creation. Check if already any Account record exist with the same Name. If Yes, prevent Account record creation - before insert
    public static void   duplicateAcc(list<account> acclist){
        Set<String> newAccountNames = new Set<String>();
        
        // Add names of the new accounts to the set
        for (Account acc : acclist) {
            newAccountNames.add(acc.Name);
        }
        Map<String, Account> existingAccounts = new Map<String, Account>();
        list<account> acc1 =  [SELECT Name FROM Account WHERE Name IN :newAccountNames];
        for (Account ac1 :acc1 ) {
            existingAccounts.put(ac1.Name, ac1);
        }
        for(account acc:acclist)
        {
            if(existingAccounts.containskey(acc.name))
            {
                acc.addError('An Account with this name already exists.');
            }
        }
        
    }
    
    //When ever a case is created with origin as email then set status as new and Priority as Medium.
    public static void casecre(list<case> caselist)
    {
        //list<case>caselist1 = new  list<case>();
        for(case ca:caselist)
        {
            if(ca.Origin=='Email')
            {
                ca.status ='new';
                ca.Priority='medium';
                
            }
        }
        
    }
    
    // When ever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
    public static void leadcre(list<lead>leadlist)
    {
        for(lead le:leadlist)
        {
            if(le.leadsource=='web')
            {
                le.Rating='cold';
                
            }
            else
            {
                le.Rating='hot';
            }
        }
    }    
    
    // Whenever New Account Record is created then needs to create associated Contact Record automatically.
    public static void autocreaCon(list<account> acclist)
    {
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            
            contact con = new contact();
            con.AccountId=acc.id;
            con.lastname=acc.name;
            conlist.add(con);
        }
        insert conlist;
    }
 // When ever the Account is created with Industry as Banking then create a contact for account,
 //  Contact Lastname as Account name and contact phone as account phone.
   public static void autocreaCon2(list<account> acclist)
    {
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            if(acc.industry =='banking')
            {

            contact con = new contact();
            con.AccountId=acc.id;
            con.lastname=acc.name;
             con.Phone=acc.Phone;  
            conlist.add(con);
                                
            }
        }
        insert conlist;
    }
// Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object. 
public static void concreat(list<account> acclist)
{
    map<id,account> maplist = new map<id,account>();
    for(account acc:acclist)
        {
            maplist.put(acc.id,acc); 
        } 
            
            
   list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
          for(integer i=1;i<=maplist.get(acc.id).Total_Number_of_Contacts__c;i++)
          {
            contact con = new contact();  
            con.AccountId=acc.id;
            con.lastname=acc.name+i;
             con.Phone=acc.Phone;  
            conlist.add(con);
                                
          }            
        }
        insert conlist;
}  
// Create "Sales Rep" field with the data type(Text) on the Account object When we create the Account record,
//  the Account owners will be automatically added to the sales rep field. When we update the Account owner of the record, 
//  then also the Sales Rep will be automatically updated.
    public static void ownAcc(list<account> acclist)
    {
        set<id> ids = new set<id>();
      for(account acc:acclist) 
      {
          ids.add(acc.OwnerId);  
      }
        map<id,user> usermap = new  map<id,user>([select id,name from user where id in :ids ]); 
       
        for(account acc1: acclist)
        { 
            user usr = usermap.get(acc1.ownerId);
            acc1.Sales_Rep__c = usr.name;
        }
    }   

/*Create a field called "Contact Relationship" checkbox on the contact object and create the object called "Contact Relationship" 
 * which is related list to the Contacts (Lookup Relationship).Now build a logic when we create contact by checking Contact Relationship checkbox,
then contact Relationship will be created automatically for that contact. */
    
    
//write an apex trigger to update the related contacts with the lastest country field value whenever it changes on the parent account record
public static void updateCountryField(list<account> acclist)
{
    set<id> ids = new set<id>();
    for(account acc:acclist)
    {
        ids.add(acc.id);
    }
    list<contact> conlist =[select id,accountid,MailingCity,account.billingCity from contact where accountid in :ids];
     
    for(contact con:conlist)
    {
       con.MailingCity = con.account.billingCity;
    }
    update conlist;
}

}