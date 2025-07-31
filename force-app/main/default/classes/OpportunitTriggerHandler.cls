public class OpportunitTriggerHandler {
// below  class is write for the opportunity team memeber
  public static void opportunityTeam(list<opportunity_team_memeber__c> oppTemList)
{
 set<id> ids = new set<id>();
    string oppmemNAme;
    for(opportunity_team_memeber__c opp:oppTemList)
    {
        ids.add(opp.Opportunity__c);
        oppmemNAme = opp.name;
    }
    list<opportunity> oppMemList = [select id,name from opportunity where id in :ids];
    //list<opportunity_team_memeber__c> oppMemList = [select id,name,Opportunity__c from opportunity_team_memeber__c where Opportunity__r.id in :ids];
    list<opportunity> opplist = new   list<opportunity>();
    for(opportunity opp :oppMemList)
    {
        
        opp.name = opp.name+' ' +oppmemNAme;
       // opp.name = opp.name+' ' +oppmemNAme;
        opplist.add(opp);
    }
    update opplist;
}
  /*   public static void updateOpportunityTeam(List<opportunity_team_memeber__c> oppTeamList) {
    Set<Id> oppIds = new Set<Id>();
    Map<Id, String> oppIdToTeamMemberName = new Map<Id, String>();

    // Collect Opportunity Ids and corresponding Team Member names
    for (opportunity_team_memeber__c oppTeam : oppTeamList) {
        oppIds.add(oppTeam.Opportunity__c);
        oppIdToTeamMemberName.put(oppTeam.Opportunity__c, oppTeam.Name);
    }

    // Query Opportunities based on collected Ids
    List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity WHERE Id IN :oppIds];

    List<Opportunity> oppToUpdateList = new List<Opportunity>();

    // Update Opportunity Names based on Team Member names
    for (Opportunity opp : oppList) {
        String teamMemberName = oppIdToTeamMemberName.get(opp.Id);

        // Check if Opportunity Name is null or empty
        if (String.isBlank(opp.Name)) {
            opp.Name = teamMemberName;
        } else {
            opp.Name = opp.Name + ' ' + teamMemberName;
        }

        oppToUpdateList.add(opp);
    }

    // Update Opportunities
    update oppToUpdateList;
}*/

}