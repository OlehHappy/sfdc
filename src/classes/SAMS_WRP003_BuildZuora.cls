global with sharing class SAMS_WRP003_BuildZuora {
    //oleh test

    public NewAccount newAccount;
    public String existingAccountNumber;
    public String orderDate;
    public List<Subscriptions> subscriptions;
    public CustomFields customFields;

    public SAMS_WRP003_BuildZuora(NewAccount newAccount, String orderDate, List<Subscriptions> subscriptions){
        this.newAccount = newAccount;
        this.orderDate = orderDate;
        this.subscriptions = subscriptions;
    }

    public SAMS_WRP003_BuildZuora(String orderDate, String existingAccountNumber, List<Subscriptions> subscriptions){
        this.orderDate = orderDate;
        this.existingAccountNumber = existingAccountNumber;
        this.subscriptions = subscriptions;
    }

    public SAMS_WRP003_BuildZuora(CustomFields customFields){
        this.customFields = customFields;
    }
    
    public class Subscriptions{
        public String subscriptionNumber;
        public CustomFields customFields;
        public List<OrderActions> orderActions;
        public Map<String,String> customfieldMap;

        public Subscriptions(CustomFields customFields, List<OrderActions> orderActions){
            this.customFields = customFields;
            this.orderActions = orderActions;
        }

        public Subscriptions(String subscriptionNumber, List<OrderActions> orderActions){
            this.subscriptionNumber = subscriptionNumber;
            this.orderActions = orderActions;
        }

        public Subscriptions(List<OrderActions> orderActions){
            this.orderActions = orderActions;
        }

        public Subscriptions(String subscriptionNumber, CustomFields customFields, List<OrderActions> orderActions){
            this.subscriptionNumber = subscriptionNumber;
            this.customFields = customFields;
            this.orderActions = orderActions;
        }
        public Subscriptions(String subscriptionNumber, Map<String,String> customfieldMap, List<OrderActions> orderActions){
            this.subscriptionNumber = subscriptionNumber;
            this.customfieldMap = customfieldMap;
            this.orderActions = orderActions;
        }

    }

    public class Subscriptionspcs{
        List<Subscriptions> subscriptions;
        public subscriptionspcs(List<Subscriptions> subscriptions){
            this.subscriptions = subscriptions;
        }
    }

    public class CustomFields{
        public String vin_x;
        public String carDescription;
        public String activationStatus;
        public String pcscontractid;
        public String pcscontractcode;
        public String StatusReason;
        public String pcsContract;
        public String pcsProduct;
        public String pcsPrice;
        public String channel;
        public String pcsOption;
        public Date cancelRequestDate;
        public Map<String,String> customFields;
        
        
        public CustomFields(Map<String,String> customFields){
            this.customFields = customFields;
        }

        public CustomFields(String vin_x, String carDescription, String activationStatus, String pcscontractid) {
            this.vin_x = vin_x;
            this.carDescription = carDescription;
            this.activationStatus = activationStatus;
            this.pcscontractid = pcscontractid;
        }

        public CustomFields(String vin_x, String carDescription, String activationStatus, String pcscontractid, String pcscontractcode, String channel, String pcsOption) {
            this.vin_x = vin_x;
            this.carDescription = carDescription;
            this.activationStatus = activationStatus;
            this.pcscontractid = pcscontractid;
            this.pcscontractcode = pcscontractcode;
            this.channel = channel;
            this.pcsOption = pcsOption;

        }

        public CustomFields(String pcsContract, String pcsProduct){
            this.pcsContract = pcsContract;
            this.pcsProduct = pcsProduct;
        }

        public CustomFields(String StatusReason){
            this.StatusReason = StatusReason;
        }
        
        public void setCancelRequestDate(Date cancelRequestDate) {
            this.cancelRequestDate=cancelRequestDate;
        } 
        
        public void setStatusReason(String StatusReason) {
            this.StatusReason = StatusReason;
        }
        
        public void setActivationStatus(String activationStatus) {
            this.activationStatus=activationStatus;
        }
    }

    public class OrderActions{
        public String type;
        public CreateSubscription createSubscription;
        public List<TriggerDates> triggerDates;
        public CancelSubscription cancelSubscription;
        public Integer sequence;
        public TermsAndConditions termsAndConditions;
        public Map<String,String> customFields;
       // public 

        public OrderActions(String type, CreateSubscription createSubscription, List<TriggerDates> triggerDates){
            this.type = type;
            this.createSubscription = createSubscription;
            this.triggerDates = triggerDates;
        }

        public OrderActions(String type, List<TriggerDates> triggerDates, CancelSubscription cancelSubscription){
            this.type = type;
            this.triggerDates = triggerDates;
            this.cancelSubscription = cancelSubscription;
        }

        public OrderActions(Integer sequence, List<TriggerDates> triggerDates){
            this.sequence = sequence;
            this.triggerDates = triggerDates;
        }
        public OrderActions(Integer sequence, List<TriggerDates> triggerDates, Map<String,String> customFields){
            this.sequence = sequence;
            this.triggerDates = triggerDates;
            this.customFields = customFields;
        }

        public OrderActions(String type, List<TriggerDates> triggerDates, TermsAndConditions termsAndConditions){
            this.type = type;
            this.triggerDates = triggerDates;
            this.termsAndConditions = termsAndConditions;
        }
    }

    public class CreateSubscription{
        public List<SubscribeToRatePlans> subscribeToRatePlans;
        public Terms terms;

        public CreateSubscription(List<SubscribeToRatePlans> subscribeToRatePlans, Terms terms){
            this.subscribeToRatePlans = subscribeToRatePlans;
            this.terms = terms;
        }
    }

    public class Terms{
        public boolean autoRenew;
        public InitialTerm initialTerm;
        public String renewalSetting;
        public List<RenewalTerms> renewalTerms;

        public Terms(boolean autoRenew, InitialTerm initialTerm, String renewalSetting, List<RenewalTerms> renewalTerms){
            this.autoRenew = autoRenew;
            this.initialTerm = initialTerm;
            this.renewalSetting = renewalSetting;
            this.renewalTerms = renewalTerms;
        }
    }

    public class InitialTerm{
        public Integer period;
        public String periodType;
        public String startDate;
        public String termType;

        public InitialTerm(Integer period, String periodType, String startDate, String termType){
            this.period = period;
            this.periodType = periodType;
            this.startDate = startDate;
            this.termType = termType;
        }
    }

    public class SubscribeToRatePlans{
        public String productRatePlanId;
        public CustomFields customFields;

        public SubscribeToRatePlans(String productRatePlanId){
            this.productRatePlanId = productRatePlanId;
        }

        public SubscribeToRatePlans(String productRatePlanId, CustomFields customFields){
            this.productRatePlanId = productRatePlanId;
            this.customFields = customFields;
        }
        
    }

    public class RenewalTerms{
        public Integer period;
        public String periodType;

        public RenewalTerms(Integer period, String periodType){
            this.period = period;
            this.periodType = periodType;
        }
    }

    public class TriggerDates{
        public String name;
        public String triggerDate;

        public  TriggerDates(String name, String triggerDate){
            this.name = name;
            this.triggerDate = triggerDate;
        }
    }

    public class NewAccount{
        public Integer billCycleDay;
        public String batch_x;
        public String name;
        public String currency2;
        public String crmId;
        public String hpmCreditCardPaymentMethodId;
        public BillToContact billToContact;
        public SoldToContact soldToContact;

        public NewAccount(Integer billCycleDay, String batch_x, String name, String currency2, String crmId,
            String hpmCreditCardPaymentMethodId, BillToContact billToContact, SoldToContact soldToContact) {
            this.billCycleDay = billCycleDay;
            this.batch_x = batch_x;
            this.name = name;
            this.currency2 = currency2;
            this.crmId = crmId;
            this.hpmCreditCardPaymentMethodId = hpmCreditCardPaymentMethodId;
            this.billToContact = billToContact;
            this.soldToContact = soldToContact;
        }
    }

    public class BillToContact{
        public String firstName;
        public String lastName;
        public String country;

        public BillToContact(String firstName, String lastName, String country){
            this.firstName = firstName;
            this.lastName = lastName;
            this.country = country;
        }
    }

    public class SoldToContact{
        public String firstName;
        public String lastName;
        public String country;

        public SoldToContact(String firstName, String lastName, String country){
            this.firstName = firstName;
            this.lastName = lastName;
            this.country = country;
        }
    }

    public class CancelSubscription{
        public String cancellationPolicy;
        public String cancellationEffectiveDate;

        public CancelSubscription(String cancellationPolicy, String cancellationEffectiveDate){
            this.cancellationPolicy = cancellationPolicy;
            this.cancellationEffectiveDate = cancellationEffectiveDate;
        }
    }

    public class TermsAndConditions{
        public LastTerm lastTerm;

        public TermsAndConditions(LastTerm lastTerm){
            this.lastTerm = lastTerm;
        }
    }
    

    public class LastTerm{
        public String startDate;

        public LastTerm(String startDate){
            this.startDate = startDate;
        }
    }
}