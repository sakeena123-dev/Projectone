public class TriggerScenarios2 {
    //Upon Account Creation if Industry is not null and having value as ‘Media’ then populate Rating as Hot. -1
    public static void autopop(list<account> acclist)
        
    {
        for(account acc: acclist)
        {
            if(acc.industry!= null && acc.Industry=='Media')
            {
                acc.rating = 'hot';
            }
        }
        
    }
    
    //Upon Opportunity Creation if Amount is not null and is greater than 10,0000 then populate ‘Hot Opportunity’ in description field -2
    public static void opporamgr(list<opportunity> opplist)
    {
        
        for(opportunity opp:opplist)
        {
            if(opp.amount !=null && opp.amount>100000)
            {
                opp.description ='Hot Opportunity';
            }
        }
    }
    
    //When an account inserts and CopyBillingToShipping (Custom Field) checkbox ischecked then automatically copy -3
    //account billing address into account shippingaddress
    public static void billingacc(list<account> acclist)
    {
        for(account acc:acclist)
        {
            if( acc.BillingCity!=null && acc.CopyBillingToShipping__c== true)
            {
                acc.ShippingCity =acc.BillingCity;
            }
        }
    } 
    
    // Upon Creation of Position (Custom Object) if it is a New Position and Open Date,Min Pay & Max Pay are 
    // not populated then populated them with below values:a.Open Date = Today’s Dateb.Min Pay = 10000c.Max Pay = 15000 -4
    public static void post(list<Position__c> poslist)
    {
        for(Position__c po: poslist)
        {
            if(po.Status__c=='New Position' && po.Max_Pay__c==null  && po.Min_Pay__c==null  && po.Open_Date__c==null )
            {
                po.Open_Date__c=date.today();
                po.Min_Pay__c=10000;
                po.Max_Pay__c=15000;
                
            }
        }
    }
    
    // Create a related Contact when an Account is created -5
    public static void autocontCreat(list<account> acclist)
    {
        list<contact> conlist = new list<contact>();
        for(account acc:acclist)
        {
            contact con = new contact();
            con.accountid = acc.id;
            con.LastName ='testcon';
            conlist.add(con);
        }
        insert conlist;
    }    
    
    // Create a related Opportunity when an Account is created -6
    public static void oppCre(list<account> acclist)
    {
        list<opportunity> opplist = new list<opportunity>();
        for(account acc: acclist)
        {
            opportunity op = new opportunity();
            op.AccountId=acc.id;
            op.name ='test2';
            op.StageName='closed won';
            op.CloseDate= date.today();
            opplist.add(op);
        }
        insert opplist;
    }    
    
    // When a Case is created on any Account, put the latest case number on the Account in the ‘Latest Case Number’ field -7
    public static void casenumupdate(list<case> caselist)
    {
        list<account> acclist = new list<account>();
        for(case ca :caselist)
        {
            account a = new account();
            a.id =ca.accountid;
            a.Latest_case_number__c=ca.CaseNumber;
            acclist.add(a);
        }
        insert acclist;
    }
    //Account records should have a field named ‘Recent Opportunity Amount’. 
    //Itshould contain the opportunity amount of the latest created opportunity on account -8
    Public static void opporAmt(list<opportunity> opplist){
        list<account> acclist = new list<account>();
        for(opportunity opp: opplist)
        {
            if(opp.AccountId!=null && opp.Amount!=null){
                account a = new account();
                a.id =opp.AccountId;
                a.Opportunity_Amount__c= opp.amount;
                acclist.add(a);
            }
        }
        update acclist;
        /* set<id> ids = new set<id>();
for(opportunity opp:opplist)
{
ids.add(opp.accountid);   
}
Map<decimal,opportunity> maplist = new  Map<decimal,opportunity>();
list<account> acclist = new list<account>();
list<opportunity> opprlist =[select id,accountid,amount from opportunity where accountid in :ids];
for(opportunity op: opprlist)
{
maplist.put(op.amount,op);
}*/
    }
    //On Account create two checkbox fields labeled as Contact and Opportunity.
    //Now when a new Account record is created and if a particular Contact or Opportunity checkbox is checked then create that related record.
    //Also Opportunity record should be created only if the Account record Active picklist is populated with a Yes -9 
    public static void createConOpp(list<account> acclist){
        list<opportunity> opplist = new list<opportunity>();
        list<contact> conlist = new list<contact>();
        for(account acc: acclist)
        {
            if(acc.IsContact__c==true && acc.IsOpportunity__c==true && acc.Active__c=='yes')
            {
                opportunity op =new opportunity();
                op.AccountId=acc.id;
                op.name ='test opp';
                op.closedate=date.today();
                op.stagename='closed won';
                opplist.add(op);
                
                contact con = new contact();
                con.AccountId=acc.id;
                con.LastName='test con1';
                conlist.add(con);
            }
        }
        insert opplist;
        insert conlist;
    }
    // If the Account phone is updated then populate below message indescription.Description = Phone
    //  is Updated! Old Value : XXX & New Value : XXX - 10
    public static void phoneupdate(list<account> acclist,map<id,account> oldmap)
    {
        
        for(account acc:acclist)
        {
            if(oldmap.containskey(acc.id) && acc.phone!=oldmap.get(acc.id).phone)
            {
                system.debug('if entry');
                
                acc.Description='Phone is Updated!  New value' + acc.phone +'old value' +oldmap.get(acc.id).phone;
            }
            
        }
        
    }
    // When an account is inserted or updated and the CopyBillingToShippingcheckbox is checked then automatically 
    // copy the account billing address into account shipping address -11
    public static void autobilling(list<account> acclist){
        for(account acc:acclist)
        {
            if(acc.BillingCity!=null && acc.CopyBillingToShipping__c==true)
            {
                acc.ShippingCity =acc.BillingCity; 
            }
            
        }
    }
    
    // Upon Account Creation or updation if Industry is not null and having valueas ‘Media’ then populate Rating as Hot -12
    public static void ratingUpdate(list<account>acclist){
        for(account acc: acclist)
        {
            if(acc.Industry!=null && acc.Industry=='media')
            {
                acc.rating ='hot';
            }
        }
    }
    // If opportunity Stage is updated upon its creation or update then update description as either 
    // 'Opp is Closed Lost' or 'Opp is Closed Won' or 'Opp isOpen'.  -13
    public static void oppordesc(list<opportunity> opplist)  
    {
        for(opportunity opp:opplist)
        {
            if(opp.StageName=='Closed Won' )
            {
                opp.Description='Opp is Closed Won';
            }
            else if(opp.StageName=='Closed Lost'  )
            {
                opp.Description='Opp is Closed Lost';
            }
            else
            {
                opp.Description='Opp is open';             
            }
        }
    }
    // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Map]-14
    public static void phoUpdate(list<account> acclist){
        set<id> ids = new set<id>();
        Map<id,string> maplist = new Map<id,string>();
        for(account acc: acclist)
        {
            ids.add(acc.id);
            
            
        }
        list<contact> conlist =[select id,accountid,phone from contact where accountid in :ids];
        for(account acc:acclist)
        {
            if(acc.phone!=null){
                 maplist.put(acc.id,acc.phone);
                 system.debug( maplist.put(acc.id,acc.phone));
            }
           
        }
        for(contact con:conlist)
        {
            if( maplist.get(con.AccountId)!=null)
            {
              
                system.debug(maplist.get(con.AccountId));
                con.Phone=maplist.get(con.AccountId);
               
            }
        }
        update conlist;
    }
    
    //Method -2:
    Public static void phoUpdate1(list<account> acclist,map<id,account> oldmap)
    {
        Map<id,account> maplist = new map<id,account>();
        for(account acc:acclist)
        {
            system.debug(acc.phone);
            if((acc.phone!=null ) && oldmap!=null )
            {
                maplist.put(acc.id,acc);
            }
        }
        list<contact> conlist =[select id,accountid,phone from contact where accountid in : maplist.keyset()];
        for(contact con:conlist)
        {
            if(maplist.containskey(con.accountid) && maplist.get(con.AccountId).phone!=null)
            {
                 con.Phone= maplist.get(con.AccountId).phone;
            }
        }
        update conlist;
    }
    // If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field).[Using Parent-Child SOQL]-15
   public static void hoPhoneUpdate(list<account> acclist)
   {
       set<id> ids = new set<id>();
       list<contact> conlist = new list<contact>();
       
       for(account acc:acclist)
       {
           ids.add(acc.id);
       }
       list<account> acclist1 =[select id,name,phone,(select id,accountid,HomePhone from contacts) from account where id in:ids];
      
       for(account acc:acclist1){
       for(contact con:acc.contacts)
       {
           con.HomePhone =acc.phone;
           conlist.add(Con);
       }
       }
       update conlist;
   }
    // If the Account billing address is updated then update related contacts mailing address.[Using Map]-16
public static void billAdd(list<account> acclist)
{

    Map<id,account> maplist = new map<id,account>();
    for(account acc: acclist)
    {
        
        maplist.put(acc.id,acc);
    }
    list<contact> conlist =[select id,accountid,MailingCity from contact where accountid In : maplist.keyset()];
    for(contact con:conlist)
    {
        con.MailingCity = maplist.get(con.AccountId).billingcity;
    }
    update conlist;
}

    // If the Account billing address is updated then update related contacts mailing address.[Using Parent-Child SOQL -17
    public static void billingAdd1(list<account> acclist){
        set<id> ids = new set<id>();
        for(account acc:acclist)
        {
            ids.add(acc.id);
        }
        list<account> acclist1 = [select id,billingcity,(select id,MailingCity from contacts) from account where id in:ids];
        list<contact> conlist = new list<contact>();
        for(account a:acclist1)
        {
            for(contact c:a.contacts){
                c.MailingCity = a.billingcity;
                conlist.add(c);
            }
        }
        update conlist;
    }
 // When a Opportunity Stage (field) is changed, create a Task record on Opportunity and assign it to Logged
 //  In User/Opportunity Owner / Any User  -18 
public static void Oppcreat(list<opportunity> opplist,map<id,opportunity> oldmap)
{
    list<task> tasklist = new list<task>();
    for(opportunity opp:opplist)
    {
        if(opp.StageName!=oldmap.get(opp.id).StageName)
        {
            Task t = new task();
            t.WhatId =opp.id;
            t.Status='completed';
            t.Subject='call';
            t.Priority='normal';
            t.OwnerId=userinfo.getUserId();
            tasklist.add(t);
        }
    }
    insert tasklist;
}
// Write a trigger on Account when Account Active field is updated from ‘Yes’to ‘No’ then check all opportunities 
// associated with the account. Update all Opportunities Stage to close lost if stage not equal to close won -19
public static void accActOpp(list<account> acclist)
{
   
    map<id,account> maplist = new map<id,account>();
    for(account acc:acclist)
    {
        //ids.add(acc.id);
        maplist.put(acc.id,acc);
    }
    
    list<opportunity> opplist =[select id,accountid,stagename from opportunity where accountid in: maplist.keyset()];
    for(opportunity opp: opplist)
    {
        if(maplist.get(opp.AccountId).active__c=='yes' && opp.StageName!='closed won')
        {
            opp.StageName='closed lost';
        }
    }
    update opplist;
}
 //Write a trigger on contact to prevent duplicate records based on ContactEmail   -41
    public static void dupcon(list<contact> conlist,map<id,contact> oldcon){
        set<string> emailexit = new set<string>();
for(contact con:conlist)
{
    if(con.email !=oldcon.get(con.id).email )
    {
        emailexit.add(con.email);
    }
}
        list<contact> conlist1 =[select id,email from contact where email in : emailexit];
         set<string> emailduplexit = new set<string>();
        for(contact con1: conlist1)
        {
            emailduplexit.add(con1.Email);
        }
        for(contact con:conlist)
        {
            if(emailduplexit.contains(con.email))
            {
                con.email.adderror('duplicate found');
            }
        }
    }
 // Create two record types named as “Partner Case” and “Customer Case” onCase Object. On creation of Case, 
 // as per the record type populate the totalnumber of 
 // Partner Case or Customer Case on Account object. CreateCustom Fields on Account to have total numbers -35
 // 
 // Prevent deletion of an account if there is any case related to that account -27
    public static void deltcase(list<account> acclist){
        set<id> ids = new set<id>();
        for(account acc:acclist)
        {
            ids.add(acc.id);
        }
        list<account> acclist1 =[select id,(select id,accountid from cases) from account where id in:ids];
        for(account acc: acclist1)
        {
            if(acc.cases.size()>=0)
            {
                acc.adderror('you cannot delete account case record is available');
            }
        }
    }  
    
 /*𝐖𝐡𝐞𝐧 𝐚 𝐬𝐭𝐚𝐠𝐞𝐍𝐚𝐦𝐞 𝐢𝐬 𝐜𝐡𝐚𝐧𝐠𝐞𝐝 𝐨𝐧 𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐭𝐡𝐞𝐧 𝐜𝐫𝐞𝐚𝐭𝐞 𝐚 𝐓𝐚𝐬𝐤 𝐫𝐞𝐥𝐚𝐭𝐞𝐝 𝐭𝐨 𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲.
 𝐏𝐨𝐩𝐮𝐥𝐚𝐭𝐞 𝐭𝐡𝐞 𝐃𝐞𝐬𝐜𝐫𝐢𝐩𝐭𝐢𝐨𝐧 𝐟𝐢𝐞𝐥𝐝 𝐨𝐧 𝐓𝐚𝐬𝐤 𝐚𝐬 𝐭𝐡𝐞 𝐬𝐚𝐦𝐞 𝐚𝐬 𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐒𝐭𝐚𝐠𝐞𝐍𝐚𝐦𝐞 𝐅𝐢𝐞𝐥𝐝.
 𝐇𝐢𝐧𝐭: 𝐋𝐨𝐨𝐤𝐮𝐩 𝐭𝐨 𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐢𝐬 𝐬𝐭𝐨𝐫𝐞𝐝 𝐢𝐧 𝐖𝐡𝐚𝐭𝐈𝐝 𝐟𝐢𝐞𝐥𝐝 𝐨𝐧 𝐓𝐚𝐬𝐤 𝐎𝐛𝐣𝐞𝐜𝐭.*/
    public static void oppotask(list<opportunity> opplist,map<id,opportunity> oldOpplist)
    {
        list<task> tasklist = new list<task>();
        for(opportunity op:opplist)
        {
            if(oldOpplist!=null && oldOpplist.get(op.id).StageName!=op.StageName)
            {
                task t = new task();
            t.WhatId=op.id;
            t.Description=op.StageName;
            tasklist.add(t);
            }
            
        }
        insert tasklist;
    }
 
   /* 𝐖𝐫𝐢𝐭𝐞 𝐚 𝐭𝐫𝐢𝐠𝐠𝐞𝐫 𝐭𝐡𝐚𝐭 𝐰𝐢𝐥𝐥 𝐩𝐫𝐞𝐯𝐞𝐧𝐭 𝐚 𝐮𝐬𝐞𝐫 𝐟𝐫𝐨𝐦 𝐜𝐫𝐞𝐚𝐭𝐢𝐧𝐠 𝐚 𝐥𝐞𝐚𝐝 𝐭𝐡𝐚𝐭 𝐚𝐥𝐫𝐞𝐚𝐝𝐲 𝐞𝐱𝐢𝐬𝐭𝐬 𝐚𝐬 𝐚 𝐜𝐨𝐧𝐭𝐚𝐜𝐭.
    *  𝐖𝐞 𝐰𝐢𝐥𝐥 𝐮𝐬𝐞 𝐭𝐡𝐞 𝐥𝐞𝐚𝐝 /𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐞𝐦𝐚𝐢𝐥 𝐚𝐝𝐝𝐫𝐞𝐬𝐬 𝐭𝐨 𝐝𝐞𝐭𝐞𝐜𝐭 𝐝𝐮𝐩𝐥𝐢𝐜𝐚𝐭𝐞𝐬*/
 
  /*𝐖𝐫𝐢𝐭𝐞 𝐚 𝐓𝐫𝐢𝐠𝐠𝐞𝐫 𝐭𝐨 𝐬𝐡𝐨𝐰 𝐚𝐧 𝐄𝐑𝐑𝐎𝐑 𝐢𝐟 𝐭𝐡𝐞𝐫𝐞 𝐚𝐫𝐞 𝐚𝐥𝐫𝐞𝐚𝐝𝐲 𝐭𝐰𝐨 𝐂𝐨𝐧𝐭𝐚𝐜𝐭𝐬 𝐩𝐫𝐞𝐬𝐞𝐧𝐭 𝐨𝐧 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 
    𝐚𝐧𝐝 𝐭𝐡𝐞 𝐮𝐬𝐞𝐫 𝐭𝐫𝐢𝐞𝐬 𝐭𝐨 𝐚𝐝𝐝 𝐨𝐧𝐞 𝐦𝐨𝐫𝐞 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐧 𝐢𝐭.*/
    public static void errorconMsg(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            if(con.accountid!=null)
            {
                ids.add(con.AccountId);
            }
        }
        list<contact> conlist1 =[select id,name,accountid from contact where accountid in : ids];
        for(contact con:conlist)
        {
            if(conlist1.size()>=2)
            {
                con.adderror('this account as already having 2 contacts');
            }
        }
    }
   /* 𝐖𝐡𝐞𝐧 𝐰𝐞 𝐜𝐫𝐞𝐚𝐭𝐞 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐰𝐢𝐭𝐡 𝐩𝐫𝐨𝐛𝐚𝐛𝐢𝐥𝐢𝐭𝐲 =𝟓𝟎% 𝐭𝐡𝐞𝐧 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐨𝐰𝐧𝐞𝐫 𝐰𝐢𝐥𝐥 𝐛𝐞 𝐚𝐮𝐭𝐨𝐦𝐚𝐭𝐢𝐜𝐚𝐥𝐥𝐲 𝐚𝐝𝐝𝐞𝐝 
    * 𝐭𝐨 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐓𝐞𝐚𝐦 𝐨𝐟 𝐭𝐡𝐞 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐟𝐨𝐫 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲.  
    public static void oppoAccTeam(list<opportunity> opplist){
        map<id,opportunity> maplist = new map<id,opportunity>();
        for(opportunity op:opplist)
        {
            maplist.put(op.AccountId,op);
        }
        list<AccountTeamMember> accTM = new list<AccountTeamMember>();
        list<account>acclist =[select id,name from account where id in:ids ];
        for(account acc:acclist)
        {
            if(maplist!=null)
        }
    }*/
   /*𝐰𝐫𝐢𝐭𝐞 𝐚 𝐭𝐫𝐢𝐠𝐠𝐞𝐫 𝐨𝐧 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐖𝐡𝐞𝐧 𝐭𝐡𝐞 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐬 𝐮𝐩𝐝𝐚𝐭𝐞𝐝 𝐜𝐡𝐞𝐜𝐤 𝐚𝐥𝐥 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐢𝐞𝐬 𝐫𝐞𝐥𝐚𝐭𝐞𝐝 𝐭𝐨 𝐭𝐡𝐞 𝐀𝐜𝐜𝐨𝐮𝐧𝐭. 
    * 𝐮𝐩𝐝𝐚𝐭𝐞𝐝 𝐚𝐥𝐥 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐢𝐞𝐬 𝐬𝐭𝐚𝐠𝐞 𝐭𝐨 '𝐂𝐥𝐨𝐬𝐞𝐝 𝐋𝐨𝐬𝐭' 𝐢𝐟 𝐚𝐧 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐜𝐫𝐞𝐚𝐭𝐞𝐝 𝐝𝐚𝐭𝐞 𝐢𝐬 𝐠𝐫𝐞𝐚𝐭𝐞𝐫 𝐭𝐡𝐚𝐧 𝟑𝟎 𝐝𝐚𝐲𝐬 𝐟𝐫𝐨𝐦 𝐭𝐨𝐝𝐚𝐲 
     𝐚𝐧𝐝 𝐬𝐭𝐚𝐠𝐞 𝐧𝐨𝐭 𝐞𝐪𝐮𝐚𝐥 𝐭𝐨 '𝐂𝐥𝐨𝐬𝐞 𝐖𝐨𝐧'*/ 
    public static void oppstageChange(list<account> acclist)
    {
        set<id> ids = new set<id>();
        for(account acc: acclist)
        {
            ids.add(acc.id);
        }
        list<opportunity> opplist =[select id,name,AccountId from opportunity where AccountId in : ids];
        for(account acc:acclist)
        {
           for(opportunity op: opplist)
           {
               if(op.AccountId == acc.id && op.CreatedDate<system.now()-30 && op.StageName!='𝐂𝐥𝐨𝐬𝐞 𝐖𝐨𝐧')
               {
                    op.StageName = '𝐂𝐥𝐨𝐬𝐞𝐝 𝐋𝐨𝐬𝐭';
                   opplist.add(op);
               }
           }
        }
        update opplist;
    }
// 𝐰𝐫𝐢𝐭𝐞 𝐚 𝐭𝐫𝐢𝐠𝐠𝐞𝐫 𝐟𝐨𝐫 " 𝐅𝐨𝐫 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐲𝐨𝐮 𝐬𝐡𝐨𝐮𝐥𝐝 𝐧𝐨𝐭 𝐛𝐞 𝐚𝐛𝐥𝐞 𝐭𝐨 𝐜𝐫𝐞𝐚𝐭𝐞 𝐦𝐨𝐫𝐞 𝐭𝐡𝐚𝐧 𝐭𝐰𝐨 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐢𝐞𝐬 
    public static void triggeracc(list<opportunity> opplist){
        set<id> ids = new set<id>();
        for(opportunity opp :opplist)
        {
            ids.add(opp.accountid);
        }
        list<account> acclist = [select id,name,(select id from opportunities) from account where id in : ids];
        map<id,integer> maplist = new map<id,integer>();
      
        
            for(account acc:acclist)
        {
            maplist.put(acc.id,acc.opportunities.size());
        }
          
        for(opportunity opp:opplist){
            system.debug('opplist '+maplist.get(opp.accountid));
            if(maplist.containskey(opp.accountid) && maplist.get(opp.accountid)>=2)
            {
                opp.adderror('you can not insert more than 2 opportunity records');
            }
        }
    }
   
    /* 𝐎𝐧 𝐮𝐬𝐞𝐫𝐬 𝐮𝐩𝐝𝐚𝐭𝐢𝐧𝐠 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐫𝐞𝐜𝐨𝐫𝐝𝐬, 𝐢𝐟 𝐭𝐡𝐞 𝐛𝐢𝐥𝐥𝐢𝐧𝐠 𝐚𝐝𝐝𝐫𝐞𝐬𝐬 𝐢𝐬 𝐜𝐡𝐚𝐧𝐠𝐞𝐝 𝐭𝐡𝐞𝐧 𝐮𝐩𝐝𝐚𝐭𝐞 𝐚𝐥𝐥 𝐢𝐭𝐬 𝐜𝐡𝐢𝐥𝐝 𝐜𝐨𝐧𝐭𝐚𝐜𝐭𝐬 𝐦𝐚𝐢𝐥 𝐚𝐝𝐝𝐫𝐞𝐬𝐬
       𝐟𝐢𝐞𝐥𝐝𝐬 𝐬𝐚𝐦𝐞 𝐚𝐬 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐛𝐢𝐥𝐥𝐢𝐧𝐠 𝐚𝐝𝐝𝐫𝐞𝐬𝐬𝐞𝐬. */
  public static void bilAcco(list<account> acclist)
  {
      set<id> ids = new set<id>();
      for(account acc:acclist)
      {
          ids.add(acc.id);
      }
      list<contact> conlist =[select id,accountid,MailingCity from contact where accountid in:ids];
      list<contact> con1 = new list<contact>();
      for(contact con:conlist)
      {
          for(account acc: acclist)
          {
              con.MailingCity =acc.BillingCity;
              con1.add(con);
          }
      }
      update con1;
  }
    public static void mailContact(list<account> acclist){
        set<id> ids = new set<id>();
       for(account acc:acclist)
      {
          ids.add(acc.id);
      }
      list<contact> conlist =[select id,accountid,MailingCity from contact where accountid in:ids];
      list<contact> con1 = new list<contact>(); 
        map<id,string> maplist = new map<id,string>(); 
        for(account acc:acclist)
      {
          maplist.put(acc.id,acc.BillingCity);
      }
        for(contact con:conlist)
      {
          if(maplist.get(con.AccountId)!=null){
        con.MailingCity =maplist.get(con.AccountId);
              con1.add(con);
          }
      }
         update con1;
    }   
    
/*"𝐖𝐫𝐢𝐭𝐞 𝐚 𝐭𝐫𝐢𝐠𝐠𝐞𝐫 𝐭𝐡𝐚𝐭 𝐰𝐢𝐥𝐥 𝐩𝐫𝐞𝐯𝐞𝐧𝐭 𝐚 𝐮𝐬𝐞𝐫 𝐟𝐫𝐨𝐦 𝐜𝐫𝐞𝐚𝐭𝐢𝐧𝐠 𝐚 𝐥𝐞𝐚𝐝 𝐭𝐡𝐚𝐭 𝐚𝐥𝐫𝐞𝐚𝐝𝐲 𝐞𝐱𝐢𝐬𝐭𝐬 𝐚𝐬 𝐚 𝐜𝐨𝐧𝐭𝐚𝐜𝐭. 
 * 𝐖𝐞 𝐰𝐢𝐥𝐥 𝐮𝐬𝐞 𝐭𝐡𝐞 𝐥𝐞𝐚𝐝 /𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐞𝐦𝐚𝐢𝐥 𝐚𝐝𝐝𝐫𝐞𝐬𝐬 𝐭𝐨 𝐝𝐞𝐭𝐞𝐜𝐭 𝐝𝐮𝐩𝐥𝐢𝐜𝐚𝐭𝐞𝐬." */
   public static void  duplicateemailMethod(list<lead> leadlist)
   {
       set<string> Leemail = new set<string>();
       for(lead le:leadlist)
       {
           Leemail.add(le.email);
       }
       set<string>conEmail = new set<string>();
       list<contact> conlist =[select id,email from contact  where email in :leemail];
       for(contact con:conlist)
       {
           conEmail.add(con.Email);
       }
       for(lead le:leadlist)
       {
           if(conemail.contains(le.email))
           {
               le.adderror('this mail is already existed in contact. you can not create/updated lead record');
           }
       }
   }
 /* "𝐖𝐡𝐞𝐧𝐞𝐯𝐞𝐫 𝐫𝐞𝐜𝐨𝐫𝐝 𝐨𝐟 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐨𝐛𝐣 𝐢𝐬 𝐮𝐩𝐝𝐚𝐭𝐞𝐝, 𝐛𝐞𝐟𝐨𝐫𝐞 𝐮𝐩𝐝𝐚𝐭𝐢𝐧𝐠 𝐭𝐡𝐞 𝐫𝐞𝐜𝐨𝐫𝐝 𝐜𝐫𝐞𝐚𝐭𝐞 
     𝐧𝐞𝐰 𝐫𝐞𝐜𝐨𝐫𝐝 𝐢𝐧 𝐂𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐛𝐣𝐞𝐜𝐭 𝐰𝐢𝐭𝐡 𝐨𝐥𝐝 𝐯𝐚𝐥𝐮𝐞𝐬 𝐨𝐟 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐫𝐞𝐜𝐨𝐫𝐝*/ 
  public static void autoCreateContact(list<account> acclist, map<id,account> oldmapacc)
  {
      list<contact> conlist = new list<contact>();
      for(account acc : acclist)
      {
          system.debug('acc '+ acc);
          account oldvalues = oldmapacc.get(acc.id);
          if(oldmapacc!=null   && oldvalues.Industry != acc.Industry
            && oldvalues.Phone != acc.phone && oldvalues.rating != acc.rating)
          {
              contact  con = new contact();
              con.LastName = oldvalues.Name;
            
              con.phone =  oldvalues.phone;
              con.AccountId=oldvalues.id;
              conlist.add(con);
          }
      }
      if(!conlist.isempty()){
           insert conlist;
      }
     
  }
/* 𝐖𝐫𝐢𝐭𝐞 𝐚 𝐓𝐫𝐢𝐠𝐠𝐞𝐫 𝐭𝐨 𝐬𝐡𝐨𝐰 𝐚𝐧 𝐄𝐑𝐑𝐎𝐑 𝐢𝐟 𝐭𝐡𝐞𝐫𝐞 𝐚𝐫𝐞 𝐚𝐥𝐫𝐞𝐚𝐝𝐲 𝐭𝐰𝐨 𝐂𝐨𝐧𝐭𝐚𝐜𝐭𝐬 𝐩𝐫𝐞𝐬𝐞𝐧𝐭 𝐨𝐧 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐚𝐧𝐝 𝐭𝐡𝐞 𝐮𝐬𝐞𝐫 𝐭𝐫𝐢𝐞𝐬 𝐭𝐨 𝐚𝐝𝐝 𝐨𝐧𝐞 𝐦𝐨𝐫𝐞 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐧 𝐢𝐭.*/
    public static void conerror(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con: conlist)
        {
            ids.add(con.accountid);
            
        }
        list<contact> conlist1 = [select id,accountid from contact where accountid in:ids];
        for(contact con : conlist1)
        {
            if(conlist.size()>=2)
            {
                con.adderror('you can not create more than 2 contacts');
            }
        }
         /* 𝐖𝐡𝐞𝐧 𝐰𝐞 𝐜𝐫𝐞𝐚𝐭𝐞 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐰𝐢𝐭𝐡 𝐩𝐫𝐨𝐛𝐚𝐛𝐢𝐥𝐢𝐭𝐲 =𝟓𝟎% 𝐭𝐡𝐞𝐧 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐨𝐰𝐧𝐞𝐫 𝐰𝐢𝐥𝐥 𝐛𝐞 𝐚𝐮𝐭𝐨𝐦𝐚𝐭𝐢𝐜𝐚𝐥𝐥𝐲 𝐚𝐝𝐝𝐞𝐝 𝐭𝐨 
    𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐓𝐞𝐚𝐦 𝐨𝐟 𝐭𝐡𝐞 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐟𝐨𝐫 𝐭𝐡𝐞 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲.*/
    }   
    
   
  /* 𝐖𝐡𝐞𝐧𝐞𝐯𝐞𝐫 𝐚 𝐧𝐞𝐰 𝐭𝐫𝐚𝐧𝐬𝐚𝐜𝐭𝐢𝐨𝐧 (𝐟𝐢𝐞𝐥𝐝 𝐨𝐟 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐛𝐣𝐞𝐜𝐭) 𝐢𝐬 𝐩𝐞𝐫𝐟𝐨𝐫𝐦𝐞𝐝 𝐬𝐮𝐜𝐜𝐞𝐬𝐬𝐟𝐮𝐥𝐥𝐲 𝐭𝐡𝐞𝐧 𝐮𝐩𝐝𝐚𝐭𝐞 𝐭𝐡𝐞 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐨𝐛𝐣𝐞𝐜𝐭 ‘𝐛𝐚𝐥𝐚𝐧𝐜𝐞’ 𝐟𝐢𝐞𝐥𝐝 𝐛𝐚𝐬𝐞𝐝 𝐨𝐧 ->
    * 𝐈𝐟 𝐓𝐫𝐚𝐧𝐬𝐚𝐜𝐭𝐢𝐨𝐧 𝐓𝐲𝐩𝐞=𝐃𝐞𝐩𝐨𝐬𝐢𝐭, 𝐁𝐚𝐥𝐚𝐧𝐜𝐞 = 𝐛𝐚𝐥𝐚𝐧𝐜𝐞 + 𝐚𝐦𝐨𝐮𝐧𝐭; 𝐚𝐧𝐝 𝐢𝐟 𝐓𝐫𝐚𝐧𝐬𝐚𝐜𝐭𝐢𝐨𝐧 𝐓𝐲𝐩𝐞 𝐰𝐢𝐭𝐡𝐝𝐫𝐚𝐰 𝐛𝐚𝐥𝐚𝐧𝐜𝐞 = 𝐛𝐚𝐥𝐚𝐧𝐜𝐞 - 𝐚𝐦𝐨𝐮𝐧𝐭; " 

𝟏.𝐜𝐫𝐞𝐚𝐭𝐞 𝐭𝐰𝐨 𝐜𝐮𝐬𝐭𝐨𝐦 𝐟𝐢𝐞𝐥𝐝 𝐨𝐧 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐧𝐚𝐦𝐞𝐝 '𝐀𝐦𝐨𝐮𝐧𝐭'(𝐟𝐢𝐞𝐥𝐝𝐓𝐲𝐩𝐞 = 𝐍𝐮𝐦𝐛𝐞𝐫) 
 𝐚𝐧𝐝 '𝐓𝐫𝐚𝐧𝐬𝐚𝐜𝐭𝐢𝐨𝐧𝐓𝐲𝐩𝐞' 𝐯𝐚𝐥𝐮𝐞𝐬 {𝐃𝐞𝐩𝐨𝐬𝐢𝐭, 𝐖𝐢𝐭𝐡𝐝𝐫𝐚𝐰} (𝐟𝐢𝐞𝐥𝐝𝐓𝐲𝐩𝐞 = 𝐏𝐢𝐜𝐤𝐋𝐢𝐬𝐭).

𝟐. 𝐚𝐥𝐬𝐨 𝐜𝐫𝐞𝐚𝐭𝐞 𝐨𝐧𝐞 𝐜𝐮𝐬𝐭𝐨𝐦 𝐟𝐢𝐞𝐥𝐝 𝐨𝐧 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐧𝐚𝐦𝐞𝐝 '𝐁𝐚𝐥𝐚𝐧𝐜𝐞'(𝐟𝐢𝐞𝐥𝐝𝐓𝐲𝐩𝐞 = 𝐧𝐮𝐦𝐛𝐞𝐫)*/ 
    
    public static void blcUpdate(list<contact> conlist)
    {
        set<id> ids = new set<id>();
        map<id,decimal> maplist = new  map<id,decimal>();
        Map<id,string> maplist1 = new map<id,string>();
        for(contact con : conlist)
        {
            
            ids.add(con.accountid);
            maplist.put(con.id,con.Amount__c);
            maplist1.put(con.id,con.TransactionType__c);
        }
        list<account> acclist =[select id,name, (SELECT Id,TransactionType__c,Amount__c FROM Contacts) from account where id in : ids];
        list<account> acc1 = new list<account>();
        decimal total=0;
        for(account acc: acclist)
        {
            for(contact con:conlist)
            {
                 if(maplist.get(con.id)!=null && maplist1.get(con.id)=='𝐃𝐞𝐩𝐨𝐬𝐢𝐭')
                 {
                     total +=con.Amount__c;
                 }
                else if(maplist.get(con.id)!=null && maplist1.get(con.id)=='𝐖𝐢𝐭𝐡𝐝𝐫𝐚𝐰')
                 {
                     total -=con.Amount__c;
                 }
            }
              acc.Balance__c=total;
                acc1.add(acc);
        }
        if(!acc1.isempty())
        {
            update acc1;
        }
    }
    
/*𝐖𝐫𝐢𝐭𝐞 𝐚 𝐭𝐫𝐢𝐠𝐠𝐞𝐫 𝐭𝐨 𝐞𝐧𝐬𝐮𝐫𝐞 𝐭𝐡𝐚𝐭 𝐨𝐧𝐥𝐲 𝐨𝐧𝐞 '𝐩𝐫𝐢𝐦𝐚𝐫𝐲 𝐂𝐨𝐧𝐭𝐚𝐜𝐭' 𝐬𝐡𝐨𝐮𝐥𝐝 𝐛𝐞 𝐩𝐫𝐞𝐬𝐞𝐧𝐭 𝐨𝐧 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭, 
𝐚𝐧𝐝 𝐢𝐟 𝐚 𝐮𝐬𝐞𝐫 𝐭𝐫𝐢𝐞𝐝 𝐭𝐨 𝐚𝐝𝐝 𝐦𝐨𝐫𝐞 𝐭𝐡𝐚𝐧 𝐨𝐧𝐞 '𝐩𝐫𝐢𝐦𝐚𝐫𝐲 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐰𝐡𝐞𝐭𝐡𝐞𝐫 𝐛𝐲 𝐢𝐧𝐬𝐞𝐫𝐭𝐢𝐨𝐧 𝐨𝐫 𝐮𝐩𝐝𝐚𝐭𝐢𝐨𝐧 𝐭𝐡𝐞𝐧,
 𝐢𝐧 𝐭𝐡𝐚𝐭 𝐜𝐚𝐬𝐞 𝐲𝐨𝐮 𝐧𝐞𝐞𝐝 𝐭𝐨 𝐬𝐡𝐨𝐰 𝐞𝐫𝐫𝐨𝐫 𝐦𝐞𝐬𝐬𝐚𝐠𝐞 𝐥𝐢𝐤𝐞:
"𝐀𝐧 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐜𝐚𝐧𝐧𝐨𝐭 𝐡𝐚𝐯𝐞 𝐦𝐨𝐫𝐞 𝐭𝐡𝐚𝐧 𝐨𝐧𝐞 𝐩𝐫𝐢𝐦𝐚𝐫𝐲 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 ",
 𝐜𝐫𝐞𝐚𝐭𝐞 𝐚 𝐜𝐮𝐬𝐭𝐨𝐦 𝐟𝐢𝐞𝐥𝐝 𝐨𝐧 𝐜𝐨𝐧𝐭𝐚𝐜𝐭 𝐨𝐛𝐣𝐞𝐜𝐭 𝐧𝐚𝐦𝐞𝐝 𝐢𝐬𝐏𝐫𝐢𝐦𝐚𝐫𝐲__𝐜(𝐜𝐡𝐞𝐜𝐤𝐁𝐨𝐱).*/   
public static void primContact(list<contact> conlist,map<id,contact> oldconlist)
{
    set<id> ids = new set<id>();
    for(contact con:conlist)
    {
        if((oldconlist==null || oldconlist!=null) &&(oldconlist.get(con.id).accountid== con.AccountId) &&  con.IsPrimary__c==true )
        ids.add(con.accountid);
    }
    Map<id,boolean> maplist = new  Map<id,boolean>();
    list<contact> conlist1 =[select id,accountid,IsPrimary__c from contact where IsPrimary__c=true and accountid in :ids];
    for(contact c:conlist1 )
    {
        maplist.put(c.accountid,c.IsPrimary__c);
    }
    for(contact con:conlist)
    {
        if(maplist.containsKey(con.accountid) && con.IsPrimary__c==true)
        {
            con.adderror('primary contact already existed');
        }
    }
}
    
 // If x=5, y=10, i want change the values x=10 and y=5, how to do that.
 public static void swapmethod(integer X,integer Y)
 {
     integer z=X;
    
     X=Y;
     y=Z;
     system.debug('number is' +x+ '  ' +y);
 }
    
 /* billing state need to copy in contact*/
    Public static void accountbilling(list<account> acclist){
        set<id> ids = new set<id>();
        map<id,account> accMap = new map<id,account>();
        for(account acc : acclist)
        {
            if(acc.billingstate!=null)
            {
                ids.add(acc.id);
                accMap.put(acc.id,acc);
            }
        }
        List<contact> conlist = [select id,accountid,mailingstate from contact where accountid in: ids];
        list<contact> con1 = new list<contact>();
        for(contact con:conlist)
        {
            con.MailingState= accMap.get(con.AccountId).billingstate;
            con1.add(con);
        }
        if(con1.size()>0){
            update con1;
        }
    }
 /*write count the opportunity in parent object  */    
    public static void opporcount(list<opportunity> opplist)
    {
        set<id> ids = new set<id>();
        for(opportunity opp:opplist)
        {
            ids.add(opp.AccountId);
            
        }
       list<aggregateresult> agglist =[select count(id)ids,accountid from opportunity where accountid in :ids group by accountid];
        list<account> acclist = new list<account>();
        for(aggregateresult agg: agglist)
        {
            account acc = new account();
            acc.id =(id)agg.get('accountid');
            acc.No_of_opportunity__c =(decimal)agg.get('id');
            acclist.add(acc);
        }
        update acclist;
    }
    /* Prevent deletion of an account if there is any open case related to that account */
    public static void accRecord(list<account> acclist)
    {
        set<id> ids = new set<id>();
        for(account acc: acclist)
        {
            ids.add(acc.id);
        }
        List<account> acclist1 =[select id,name,(select id,status from cases where status='open')from account where id in :ids];
        for(account acc: acclist1)
        {
          if(acc.ownerid !=userinfo.getuserId())   
          {
              acc.adderror('you cannot delete the account');
          }
        }
    }
    
    // duplicat values in phone and email
    public static void contactvalidate(list<contact> newlist){
    set<string> existemail = new set<string>();
    set<string> existPhone = new set<string>();
    list<contact> conlist1 =[select id,phone,email from contact where phone in : existPhone or email in : existemail];
    for(contact con: conlist1)
    {
        existemail.add(con.email);
        existPhone.add(con.phone);
    }
        
        for(contact con1:newlist) 
        {
           if(con1.phone != null && existPhone.contains(string.valueof(con1.phone))) {
                con1.addError('Duplicate phone number found.');
            }
            if(con1.email != null && existemail.contains(string.valueof(con1.email))) {
                con1.addError('Duplicate email found.');
            }
        }
    }
    
/*𝐭𝐡𝐞𝐫𝐞 𝐢𝐬 𝐚 𝐜𝐮𝐬𝐭𝐨𝐦 𝐨𝐛𝐣𝐞𝐜𝐭 𝐜𝐚𝐥𝐥𝐞𝐝 "𝐜𝐥𝐢𝐞𝐧𝐭__𝐜' 𝐡𝐚𝐯𝐢𝐧𝐠 𝐭𝐰𝐨 𝐜𝐮𝐬𝐭𝐨𝐦 𝐟𝐢𝐥𝐞𝐝 '𝐩𝐡𝐨𝐧𝐞__𝐜' 𝐚𝐧𝐝 '𝐜𝐨𝐮𝐧𝐭𝐫𝐲__𝐜', 
𝐛𝐚𝐬𝐞 𝐨𝐧 '𝐜𝐨𝐮𝐧𝐭𝐫𝐲__𝐜' 𝐚𝐝𝐝 𝐈𝐒𝐃[𝐈𝐧𝐭𝐞𝐫𝐧𝐚𝐭𝐢𝐨𝐧𝐚𝐥 𝐒𝐮𝐛𝐬𝐜𝐫𝐢𝐛𝐞𝐫 𝐃𝐢𝐚𝐥𝐢𝐧𝐠] 𝐜𝐨𝐝𝐞 𝐨𝐧 𝐭𝐡𝐞𝐢𝐫 '𝐩𝐡𝐨𝐧𝐞__𝐜'. 
𝐟𝐨𝐫 𝐢𝐧𝐬𝐭𝐚𝐧𝐜𝐞: 
['𝐢𝐧𝐝𝐢𝐚' : '+𝟗𝟏']
['𝐔𝐒𝐀' : '+𝟔𝟏']"*/    
    
    public static void clientFieldUpdate(list<Client__c> cliList)
    {
        Map<string,string> strngName = new Map<string,string>{'India'=>'+91', 'USA'=>'+61'};
        for(Client__c cli: cliList)
        {
            string isdcode = strngName.get(cli.country__c);
            if (isdCode != null) {
            // Ensure the ISD code is only prepended if it's not already present
            if (!cli.Phone__c.startsWith(isdCode)) {
                cli.Phone__c = isdCode + cli.Phone__c;
            }
        }
        }
    }
/* Whenever a user creates a new account record, check if a record with the same name already exists in the database. If it does, show an error.*/
    public static void errorAccountDuplicate(list<account> acclist)
    {
        set<string> newname = new set<string>();
        for(account acc:acclist)
        {
          newname.add(acc.name);  
        }
        Map<id,account> maplist = new map<id,account>();
        List<account> ExistAcclist = [select id,name from account where name in :newname ];
        for(account existacc:ExistAcclist)
        {
            maplist.put(existacc.id,existacc);
        }
        
    }
 // Whenever user is creating new account record, check if the record is already available with the same name in the database. 
 // if yes then all the contact related to that existing account record should be associated with the newly created account record.   
   public static void duplicatcon(list<account> acclist)
   {
       list<account> acclist1 =[select id,name from account];
       set<id> accid = new set<id>();
       Map<id,account> mapAcc = new map<id,account>();
       for(account acc1: acclist1)
       {
           accid.add(acc1.id);
           mapAcc.put(acc1.id,acc1);
       }
       system.debug('mapAcc ' + mapAcc);
       list<contact> conlist =[select id,name,accountid from contact where accountid in: accid];
        system.debug('conlist ' + conlist.size());
       map<id,contact> mapCon = new map<id,contact>();
       for(contact con:conlist)
       {
           mapCon.put(con.id,con);
       }
       system.debug('mapCon ' + mapCon);
       list<contact> conlist1 = new list<contact>();
       for(account acc: acclist)
       {
           if(acc.name == mapAcc.get(acc.id).name)
           {
               contact c = new contact();
                system.debug('firstname ' + mapCon.get(c.id).firstname);
                system.debug('LastName ' + mapCon.get(c.id).lastname);
               c.firstname = mapCon.get(c.id).firstname;
               c.LastName = mapCon.get(c.id).lastname;
                system.debug('c.LastName ' + c.LastName);
               c.AccountId =acc.id;
               conlist1.add(c);
           }
       }
       insert conlist1;
   }
}