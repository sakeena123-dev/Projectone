public class triggerjuly12 {
    /* Write a trigger on contact to prevent duplicate records based on Contact Email and Contact Phone.*/ // before update and insert
    public static void duplicatconerror1(list<contact> conlist)
    {
        set<string> existingphone = new  set<string>();
        set<string> existingemail = new  set<string>();
        Set<String> existingPhoneEmailCombo = new Set<String>();
        list<contact> conrecords = [select id,phone,email from contact where  email !=null or phone !=null ]; 
        for(contact conrec:conrecords)
        {
            if(conrec.phone!=null ){
                existingphone.add(conrec.Phone);
            }
            if(conrec.email !=null)
            {
                existingemail.add(conrec.email);
            }
            if(conrec.phone!=null && conrec.email !=null )
            {
                existingPhoneEmailCombo.add(conrec.Phone + '| '+conrec.email);
                
            }
            
        }
        set<string> inputphone = new set<string>();
        set<string> inputemail = new set<string>();
        set<string> inputPhoneEmailCombo = new set<string>();
        
        for(contact con :conlist)
        {
            if(con.phone!=null && (existingphone.contains(con.phone) || inputphone.contains(con.Phone)) ){
                con.Phone.addError('Duplicate phone value found');
            }
            else if(con.email!=null && (existingemail.contains(con.email) ||inputemail.contains(con.email)))
            {
                con.Email.addError('Duplicate email value found');
            }
             else if((con.phone!=null && con.email!=null) && (existingPhoneEmailCombo.contains(con.email+'|'+con.phone) ||inputPhoneEmailCombo.contains(con.email+'|'+con.phone)))
            {
                 con.Phone.addError('Duplicate phone + email combination found');
                 con.Email.addError('Duplicate phone + email combination found');
            }
        }
    }
    
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
    
    
    
    
    
    
    
    
    
    
    
    
    //Write a trigger on contact to prevent duplicate records based on Contact lastname, Contact Email & Contact Phone:
    
    public static void duplicatContactRecord(list<contact>conRecords,map<id,contact>oldConRecords)
    {
        list<contact> conlist = new list<contact>();
        //  map<string,contact> maplist = new map<string,contact>();
        set<string> existemail = new  set<string>();
        set<string> existphone = new  set<string>();
        set<string> existlastname = new  set<string>();
        for(contact conRec:ConRecords)
        {
            existemail.add(conRec.Email);
            existphone.add(conRec.phone);
            existlastname.add(conRec.lastname);
            
        }
        // map<string,contact> conlistRecords = new map<string,contact>([Select id,lastname,email,phone from contact  ]);
        list<contact> conlistRecords =[Select id,lastname,email,phone from contact where lastname =: existlastname and  phone =: existphone and email =: existemail ];
        for(contact con :conRecords)
        {
            
            if(conlistRecords.size()>=1)                                  //  if(existemail.contains(con.email) && existemail.contains(con.phone) && existemail.contains(con.lastname) )
            {
                con.adderror('duplicate record found');
            }
            else if(existlastname!=null && oldConRecords.get(con.id).LastName==con.LastName )
            {
                con.lastname.adderror('duplicate lastname found');
            }
            else  if(existemail!=null && oldConRecords.get(con.id).email==con.email )
            {
                con.email.adderror('duplicate email found');
            }
            else if(existphone!=null && oldConRecords.get(con.id).phone==con.phone )
            {
                con.phone.adderror('duplicate phone found');
            }
        }
        
    }
    
    
    
    
    
}