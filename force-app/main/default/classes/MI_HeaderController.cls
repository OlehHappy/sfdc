/**
 * Created by leon on 29.10.18.
 */

public with sharing class MI_HeaderController {
    @AuraEnabled
    public static Account getUserAccount() {
        try {
            Id userContactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()].ContactId;
            Id accountId = [SELECT AccountId FROM Contact WHERE Id = :userContactId].AccountId;
            Account userAccount = [SELECT Name, Website, Logo_URL__c FROM Account WHERE Id = :accountId];

            return userAccount;
        } catch (Exception e) {
            System.debug('Exception in MI_HeaderController > onInit ERROR: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }

    }

}