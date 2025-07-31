public class Triggers  {
    /* If Description field is Null or less than 10 chars, set some default value to it -before insert, before update */
    public static void descTrigger1(list<account> acclist)
    {
        for(account acc: acclist)
        {
            if(acc.description==null && acc.description.length()<=10)
            {
                acc.description='Hello Salesforce';
            }
        }
        
    }
    //Automatically create 5 Contact records per Account - after insert
    public static void conCreation(list<account> acclist)
    {
        list<contact> con = new list<contact>();
        for(account acc:acclist)
        {
            
            for(integer i=1;i<=5;i++)
            {
                contact c = new contact();
                c.accountid = acc.id;
                c.lastname =acc.name+i;
                con.add(c);
            }
            
        }
        insert con;
    }
    // When Billing City is Not Null or not blank, for each Contact under the Account, update MailingCity of Contact to Billing City of Account -after update 
    public static void updateConMailing(list<account> acclist)
    {
        set<id> ids = new set<id>();
        Map<id,account> maplist = new map<id,account>();
        for(account acc: acclist)
        {
            ids.add(acc.id);
            maplist.put(acc.id,acc);
        }
        list<contact> conlist = [select id,name,mailingcity,accountid from contact where accountid in : ids];
        list<contact> con1 = new list<contact>();
        for(contact con: conlist)
        {
            if(maplist.get(con.accountid).billingcity!=null){ 
                con.mailingcity = maplist.get(con.accountid).billingcity;
                con1.add(con); 
            }
            
        }
        update con1;
    }
    
    // Prevent duplicate account creation. Check if already any Account record exist with the same Name. If Yes, prevent Account record creation - before insert
    public static void duplicateRecordCreation(list<account> acclist)
    {
        set<string> stringname = new set<string>();
        set<id>  ids = new set<id> ();
        for(account acc : acclist)
        {
            ids.add(acc.id);
        }
        list<account> acclist1 =[select id,name from account where id in :ids];
        for(account acc1: acclist1)
        {
            stringname.add(acc1.name);
        }
    }
    // Whenever a Lead record is created, if the Name field does not contain either "Mr." or "Mrs.", 
    // prefix either "Mr." or "Mrs." to the Name field 
    public static void leadname(list<lead> leadlist)
    {
        for(lead leList : leadlist)
        {
            if(!lelist.name.contains('Mr.') &&  !lelist.name.contains('Mrs.') )
            {
                if(lelist.salutation == 'Mr.' || lelist.salutation == 'Mrs.' )
                {
                    lelist.salutation = lelist.salutation;
                }  
                else
                { 
                    lelist.salutation = 'Mr.';
                }
            }
        }
        
    }
    // When a Contact record is Deleted, if the Contact record is related to Account record, prevent deleting it 
    public static void conrecord(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            ids.add(con.accountid);
        }
        list<contact> conslist =[select id,name,accountid from contact where accountid in :ids];  
        for(contact con : conlist)
        { 
            if(con.accountid !=null)
            {
                con.adderror('contact record will be delete');
            }
        }
    }
    // When an Account record is Deleted, if the Account is having 3 or more related Contacts, prevent deleting it
    public static void accDelete(list<account> acclist )
    {
        set<id> ids = new set<id>();
        for(account acc:acclist)
        {
            ids.add(acc.id);
        }
        list<contact> conlist=[select id,name,accountid from contact where accountid in:ids];
        for(account acc:acclist)
        {
            if(conlist.size()>=3)
            {
                acc.adderror('can not delete the account');
            }
        }
    }
    // Add a custom field called Min no of Contacts. Validate that this field should always be greater than or equal to 1. 
    // Automatically create Contact records when Account record is created. No of Contact records created should be equal to the value of Min No of Contacts
    //  field on Account 
    public static void noOfCon(list<account> acclist){
        list<contact> conlist = new list<contact>();
        set<id> ids = new set<id>();
        
        for(account acc:acclist)
        {
            contact con = new contact(); 
            con.accountid = acc.id;
            con.lastname = acc.name;
            
            conlist.add(con);
        }
        insert conlist;
        
        list<contact> conlist1 = [select id,accountid,account.Total_Number_of_Contacts__c from contact where accountid in :ids];
        for(contact con:conlist1)
        {
            // con.account.Total_Number_of_Contacts__c
            if(con.account.Total_Number_of_Contacts__c<1)
            {
                con.account.adderror('this field should always be greater than or equal to 1');
            }
            
            
        }
    } 
    
    // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Map]-14
    public static void acctPhone(list<account> acclist)
    {
        set<id> ids = new set<id>();
        Map<id,account> maplist = new Map<id,account>();
        for(account acc:acclist)
        {
            if(acc.id!=null)
            {
                ids.add(acc.id);
                maplist.put(acc.id,acc);
            }
            
        }
        list<contact> conlist = [select id,accountid,account.phone,phone from contact where accountid in :ids];
        for(contact con:conlist)
        {
            if(maplist.containskey(con.accountid)!=null){
                 con.phone = maplist.get(con.accountid).phone;
            }
           
        }
        update conlist;
    }
    
}