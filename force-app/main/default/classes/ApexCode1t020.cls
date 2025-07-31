public class ApexCode1t020 {
   // Write a program that prints ‘Hello World’ to the screen
Public static void msg(string a)
{
    system.debug(a);
}
    //Write a program that asks the user for their name and greets them with their name
 Public static void greetingmsg(string a)
 {
     system.debug(a+' '+'Welcome to salesforce');
 }
    //Write a program to add all numbers in both the lists together A  = 1,5,8,11,15   B = 20,15,17,18,70  
    Public static void addnum()
 {
     list<integer> a = new list<integer>{1,5,8,11,15};
      list<integer> b = new list<integer>{20,15,17,18,70};
          list<integer> numbers = new  list<integer>();
       for(integer i=0;i< A.size(); i++)
       {
           numbers.add(A[i] + B[i]);
       }
     system.debug(numbers);
 }
    //Write a Program to calculate sum of 5 subjects and its percentage
   Public static void calper(integer a,integer b,integer c)
 {
    integer total =a+b+c;
     decimal percentage =(total*100/300); 
     system.debug('Total marks:'+' '+total);
     system.debug('percentage marks:'+' '+percentage);
 }
    //Write a Program to find wheather the string is Palindrome or not 
    public static void palinCheck(string a)
    {
        if( a == a.reverse())
        {
            system.debug(a+' '+'is a palindrome');
        }
        else
            {
            system.debug(a+' '+'is not a palindrome');
        }
    }
    // Write a program to find greatest of 3 numbers
public static void greatestnum(integer n1,integer n2,integer n3)
{
    if(n1>n2 && n1>n3 )
    {
         system.debug('greatest num is'+' '+  +n1);
    }
        if(n2>n1 && n2>n3 )
        {
             system.debug('greatest num is'+' '+  +n2);
        }
    else
    {
         system.debug('greatest num is'+' '+  +n3);
    }
}
 //Write a program to check the given number is odd or even   
public static void numCheck(integer n)
{
    if(math.mod(n,2)==0)
    {
      system.debug(n+' '+'The number is even');
     }
     else
     {
      system.debug(n+' '+'The number is odd');
     }
    
}
// Write a program to find the length of a string
public static void StringCheck(string a)
{
   system.debug('the string length is'+a.length());
}
    //Write a program to find average of two numbers
 Public static void AvgNum(integer a,integer b,integer c)
 {
    integer avg =(a+b+c)/3;
      system.debug('avg marks:'+' '+avg);
}
//Write a program to print the numbers in accending order    
 Public static void acceOrder(list<integer> li)
 {
     li.sort();
     system.debug('accending order '+ li);
 }
// Write a program to add 2 strings
Public static void addstring(string a,string b)
 {
system.debug(string.valueof(a)+string.valueof(b));
 }
   // Write a program to swap 2 numbers
   public static void swap(integer a,integer b)
   {
       integer c=a;
       a=b;
       b=c;
       system.debug('number '+a +' '+b);

   }
    // Write a program to display Fibonacci series 
   public static void fibonacci(integer a)
   {
      Integer first = 0;
        Integer second = 1; 
       for(integer i=0;i<a;I++)
       {
           Integer next = first + second;
            first = second;
            second = next;
            System.debug(next);
       }
   }
    /*"WRITE A METHOD... Take input as a list of strings .. and return the length of each string
example...input
HELLO - 5
GOOD- 4
HAPPY - 5
GOOGLE - 6"*/
    public static void lengthcheck(list<string> str)
   { 
       list<Integer> b = new list<Integer>();
       for(string s: str)
       {
           b.add(s.length());
       }
       system.debug(b);
   }
    // Reverse a string and print. Input can be a list of strings and return can be list of strings in reverse order
    public static void reverseString(list<string> stlist)
    {
        list<string> strlist = new list<string>();
        for(string st :stlist)
        {
            strlist.add(st.reverse());
        }
        
        system.debug(strlist);
    }
    // Write a program to find the number is   number or not
    public static void numCheck1(string a)
    {
        if(a.isnumeric())
        {
        system.debug(a+' '+'is a numeric');   
        }
        else
         {
        system.debug(a+' '+'is not a numeric');   
        }    
    }
    // Write a program  to Compare two strings and display which string has more letters
    public static void stringcompare(string a,string b)
    {
        if(a.length()> b.length() )
        {
           system.debug(a+' '+'length is a big');     
        }
       else if(a.length()< b.length() )
        {
           system.debug(b+' '+'length is a big');     
        }
    }
    // Write a program to print logical operations.
    public static void lgclOper(integer a,integer b,integer c)
    {
       if(a>=c && b>=c )
       {
          system.debug('this is AND operator');  
       }
         if(a>=c || b>=c )
       {
          system.debug('this is or operator');  
       }
         if(a!=c && b!=c )
       {
          system.debug('this is Not operator');  
       }
    }
  //Write a program to print a message for 5 Times      
   public static void pringstring(string name)     
   {
       for(integer i=0;i<5;I++)
       {
           system.debug(name);
       }
   }   
// Write a program to perform arithmetic operations using switch statement.
public static void artSwi(Decimal  a,Decimal  b,string operator)  
{
    
    switch on operator
    {
        when '+'
        {
            system.debug(a+b);
        }
         when '-'
        {
            system.debug(a-b);
        }
        when '/'
        {
            system.debug(a/b);
        }
        when '*'
        {
            system.debug(a*b);
        }
    }
}
// Write a program to print the given number in reverse order using do while loop.
public static void reverOrd(integer a)
{
    integer reversenum=0;
    do
    { 
        Integer digit = Math.mod(a, 10);  // Get the last digit
        reversenum = (reversenum * 10) + digit; // Add the digit to the reversed number
        a = a / 10; // Remove the last digit
    }
    while(a>0);
    {
         System.debug('Reversed Number: ' + reversenum);
    }
} 
    //Write a Program to find the factorial of a number, where the number is enterd by user.
 public static void facnum(integer a)
 {
     integer t=1;
     for(integer i=1;i<=a;i++)
     {
         t*=i;
     }
     system.debug( t);
 }
 //Write a program to convert upper case string to lower case string.   
 public static void uplowString(string a)
 {
     system.debug(a.touppercase());
     system.debug(a.tolowercase());
 }
  //  Write a program to check whether a character is alphabet or not
 public static void alphCheck(string a)
 {
     if(a>='a' && a<'z')
     {
          system.debug(a+'is the alphabet');
     }
     else{
     system.debug(a+'is not the alphabet');
     }
 }
 //Write a program to calculate Area of Equilatral triangle.
    public static void equilatral(integer a)   {
        decimal area =(1.73*a*a)/4;
        system.debug('the area of equilatral triangle' +' ' +area);
    }
  // Write a program to check whether an alphabet is vowel or consonant.
     public static void VCACheck(string a)   { 
         if(a=='a' || a=='e' || a=='i' || a=='o' || a=='u')
         {
             system.debug(a+' '+'is the vowel');
         }
         else
                    {
             system.debug(a+' '+'is the consonant');
         } 
             
     }
    // Write a program to find n_Natural Numbers.
    public static void naturalnum(integer a)
    {
        integer t=1;
        for(integer i=0;i<=a;i++)
        {
            t=t+1;
        }
         system.debug( t);
    }
 // Compare two strings and print if they are equal or not equal   
   public static void strCompare(string a,string b) 
   {
       if(a.equals(b))
       {
           system.debug('both strings are equal');
       }
       else{
            system.debug('both strings are not equal');
       }
   }
 /* "Compare if one string is present in another string -- For ex,   SALESFORCE,  check if FORCE is part of the word
check if SALES is part of SALESFORCE..."*/   
     public static void strComparing(string a,string b) 
   {
       if(a.contains(b))
       {
           system.debug('contains substring');
       }
       else{
            system.debug('not contains substring');
       }
       }
   /* "Store capital and country in a list or two separate lists list 1 - country,  list 2- capital  or in a single list with 
both country and capital separated by a hyphen.    

Write a method that will take country as input and give capital as the return value
Approach 1 

INDIA      
USA
UK
SRILANKA
INDOESIA


DELHI
NYORK
LONDON
COLOMBO
JAKARTA


Approach 2  -- Substring.. 
INDIA-DELHI
USA-NY
UK-LONDON
SRILANKA-COLOMBO
INDONESIA-JAKARTA

Approach 3 -  Using a  MAP"*/
  
    Public static void CClist(string s)
    {
        list<string> countrylist  =new list<string>();
         countrylist.add('INDIA');
         countrylist.add('USA');
         countrylist.add('UK');
         countrylist.add('SRILANKA');
         countrylist.add('INDOESIA');
         list<string> capitallist  =new list<string>();
         capitallist.add('DELHI');
         capitallist.add('NYORK');
         capitallist.add('LONDON');
         capitallist.add('COLOMBO');
         capitallist.add('JAKARTA');
        for(integer i=0; i<countrylist.size();I++)
        {
            if(countrylist.get(i)==s){
                 system.debug('your capital is' + '  ' +capitallist.get(i));
            }
           
        }
    }
   public static void  CClist1(string s)
    {
        list<string> countryCaplist  =new list<string>();
        countryCaplist.add('INDIA-DELHI');
countryCaplist.add('USA-NY');
countryCaplist.add('UK-LONDON');
countryCaplist.add('SRILANKA-COLOMBO');
countryCaplist.add('INDONESIA-JAKARTA');
        for(string CC :countryCaplist){
            if(CC.startswith(s+'-') )
            {
              string[] sp  =cc.split('-');
                system.debug(s+'the capital is'+sp[1]);
            }
        }
    }
 public static void  CClist2(string s)
    {   
        Map<string,string> cpMap = new map<string,string>();
        cpMap.put('INDIA','DELHI');
          cpMap.put('USA','NY');
          cpMap.put('UK','LONDON');
          cpMap.put('SRILANKA','COLOMBO');
          cpMap.put('INDONESIA','JAKARTA');
        if(cpMap.containskey(s))
        {
            system.debug(s+' '+'capital is '+' '+cpmap.get(s));
        }
        else
        {
           system.debug(s+' '+'capital is not found');
        }
    }
    // ".Write a program to sort the date from list of dates."
  public static void  CClist2(date d)
    {   
        
    }
}