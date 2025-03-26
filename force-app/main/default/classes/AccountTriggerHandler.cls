public with sharing class AccountTriggerHandler {
    
    public static void modifyAccountTypeField(List<Account> accountList){
        for (Account acc : accountList) {
            if (String.isBlank(acc.Type)) {
                acc.Type = 'Prospect';
            }
        }
    }

    public static void copyShippingAddressToBillingAddress(List<Account> accountList){
        Boolean shippingAddressBlank = false;
        
        for (Account acc : accountList) {
            Boolean isBillingAddressBlank = 
                                            String.isBlank(acc.ShippingStreet) &&
                                            String.isBlank(acc.ShippingCity) &&
                                            String.isBlank(acc.ShippingState) &&
                                            String.isBlank(acc.ShippingPostalCode) &&
                                            String.isBlank(acc.ShippingCountry);

            if (!isBillingAddressBlank) {
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
    }

    public static void setRatingToHotIfPhoneWebsiteAndFaxHaveValue(List<Account> accountList){
        for (Account acc : accountList) {
            Boolean phoneWebsiteAndFaxHaveValues = 
                    String.isBlank(acc.Phone) &&
                    String.isBlank(acc.Website) &&
                    String.isBlank(acc.Fax);

            if (!phoneWebsiteAndFaxHaveValues) {
                acc.Rating = 'Hot';
            }
        }
    }

    public static void createContactAndRelateToInsertedAccountWithValues(List<Account> accountList){
        List<Contact> contactList = new List<Contact>();
        for (Account acc : accountList) {
            Contact con = new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com'
            );

            con.AccountId = acc.Id;
            contactList.add(con);
        }

        Database.insert(contactList);
    }
}