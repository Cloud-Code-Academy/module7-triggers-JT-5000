public with sharing class OpportunityTriggerHandler {
    
    public static void validateOpportunityAmount(List<Opportunity> oppList){
        List<Opportunity> validatedOpps = new List<Opportunity>();

        for (Opportunity opp : oppList) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
}