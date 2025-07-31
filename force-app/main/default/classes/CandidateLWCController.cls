/* this apexcontroller used to display the lwc screen data table and create the new record*/

public without sharing class  CandidateLWCController {
// below method is used to show the list of candidate data
  @AuraEnabled(cacheable=true)
Public static list<Candidate_Details__c> condidateList()
{
    return [select Name,Candidate_ID__c,Email__c,Phone__c,Work_Experience_Years__c,Application_Status__c,Qualifications__c,Address__c from Candidate_Details__c];
}


@AuraEnabled
public static Candidate_Details__c candetails(Candidate_Details__c savecandetails)//string name, string email,decimal conid,string ph ,string address,string appliSt,decimal exp,string quali
{
    insert savecandetails;

   return savecandetails;
    /*Candidate_Details__c can = new Candidate_Details__c();
    can.Name=name;
    can.Candidate_ID__c=conid;
      can.Email__c=email;
      can.Phone__c=ph;
      can.Work_Experience_Years__c=exp;
      can.Application_Status__c=appliSt;
    can.Qualifications__c=quali;
      can.Address__c=address;
      insert can;
      return can;*/


}
@AuraEnabled
 public static Candidate_Details__c getviewrecords(id inputid)
 {
    string query='select Name,Candidate_ID__c,Email__c,Phone__c,Work_Experience_Years__c,Application_Status__c,Qualifications__c,Address__c from Candidate_Details__c where id=:inputid';
    return Database.query(query);
 }
   
/**
 * @description : This method is used for  both hr and employee edit the records
 * @param editrequest
 * @return Request__c
  */ 
 
@AuraEnabled
public static Candidate_Details__c editreq(Candidate_Details__c editrequest){
   update editrequest;

   
   return editrequest;
}

}