public with sharing class MI_iframeController {

    @AuraEnabled
    public static User getUserInfo() {
        System.debug('olehdebug >>> userinf: ' + UserInfo.getUserId());
        try {
            return [SELECT Custom_URL__c FROM User WHERE Id = :UserInfo.getUserId()];
        } catch (Exception e) {
            System.debug('Exception in MI_iframeController > getUserInfo ERROR: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

}