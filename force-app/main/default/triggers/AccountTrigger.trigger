trigger AccountTrigger on Account (before insert, before update, before delete,     
                                   after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType{
        when BEFORE_INSERT{
            // Question #1 - Storing Apex logic in the AccountTriggerHandler.
            AccountTriggerHandler.modifyAccountTypeField(Trigger.new);

            // Question #2
            AccountTriggerHandler.copyShippingAddressToBillingAddress(Trigger.new);

            // Question #3
            AccountTriggerHandler.setRatingToHotIfPhoneWebsiteAndFaxHaveValue(Trigger.new);
        }
        when BEFORE_UPDATE{

        }
        when BEFORE_DELETE{

        }
        when AFTER_INSERT{
            // Question #4
            AccountTriggerHandler.createContactAndRelateToInsertedAccountWithValues(Trigger.new);
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{

        }
        WHEN AFTER_UNDELETE{

        }
    }

}