public class task786 {
 // Get a list of Account (Name, Phone, Type, Annual Revenue, Industry). Filter by Industry field. Industry should be Energy
//Print Account Name, Annual Revenue   
    
public static void getaccount()
{
    list<account> acclist = [select id,name,annualrevenue,phone,industry from account where industry ='energy'];
    for(account acc:acclist)
    {
        system.debug('account name'+acc.name);
        system.debug('account annual revenue'+acc.AnnualRevenue);
    }
}    
/*Get a list of Account (Name, Phone, Type, Annual Revenue, Industry)
Filter by Industry field. Industry should be Energy & Education
Filter by by Employee field. Employee should be greater than or equal to 5000
Print Account Name, Employee*/    
 public static void getaccount1()
{
    list<account> acclist = [select id,name,annualrevenue,phone,industry from account where annualrevenue> =5000 and industry =' Energy & Education'];
    for(account acc:acclist)  
    {
          system.debug('account name'+acc.name);
        system.debug('account annual revenue'+acc.AnnualRevenue);
    }
    
    
}
    
//Get a list of unique Industry field values from Account and print them
//Hint: Use Set    
    public static void getaccount3()
{
    set<string> industryset = new set <string>();
    list<account> acclist =[select id,industry from account where industry!=null];
    for(account acc: acclist)
    {
        industryset.add(acc.Industry);
       
    }
     system.debug('industry values' + industryset);
}
    
//Get/Print a Map of Unique Industry names from Account object like this: <Industry, No of Accounts in that industry>
//E.g.: <Energy, 3>, Consulting, 2>, <Biotechnology, 1>, etc    
   public static void getaccount4()
{
    map<string,integer> industryset = new map<string,integer>();
    list<account> acclist =[select id,industry from account where industry!=null];  
   
    for(account acc:acclist)
    {
        string  industry =acc.Industry;
         if (industryset.containsKey(industry)) {
        industryset.put(industry,industryset.get(industry)+1);
         }
    }
    system.debug('industry values' + industryset);
}
 // Create a new Account record using Inline declaration and Initilization. Use any field values
     public static void getaccount5()
{
    account a = new account(name='text');
    insert a;
}
  // Create a method which will accept X no as parameter and create those many Account records. Use any field values
//Created account records names should be like this: Account 1, Account 2, Account 3…....Account x 

    
/* "1.write an apex method which will take one input as map with key as studentname and value as total marks obtained, other input as max marks
a.create a map with key as student name and value as average for that student
b.create a map with key as student name and value as pass/fail. if student gets average of more than 35 % pass else fail
c.create a map with key as pass/fail and value as total number of students who are passed /failed
d.create a map with key as a pass/fail and value as list of students"*/
 public static void studentmarksmethod(map<string,integer> studentmarks, integer maxmarks)   
 {
     map<string,integer> studentavgmark = new   map<string,integer>();
     map<string,string> resultmap = new   map<string,string>();
     map<string,integer> Studentcount = new   map<string,integer>{'pass'=>0,'fail'=>0};
     map<string,list<string>> resultStudentList = new map<string,list<string>>();
      resultStudentList.put('Pass', new List<String>());
        resultStudentList.put('Fail', new List<String>());
     for(string studentName: studentmarks.keyset())
     {
         integer obtainmarks = studentmarks.get(studentName);
         integer avg = (obtainmarks/maxmarks)*100;
         studentavgmark.put(studentName,avg); //1
         if(avg>=35)
         {
             resultmap.put(studentName,'pass');
             Studentcount.put(studentName,Studentcount.get('pass')+1);
            resultStudentList.get('Pass').add(studentName);   
         }
     else 
     {
         resultmap.put(studentName,'fail');
             Studentcount.put(studentName,Studentcount.get('fail')+1);
            resultStudentList.get('fail').add(studentName);
     }
     
     }
      // Debug output for verification
        System.debug('Student Average Map: ' + studentavgmark);
        System.debug('Student Result Map: ' + resultmap);
        System.debug('Result Count Map: ' + Studentcount);
        System.debug('Result Student List Map: ' + resultStudentList);
 }
    
    // create a apex class and display account id, account name and related contacts which are having primary address
    public static void creataccountmethod()
    {
         List<Account> accountList =[select id,name,(select id,MailingStreet from contacts)from account];
         List<Contact> primaryContacts = new List<Contact>();
        for(account acc:accountList)
        {
            primaryContacts=acc.contacts;
            string accountname =acc.name;
            string accountid = acc.id;
            System.debug('Account Id: ' + accountname);
            System.debug('Account Name: ' + accountid);
             System.debug('primarycontacts ' + primaryContacts);
            
        }
    }
}