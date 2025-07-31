public class InterviewScenarios1 {
    // when an opportunity is 'closed won'. create a task for the opportunity 
    public static void opptask(list<opportunity> opplist)
    {
        list<task> tasklist = new list<task>();
        for(opportunity op:opplist )
        {
            if(op.stagename =='closed won')
            {
                task t = new task();
                t.whatid = op.id;
                t.ownerid =userinfo.getuserid();
                t.status ='completed';
                tasklist.add(t);
            }
        }
        insert tasklist;
    }
    // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Map]//after insert,update,delete
    public static void upPhone(list<account> acclist){
        set<id> ids = new set<id>();
        map<id,account> maplist = new map<id,account>();
        for(account acc :acclist)
        {
            if(acc.Id!=null){
                ids.add(acc.Id); 
                maplist.put(acc.Id,acc);
            }
      }
        list<contact> conRecords =[select id,accountid,phone,account.phone from contact where accountid in:ids];
        for(contact con:conRecords )
        {
            if(maplist.get(con.AccountId).phone!=null && maplist.containskey(con.AccountId)){
                 con.phone = maplist.get(con.AccountId).phone;
            }
          
            
        }
        update conrecords;
    }  
    
 // If the Account billing address is updated then update related contacts mailing address.[Using Map]//after insert,update,delete
   public static void accbilling(list<account> acclist, map<id,account> oldacclist)
   {
   
       map<id,account> maplist = new map<id,account>();
       for(account acc: acclist)
       {
           if(acc.id!=null && oldacclist!=null)
           {
               maplist.put(acc.id,acc);
           }
           
       }
       list<contact> conrecords = [select id,accountid,mailingaddress,account.billingaddress,mailingCity,account.billingcity from contact where accountid in : maplist.keyset()];
       for(contact con:conrecords)
       {
           if(maplist.containskey(con.AccountId) && maplist.get(con.AccountId).billingcity!=null)
           {
               con.mailingCity =  maplist.get(con.AccountId).billingcity;
           }
       }
       update conrecords;
   }
    // Write a trigger on contact to prevent duplicate records based on Contact Email and Contact Phone.
   public static void duplicrecord(list<contact> conlist,map<id,contact> OldConlist)
   {
       map<string,contact> conemail = new map<string,contact>();
       map<string,contact> conphone = new map<string,contact>();
       list<contact> conrecords = [select id,phone,email from contact where phone!=null or email!=null];
       for(contact con:conrecords)
       {
           conemail.put(con.email,con);
           conphone.put(con.phone,con);
       }
       for(contact con:conlist)
       {
           if(conphone.containskey(con.id) || (conphone.containskey(con.id) && OldConlist.get(con.id).phone!=con.Phone))
           {
               con.phone.adderror('duplicate phone found');
           }
           if(conemail.containskey(con.id) || (conemail.containskey(con.id) && oldconlist.get(con.id).email != con.Email))
           {
                con.email.adderror('duplicate email found');
           }
       }
   }
   //update no of contacts
   public static void noofcon(list<contact>conlist)
   {
       set<id> ids = new set<id>();
       for(contact con:conlist)
       {
           ids.add(con.AccountId);
       }
      list<aggregateResult>agglist =[select count(id)con,accountid from contact where accountid in:ids group by accountid];
  list<account> accrecord = new list<account>();
       for(aggregateResult agg:agglist)
   {
       account a = new account();
       a.id =(id)agg.get('accountid');
       a.Min_no_of_Contacts__c = (decimal)agg.get('con');
       accrecord.add(a);
   }
   update accrecord;
   }
    
  //create automic 5 contacts
    public static void afivecons(list<account> acclist)
    {
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            
  
        for(integer i=1;i<=5;i++)
        {
            contact c = new contact();
            c.AccountId =acc.id;
           c.LastName = 'test'+i;
            conlist.add(C);
        }
                  }
        insert conlist;
    }
    
    // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Map]//after insert,update,delete
    public static void updateConPhone(list<account> accrecord)
    {
        set<id> ids = new set<id>();
        map<id,account> maplist = new map<id,account>();
        for(account acc:accrecord)
        {
            ids.add(acc.id);
            maplist.put(acc.id,acc);
        }
        list<contact> conlist =[select id,name,accountid,account.phone,phone from contact where accountid in :ids];
        for(contact con:conlist)
        {
            if(maplist.containskey(con.accountid)!=null && maplist.get(con.accountid).phone!=null)
                con.phone = maplist.get(Con.accountid).phone;
        }
        update conlist;
    }
    // If the Account billing address is updated then update related contacts mailing address.[Using Map]//after insert,update,delete
    public static void updateBillingaddress(list<account> acclist)
    {
        set<id> ids = new set<id>();
        map<id,account> maplist = new map<id,account>();
        for(account acc:acclist)
        {
            ids.add(acc.id);
            maplist.put(acc.id,acc);
        }
        list<contact> conlist =[select id,name,accountid,account.billingstreet,account.billingCity,mailingcity,mailingstreet from contact where accountid in: ids];
        for(contact con:conlist)
        {
            if(maplist.containskey(con.accountid)!=null)
            {
                con.mailingstreet =maplist.get(con.AccountId).billingstreet;
                con.mailingcity =maplist.get(con.AccountId).billingCity;
            }
        }
        update conlist;
    }
    
    /* Write a trigger on contact to prevent duplicate records based on Contact Email and Contact Phone.*/ // before update and insert
    Public static void CheckDuplicate(list<contact> conlist,map<id,contact>OldConlist){
        map<string,contact> newConPhone = new  map<string,contact>();
        map<string,contact> newConemail = new  map<string,contact>();
        list<contact> conlist1 = [select id,name,email,phone from contact where email !=null or phone !=null];
        for(contact con: conlist1)
        {
            newConPhone.put(con.phone,con);
            newConemail.put(con.email,con);
        }
        for(contact con:conlist)
        {
            if((con.phone !=null && newconphone.containskey(con.phone)) || 
               (con.phone !=null && newconphone.containskey(con.phone) && oldconlist.get(con.id).phone !=con.phone))
            {
                con.phone.adderror('duplicat phone value found');
            }
            if((con.email!=null && newconemail.containskey(con.email)) ||
               (con.email!=null && newconemail.containskey(con.email) && oldconlist.get(Con.id).email!= con.email))
                
            {
                con.email.adderror('duplicat email value found');
            }
        }   
    }
    //approach 2  
    public static void duplicatconerror(list<contact> conlist)
    {
        set<string> existingphone = new  set<string>();
        set<string> existingemail = new  set<string>();
        list<contact> conlist1 = [select id,phone,email from contact where  email !=null or phone !=null ]; 
        for(contact con:conlist1)
        {
            existingphone.add(con.Phone);
            existingemail.add(con.email);
        }
        for(contact con:conlist)
        {
            if(con.phone !=null &&  existingphone.contains(con.Phone))
            {
                con.phone.adderror('duplicat phone value found');
            }
            if(con.email !=null &&  existingemail.contains(con.email))
            {
                con.email.adderror('duplicat email value found');
            }
        }
    }
    
    //Whenever a contact’s description is updated then its parent account’s description should also get updated. 
    public static void condesc(list<contact> conlist){
        set<id> accid = new set<id>();
        Map<id,contact> maplist = new map<id,contact>();
        for(contact con:conlist)
        {
            accid.add(con.accountid);
            maplist.put(con.accountid,con);
        }
        list<account> acclist = [select id,name,description from account where id in:accid];
        for(account acc:acclist)
        {
            acc.description = maplist.get(acc.id).description;
        }
        update acclist;
    }
    
    //Write a trigger to count the number of contacts associated with an account and display the count on the account’s custom field. //after i,up,de
    public static void countcontact(list<contact> conlist,map<id,contact> OldConlist)
    {
        set<id> accid = new set<id>();
        integer contactcount;
        for(contact con:conlist)
        {
            accid.add(con.AccountId);
        }
        list<aggregateresult> agglist =[select count(id)conid,accountid from contact where accountid in:accid group by accountid ];
        list<account> acc = new list<account>();
        for(aggregateresult agg:agglist)
        {
            account a = new account();
            a.Total_Number_of_Contacts__c=(integer)agg.get('conid');
            acc.add(a);
            
        }
        update acc;
    }
    //Write a trigger show error if there are already two contacts on an account and a user try to insert one more contact on that account. 
    public static void conerror(list<contact> conlist){
        set<id> accid = new set<id>();
        for(contact con:conlist)
        {
            accid.add(con.AccountId);
        }
        list<contact> conlist1 =[select id,accountid from contact where accountid in:accid];
        for(contact con:conlist){
            if(conlist1.size()>=2)
            {
                con.adderror('account is more than 2 contact record');
            }
            
        }
    }
    // approach 2
    public static void conerrorcopy(list<contact> conlist)
    {
        set<id> accid = new set<id>();
        integer contactcount;
        for(contact con:conlist)
        {
            accid.add(con.AccountId);
        }
        list<aggregateresult> agglist =[select count(id)conid,accountid from contact where accountid in:accid group by accountid ];
        list<account> acc = new list<account>();
        for(aggregateresult agg:agglist)
        {
            contactcount=(integer)agg.get('conid');
        }
        for(contact con:conlist){
            if(contactcount>=2)
            {
                con.adderror('account is more than 2 contact record');
            }
        }
    }
    
    // Account object trigger, Name is duplicate need to prevent or else create a new record on the account.  
    public static void duplicateName(list<account> accList)
    {
        set<string> recordName = new set<string>();
        list<account> acclist1 = [select id,name from account where name!=null]; 
        for(account acc1:acclist1)
        {
            recordname.add(acc1.name);
        }
        list<account> acclst = new list<account>();
        for(account acc:acclist)
        {
            if(recordName.contains(acc.name))
            {
                acc.Name.adderror('This name is already present in record');
            }
            else 
            {
                Account a1 = new account();
                a1.Name= acc.Name;
                acclst.add(a1);
            }
        }
        if(!acclst.isempty())
        {
            insert acclist;
        }
    } 
    // When ever a case is created with origin as email then set status as new and Priority as Medium.
    public static void priorityStatus(list<case> Cas)
    {
        // list<case> caRcrd = new list<case>();
        for(case ca:cas)
        {
            if(ca.origin =='Email')
            {
                ca.status = 'new';
                ca.priority = 'Medium';
                // caRcrd.add(ca);
            }
        }
        
    }
}