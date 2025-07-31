public class TriggersScenarios {
    // Write a trigger on contact to prevent duplicate records based on Contact Email & Contact Phone.
    Public static void duplicatevalue(list<contact> conrecord)
    {
        list<contact> conlist =[select id,name,email,phone from contact where email!=null and phone!=null];
        Map<id,string> existingPhone = new Map<id,string>();
        Map<id,string> existingmail = new Map<id,string>();
        for(contact conli:conlist)
        {
            existingPhone.put(conli.id,conli.phone);
            existingmail.put(conli.id,conli.email);
        }
        for(contact con:conrecord)
        {
            if(con.email!=null && con.email==existingmail.get(con.id))
            {
                con.email.adderror('duplicate mail id found');  
            }
            if(con.phone!=null && con.phone==existingPhone.get(con.id))
            {
                con.phone.adderror('duplicate ph num found');
            }
        }
    }
    //Write a trigger, only the system admin user should be able to delete the task.
    
    
    // : On the account object , the phone field of related contact is 
    // automatically updated if the phone field of the account is added to or modified.      
    public static void autoUpdatePh   (list<account> accrecord) 
    {
        set<id> ids = new set<id>();
        for(account acc: accrecord)
        {
            if(acc.id!=null){
                ids.add(acc.id);
            }
            
        }
        list<contact> conlist =[select id,accountid,name,phone,account.phone from contact where accountid in:ids];
        for(contact conli:conlist)
        {
            if(conli.account.phone!=null)
            {
                conli.phone = conli.account.phone;
            }
            
        }
        if(conlist.size()>0 && conlist!=null)
        {
            update conlist;
        }
    }
    //  𝘞𝘳𝘪𝘵𝘦 𝘢 𝘵𝘳𝘪𝘨𝘨𝘦𝘳 𝘸𝘩𝘦𝘯 𝘢𝘯 𝘢𝘤𝘤𝘰𝘶𝘯𝘵 𝘪𝘴 𝘤𝘳𝘦𝘢𝘵𝘦𝘥 𝘢𝘶𝘵𝘰𝘮𝘢𝘵𝘪𝘤 
    //𝘪𝘵𝘴 𝘳𝘦𝘭𝘢𝘵𝘦𝘥 𝘤𝘰𝘯𝘵𝘢𝘤𝘵 𝘪𝘴 𝘤𝘳𝘦𝘢𝘵𝘦𝘥 𝘢𝘴 𝘸𝘦𝘭𝘭 𝘢𝘴 𝘰𝘱𝘱𝘰𝘳𝘵𝘶𝘯𝘪𝘵𝘺 𝘢𝘭𝘴𝘰
    public static void insertConOpp(list<account> accrecord)  
    {
        list<contact> conlist = new  list<contact>();
        list<Opportunity> opp = new list<Opportunity>();
        for(account a:accrecord)
        {
            contact conrecord = new contact();
            conrecord.accountid= a.id;
            conrecord.Firstname ='Sakee';
            conrecord.Lastname ='M';
            conlist.add(conrecord);
            
            Opportunity Opprecord = new Opportunity();
            Opprecord.AccountId=a.id;
            Opprecord.Name='Sakee';
            Opprecord.StageName='Prospecting';
            opprecord.CloseDate=date.today();
            opp.add(opprecord);
            
        }
        insert conlist;
        insert opp;
    }
    // Create a field on Account Named (Client Opportunity lookup to Opportunity). Once an Account is inserted an opportunity
    //  will create with the name of the Account and that Opportunity will be the Client Opportunity on the Account.  
    public static void clientOppUpdate(list<account> acclist)
    {
        list<Opportunity> opplist = new  list<Opportunity>();
        map<id,id> oldmap = new   map<id,id>();
        list<account> updateAccount = new list<account>();
        for(account ac: acclist)
        {
            Opportunity opp= new Opportunity();
            opp.AccountId=ac.id;
            opp.Name=ac.name;
            opp.StageName='Prospecting';
            opp.CloseDate=date.today();
            opplist.add(opp);
        }
        insert opplist;
        for(Opportunity op1: opplist )
        {
            oldmap.put(op1.accountid,op1.id);
        }
        list<account> accoulist =[select id,name,Client_Opportunity__c from account where id in:oldmap.keyset() ];
        for(account a1:accoulist )
        {
            a1.Client_Opportunity__c=oldmap.get(a1.id);
            updateAccount.add(a1);
        }
        update updateAccount;
    }
    //Create a trigger that sends an email notification 
    //to the account owner if the account's annual revenue exceeds 50K within 30 days
    
    //Create a field Opportunity amount on Account object and write a trigger on Opportunity to populate
    // the total sum of all opportunity Amount on Account Object Opportunity amount field
    public static void oppoAmount(list<Opportunity> oppRecord){
        set<id>ids = new set<id>();
        for(Opportunity opp1: oppRecord)
        {
            if(opp1.accountid!=null)
            {
                ids.add(opp1.accountid);
            }
        }
        list<account> updateAccount = new list<account>();
        Map<Id, Decimal> accountSumAmountMap = new Map<Id, Decimal>();
        list<AggregateResult> agglist =[select id,sum(Amount) amot,accountid from Opportunity where accountid in: ids group by id,accountid ];
        for(AggregateResult agg:agglist )
        {
            id accountid =(id)agg.get('accountid');
            decimal oppAmt =(decimal)agg.get('amot');
            accountSumAmountMap.put(accountid,oppAmt);
            
        }
        for(id accountid :accountSumAmountMap.keyset())
        {
            account acc = new account();
            acc.id= accountid;
            acc.Opportunity_Amount__c=accountSumAmountMap.get(accountid);
            updateAccount.add(acc);
        }
        
        update updateAccount;
    }
    // 𝑻𝒓𝒊𝒈𝒈𝒆𝒓 𝑺𝒄𝒆𝒏𝒂𝒓𝒊𝒐
    
    //Create "Sales Rep" field with the data type(Text) on the Account object When we create the Account record, 
    //the Account owners will be automatically added to the sales rep field. When we update the Account owner of the record,
    // then also the Sales Rep will be automatically updated.
    
    // 𝑻𝒓𝒊𝒈𝒈𝒆𝒓 𝑺𝒄𝒆𝒏𝒂𝒓𝒊𝒐
   //Create a custom field on the Account named 'Total Number of Contacts' and populate the number of 
    //contacts associated with that specific account
    public static void countContact(list<contact> conrecord)
    {
        set<id> ids = new set<id>();
        for(contact con:conrecord)
        {
            if(con.accountid!=null)
            {
                ids.add(con.accountid);
            }
        }
        List<aggregateresult> conlist =[select count(id)conre,accountid from contact where accountid in:ids group by accountid];
        list<account> acclist = new list<account>();
        for(aggregateresult con1:conlist)
        {
            account a1 = new account();
            a1.id =(id)con1.get('accountid');
            a1.Total_Number_of_Contacts__c=(decimal)con1.get('conre');
            acclist.add(a1);
        }
        update acclist;
    }
    //whenever a create opportunity object record updated total opportunity and total amount in account object
    public static void countSumOpp(list<opportunity> opprecord)  
    {
        set<id> ids = new set<id>();
        for(opportunity op:opprecord)
        {
            if(op.accountid!=null)
            {
                ids.add(op.accountid);
            }
            
        }
        list<opportunity> opplist =[select id,amount,accountid from opportunity where accountid in:ids and amount!=null];
        list<account> acclist = new list<account>();
        decimal totalsize =opplist.size();
        for(opportunity op:opplist)
        {
            
            account a = new account();
            a.id =op.accountid;
            decimal sum=0;
            system.debug(op.Amount);
            system.debug(sum);
            sum=sum+op.Amount;
            a.Opportunity_Amount__c=sum;
            a.No_of_opportunity__c=totalsize;
            acclist.add(a);
        }
        update acclist;
    }
    // contact object whenever department equal to cse automatically updated mail
    public static void conequal(list<contact> conrecord)
    {
        for(contact con: conrecord)
        {
            if(con.Department=='CSE')
            {
                con.email ='test@gmail.com';
            }
        }
    }
    /* whenever limit is reached contacts
public static void limitError(list<contact> con){
set<id> ids = new set<id>();
for(contact co:con)
{
if(co.accountid!=null)
{
ids.add(co.accountid);
}
}
list<contact> conlist =[select id,name,accountid from contact where accountid in:ids];
decimal totalcount = conlist.size();
for(contact co:con){
if(1<totalcount)
{
co.adderror('can not create contact record');
}
}

}*/
    // can't insert/update/delete that user account object record
    public static void useracc(list<account> acc)
    {
        user u =[select id,name from user where username='fathima786@gmail.com'];
        if(u.id==userinfo.getUserid())
        {
            for(account a :acc)
            {
                a.adderror('can not delete/insert/update record');
            }
        }
    }    
    //Already existing records display error msg
    public static void errordis(list<contact> con){
        list<contact> oldConRecords =[select id,name,email from contact ];
        Map<id,string> conid= new map<id,string>();
        for(contact oldCon:oldConRecords)
        {
            if(oldcon.id!=null)
            {
                conid.put(oldcon.id,oldcon.Email);
            }
        }
        for(contact co: con)
        {
            if(co.email == conid.get(co.email))
            {
                co.Email.adderror('duplicate record');
            }
        }
    }   
    
    //Whenever an opportunity field closed='won' automatically updated account field rating ='hot'
    public static void fieldUpdate(list<opportunity> oppRecord)  
    {
        set<id> ids = new set<id>();
        for(opportunity op: opprecord)
        {
            if(op.AccountId!=null)
            {
                ids.add(op.AccountId);
            }
        }
        list<opportunity> opplist =[select id,accountid,StageName from opportunity where accountid in :ids];
        list<account>acclist = new list<account>();
        for(opportunity opp :opplist)
        {
            if(opp.StageName=='Closed Won'){
                account a = new account();
                a.id = opp.accountid;
                a.rating ='hot';
                acclist.add(a);
            }
            
        }
        update acclist;
    }
    // whenever the account name is naveen automatically updated the all contact lastname 
    public static void autoUpdate(list<account> accrecord) 
    {
        set<id> ids = new set<id>();
        for(account acc :accrecord)
        {
            if(acc.id!=null)
            {
                ids.add(acc.id);
            }
        }
        list<account> acclist =[select id, name from account where id in:ids];
        list<contact> con1 = new list<contact>();
        for(account acc:acclist)
        {
            contact con = new contact();
            con.accountid = acc.id;
            con.lastname = acc.name;
            con1.add(con);
        }
        update con1;
    }
    //when ever opportunity created record amount field is calcualted by account total field   
  /*  public static void recordOppAmount(list <opportunity> opplist)   
    {
        set<id> ids = new set<id>();
        for(opportunity opp:opplist)
        {
            if(opp.accountid!=null){
                ids.add(opp.accountid);
            }
            
        }
        list<aggregateresult> acclist = [select accountid,name,sum(Amount)amt from opportunity where accountid in :ids group by accountid,name];
        list<account> acc = new list<account>();
        Map<id,decimal> maplist = new map<id,decimal>();
        for(aggregateresult app:acclist)
            
        {
            id p1 = (id)app.get('accountid');
            decimal p2 =(decimal)app.get('amt');
            maplist.put(p1,p2);
            
        }
        for(id  p1:maplist.keyset())
        {
            account a = new account();
            a.id=p1;
            a.No_of_opportunity__c=maplist.get('accountid') ;
            acc.add(a);
        }
        update acc;
    }
    //Method - 2
    public static void  oppamt(list<opportunity> oppRecord)   
    {
        set<id> ids = new set<id>();
        Map<id,opportunity> mapOpp = new Map<id,opportunity>();
        
        for(opportunity opp:oppRecord)
        {
            ids.add(opp.accountid);
            mapopp.put(opp.accountid,opp);
        }
        list<account> acclist =[select id,name,No_of_opportunity__c from account where id in : ids];
        for(account a : acclist)
        {
            Opportunity opp = mapOpp.get(a.Id);
            a.No_of_opportunity__c=opp.amount;
            acclist.add(a);
        }
        update acclist;
    }
    */
    //email field on account when we are update then it automatically update the contact records also
    public static void emailupdate(list<account> accrecord){
        set<id> ids = new set<id>();
        for(account acc:accrecord)
        {
            if(acc.id!=null){
                ids.add(acc.id);
            }
            
        }
        List<contact> conlist = [select id,name,email from contact where accountid in :ids ];
        for(contact con: conlist)
        {
            // contact a = new contact();
            con.Email =con.account.Testing__c;
        }
        update conlist;
    }
    
    // account phone is update automatically contact update
    public static void updatePhone(list<account> accList)
    {
        set<id>ids = new set<id>();
        for(account a:accList)
        {
            ids.add(a.id);
        }//Phone
        list<contact> conList =[Select id,name,accountid,Phone,account.phone from contact where accountid IN: ids];
        for(contact con: conList)
        {
            con.Phone=con.account.phone;
            
        }
        update conList;
    }
    public static void pasangerCount(list<Passenger__c>paList)  
    {
        set<id> ids = new set<id>();
        for(Passenger__c pa :paList)
        {
            if(pa.Train__c	!=null)
            {
                ids.add(pa.Train__c);
            }
        }
        List<Train__c> traList= [select id,name,TotalPassengers__c from Train__c where id in: ids ];
        decimal a=0;
        Map<id,decimal> mapList = new map<id,decimal>();
      for(Passenger__c pa :paList)
        {
            a++;
            mapList.put(pa.train__c,a);
        }
        for(train__C tr: traList)
        {
         train__c t = new train__c();
            t.TotalPassengers__c=mapList.get(tr.id);
      }
        update traList;
    }
    
    
    // We have account record, whenver user is create the 4th contact for this account need to show the error
    public static void recExcute(list<contact> conlist)
    {
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            ids.add(con.AccountId);
        }
        list<contact> conrecordlist = [select id,accountid from contact where accountid in : ids];
        Map<id,contact> maplist = new Map<id,contact>();
        for(contact con:conrecordlist)
        {
            maplist.put(con.AccountId,con);
        }
        for(contact con:conlist)
        {
            if(con.AccountId!=null && maplist.containskey(con.AccountId) && conrecordlist.size()>=3)
            {
                system.debug('3---->');
                con.adderror('can not insert more than 3 records');
            }
        }
    }
    
    // A company wants to prevent the deletion of Account records that have related Opportunities. How would you implement this using a trigger?
    //whenever case is clsoed, send email
    public static void accdele(list<account> acclist)
    {
        set<id> ids = new set<id>();
        for(account acc:acclist)
        {
            if(acc.id!=null){
                ids.add(acc.id);
            }
            
        }
        list<opportunity> opplist=[select id,accountid from opportunity where accountid in: ids];
        map<id,opportunity> maplist = new map<id,opportunity>();
        for(opportunity op: opplist)
        {
            maplist.put(op.AccountId,op);
        }
        for(account a: acclist)
        {
            if(maplist.containskey(a.id))
            {
                a.adderror('you can not the account because it having asssociate records');
                
            }
        }
    }
    // when a case is created on any account , put the latest case number on Account in the "Latest case number field"
    public static void automaticCasenumUpdate(list<case> caselist){
        list<account> acclist = new list<account>();
        for(case ca:caselist)
        {
            Account a = new account();
            a.id = ca.accountid;
            a.Latest_case_number__c=ca.CaseNumber;
            acclist.add(a);
        }
        update acclist;
    }  
    /* In the Salesforce Contact object, there is a custom checkbox field named "Main Contact." 
* When this field is checked for one contact associated with a specific account, 
* it should be unchecked for all other contacts linked to the same account. 
* Throw an error when a contact is already a main contact for a specific account
and when you are trying to make more than one contact as main contact  */
    public static void contactupdate(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            ids.add(con.accountid);
        }
         map<id,Boolean> maplist = new map<id,Boolean>();
        list<contact> conlist1 = [select id,name ,accountid,Main_Contact__c from contact where accountid in: ids and Main_Contact__c=true];
        for(contact co: conlist1)
        {
            maplist.put(co.AccountId,co.Main_Contact__c);
        }
        for(contact con:conlist){
            
            if(con.id!=null &&maplist.containskey(con.AccountId)  && con.Main_Contact__c){
               con.adderror('you have already main record') ;
            }
        }
    }
    //Method 2: 
    public static void contactupdate1(list<contact> conlist){
        set<id> ids = new set<id>();
        for(contact con:conlist)
        {
            ids.add(con.accountid);
        }
        
        list<contact> conlist1 = [select id,name ,accountid,Main_Contact__c from contact where accountid in: ids and Main_Contact__c=true];
        for(contact con:conlist)
        {
            if(con.id!=null && conlist.size()>0)
            {
                 con.adderror('you have already main record') ;
            }
        }
    }
    
    //  If location of Opportunity Owner changes , then Change all that owner Opportunities ShippingLocation__c to that location.
   /*  public static void oppupdate(list<Opportunity> opplist){
         Map<id,string> maplist = new map<id,string>();
         for(Opportunity opp:opplist)
         {
        maplist.put(opp.id,opp.) 
         }
     }*/
    
  /*Write a Trigger on the Opportunity object in to control the editability of the 'Close Date' field? The 'Close Date' field should be non-editable under the following conditions:
If the 'Opportunity_Type__c' custom picklist field is set to 'High Value' and the 'StageName' is not 'Closed Won.'
For Opportunities with a record type of 'Special Opportunity' when the 'Opportunity_Type__c' is set to 'Special Value.'*/  
    
    public static void opprpiclist(list<opportunity> opplist){
        set<id> ids = new set<id>();
        for(opportunity opp:opplist)
        {  
            if(opp.Opportunity_Type__c=='High Value' && opp.StageName=='closed won')
            {
                opp.CloseDate.adderror('close date should not be editable');
            }

        }
    }
  // Create a Custom field on Account Object named maxOpp__c (Text) to store Opportunity Name.
    public static void oppornamesave(list<opportunity> opplist){
     set<id> ids = new set<id>();
        for(opportunity opp:opplist) 
        {
            ids.add(opp.accountid);
        }
        list<opportunity> opplist1 = [select id,accountid,account.maxOpp__c,name from opportunity where accountid in : ids];
        list<account> acclist = new list<account>();
        for(opportunity opp1:opplist1)
        {
            account a = new account();
            a.id =opp1.accountid;
            a.maxOpp__c = opp1.name;
            acclist.add(a);
        }
        update acclist;
    }
    
/* You need to create 2 Custom Objects . Object – 1 : Tech_Firm__c Fields : Max_Salary__c (Currency) , Min_Salary__c (Currency)     
Object – 2 : Employee__c Fields : Salary__c (Currency) , Tech_Firm__c (Lookup)
      public static void oppornamesave(list<opportunity> opplist){
     set<id> ids = new set<id>();*/
    
    
    
}