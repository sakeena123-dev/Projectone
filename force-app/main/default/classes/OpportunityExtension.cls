public with sharing class OpportunityExtension {
    private ApexPages.StandardController stdController;
    
    public OpportunityExtension(ApexPages.StandardController stdController) {
        this.stdController = stdController;
    }
    
    public PageReference checkLeadSource() {
        
        List<Opportunity> oppList = [SELECT Id, LeadSource FROM Opportunity WHERE Id = :stdController.getId() LIMIT 1];
        
        if (oppList != null && !oppList.isEmpty()) {
            Opportunity opp = oppList[0];
            
            if (String.isBlank(opp.LeadSource)) {
                ApexPages.Message errorMessage = new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Opportunity cannot be deleted because Lead Source is empty.'
                );
                ApexPages.addMessage(errorMessage);
                return null; 
            }
        } 
        return stdController.delete();
    }
  /*  private ApexPages.StandardController stdController;
    
    public OpportunityExtension(ApexPages.StandardController stdController) {
        this.stdController = stdController;
    }
    
    public PageReference checkLeadSource() {
        try {
            Opportunity opp = [SELECT LeadSource FROM Opportunity WHERE Id = :stdController.getId() LIMIT 1];

            if (opp != null && String.isNotBlank(opp.LeadSource)) {
                // Lead Source is not empty, proceed with deletion
                return stdController.delete();
            } else {
                // Lead Source is empty, display error message
                ApexPages.addMessage(new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    'Opportunity cannot be deleted because Lead Source is empty.'
                ));
                return null;
            }
        } catch (Exception e) {
            // Log the exception for debugging
            System.debug('Exception: ' + e.getMessage());

            // Handle the case where an unexpected exception occurs
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR,
                'An unexpected error occurred. Please contact your administrator.'
            ));
            return null;
        }
    }*/
}