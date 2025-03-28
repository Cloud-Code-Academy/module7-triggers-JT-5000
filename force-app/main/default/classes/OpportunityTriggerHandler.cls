public with sharing class OpportunityTriggerHandler {
    
    public static void validateOpportunityAmount(List<Opportunity> oppList){
        List<Opportunity> validatedOpps = new List<Opportunity>();

        for (Opportunity opp : oppList) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void preventOppDeleteForBankingIndustry(List<Opportunity> oppList){
        if (oppList.isEmpty()) {
            return;
        }

        Map<Id,Opportunity> idToOpportunityMap = new Map<Id,Opportunity>(
            [ SELECT Id, Name, CloseDate, StageName, Amount, Account.Id, Account.Industry
                FROM Opportunity WHERE Id IN :oppList ]
        );
        
        for (Opportunity opp1 : oppList) {
            Opportunity mappedOpp = idToOpportunityMap.get(opp1.Id);
            System.debug(mappedOpp.Account.Industry);
            
            // ask Chase about how the records in trigger.old are the only records heading for  a dml in a BEFORE context.
            if (mappedOpp.Account.Industry == 'Banking' && mappedOpp.StageName == 'Closed Won') {
                opp1.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    public static void setPrimaryContactOnOpportunity(List<Opportunity> oppList){
        Set<Id> setOfAccountIds = new Set<Id>();
        
        for (Opportunity opp : oppList) {
            setOfAccountIds.add(opp.AccountId);
        }

        List<Contact> contactList = [ SELECT Id, FirstName, LastName, AccountId, Title 
                                        FROM Contact WHERE AccountId IN :setOfAccountIds AND Title = 'CEO' ];


        for (Opportunity opp2 : oppList) {
            for (Contact cont : contactList) {
                if (opp2.AccountId == cont.AccountId) {
                    opp2.Primary_Contact__c = cont.Id;
                }
            }
        }
    }
}