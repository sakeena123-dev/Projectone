public class ApexPratice {
    /* 𝐓𝐚𝐬𝐤 𝟏:- 
"𝐂𝐫𝐞𝐚𝐭𝐞 𝐚 𝐟𝐮𝐧𝐜𝐭𝐢𝐨𝐧 𝐰𝐡𝐢𝐜𝐡 𝐰𝐢𝐥𝐥 𝐭𝐚𝐤𝐞 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐝 𝐚𝐬 𝐚 𝐢𝐧𝐩𝐮𝐭 𝐈𝐟 𝐭𝐡𝐞 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐬 𝐧𝐨𝐭 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐰𝐢𝐭𝐡 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐭𝐡𝐞𝐧 𝐜𝐫𝐞𝐚𝐭𝐞 𝐚 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐭𝐨 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐰𝐢𝐭𝐡 𝟓𝟎% 𝐩𝐫𝐨𝐛𝐚𝐛𝐢𝐥𝐢𝐭𝐲."
(𝐚𝐥𝐬𝐨) 
:-"𝐂𝐫𝐞𝐚𝐭𝐞 𝐚 𝐟𝐮𝐧𝐜𝐭𝐢𝐨𝐧 𝐰𝐡𝐢𝐜𝐡 𝐰𝐢𝐥𝐥 𝐭𝐚𝐤𝐞 𝐥𝐢𝐬𝐭 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐝 𝐚𝐬 𝐚 𝐢𝐧𝐩𝐮𝐭 𝐈𝐟 𝐭𝐡𝐞 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐬 𝐧𝐨𝐭 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐰𝐢𝐭𝐡 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐭𝐡𝐞𝐧 𝐜𝐫𝐞𝐚𝐭𝐞 𝐚 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐭𝐨 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐰𝐢𝐭𝐡 𝟓𝟎% 𝐩𝐫𝐨𝐛𝐚𝐛𝐢𝐥𝐢𝐭𝐲. "*/
    public static void creOpprelatedAccount(id accountid)
    {
        
        list<opportunity> opplist = [select id,name,accountid from opportunity where accountid =: accountid ];
        system.debug('opplist' +opplist);
        if(opplist.size()<1)
        {
            opportunity opp = new opportunity();
            opp.AccountId= accountid;
            opp.name ='opp1';
            opp.StageName='new';
            opp.CloseDate=date.today();
            insert opp;
        }
    }
    /* 𝐂𝐫𝐞𝐚𝐭𝐞 𝐚 𝐦𝐞𝐭𝐡𝐨𝐝 𝐰𝐡𝐢𝐜𝐡 𝐰𝐢𝐥𝐥 𝐜𝐫𝐞𝐚𝐭𝐞 𝐚 𝐭𝐚𝐬𝐤 𝐚𝐧𝐝 𝐫𝐞𝐭𝐮𝐫𝐧 𝐭𝐚𝐬𝐤 𝐫𝐞𝐜𝐨𝐫𝐝 𝐢𝐝.*/
    public static id taskcreation(account acc)
    {
        task t1 = new task();
        t1.WhatId = acc.id;
        t1.subject ='acc task';
        t1.Priority ='high';
        t1.status ='closed'; 
        insert t1;
        system.debug('task record'+ t1.id);
        return t1.id;
      
    }
  /* "𝐂𝐫𝐞𝐚𝐭𝐞 𝐚 𝐦𝐞𝐭𝐡𝐨𝐝 𝐰𝐡𝐢𝐜𝐡 𝐚𝐜𝐜𝐞𝐩𝐭𝐬 𝐚𝐜𝐜𝐨𝐮𝐧𝐭𝐢𝐝 𝐚𝐬 𝐚 𝐩𝐚𝐫𝐚𝐦𝐞𝐭𝐞𝐫.𝐃𝐞𝐥𝐞𝐭𝐞 𝐚𝐥𝐥 𝐭𝐡𝐞 𝐜𝐨𝐧𝐭𝐚𝐜𝐭𝐬 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐭𝐨 𝐭𝐡𝐞 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐝. "*/
public static void deletecontacts(id accid)
{
    list<contact> conlist =[select id,name,accountid from contact where accountid=:accid];
    if(conlist.size()>0)
    {
        delete conlist;
    }
}
 /* "𝐂𝐫𝐞𝐚𝐭𝐞 𝐚 𝐦𝐞𝐭𝐡𝐨𝐝 𝐰𝐡𝐢𝐜𝐡 𝐚𝐜𝐜𝐞𝐩𝐭𝐬 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐢𝐝 𝐚𝐬 𝐚 𝐩𝐚𝐫𝐚𝐦𝐞𝐭𝐞𝐫 𝐚𝐧𝐝 𝐫𝐞𝐭𝐮𝐫𝐧𝐬 𝐬𝐮𝐦 𝐨𝐟 𝐚𝐥𝐥 𝐭𝐡𝐞 𝐜𝐨𝐧𝐭𝐚𝐜𝐭𝐬 𝐚𝐧𝐝 𝐨𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐚𝐬𝐬𝐨𝐜𝐢𝐚𝐭𝐞𝐝 𝐭𝐨 𝐭𝐡𝐞 𝐠𝐢𝐯𝐞𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭𝐢𝐝."*/
   public static integer sumConOpp(id accid)
   {
       list<contact> conlist =[select id,name,accountid from contact where accountid=:accid];
       list<opportunity> opplist =[select id,name,accountid from opportunity where accountid=:accid];
       integer conSize = conlist.size();
       integer oppSize =opplist.size();
       system.debug('total contact'+consize +' '+'total opportunity'+oppSize);
       return conSize+ oppSize;
   }
    
}