trigger OpportunityTrigger on Opportunity (before insert, 
                                            before update, 
                                            before delete, 
                                            after insert, 
                                            after update, 
                                            after delete,
                                            after undelete) {

    switch on Trigger.operationType{
        when BEFORE_INSERT{

        }
        when BEFORE_UPDATE{
            // Question #5
            OpportunityTriggerHandler.validateOpportunityAmount(Trigger.new);
        }
        when BEFORE_DELETE{

        }
        when AFTER_INSERT{

        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{

        }
        WHEN AFTER_UNDELETE{

        }
    }
}