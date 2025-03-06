// Request Class
public with sharing class HierarchicalDataRequest {
    @AuraEnabled @InvocableVariable(label='Parent Object' required=true)
    public String parentObject;
    
    @AuraEnabled @InvocableVariable(label='Child Object' required=true)
    public String childObject;
    
    @AuraEnabled @InvocableVariable(label='Parent Field' required=true)
    public String parentField;
    
    @AuraEnabled @InvocableVariable(label='Value Field' required=true)
    public String valueField;
    
    @AuraEnabled @InvocableVariable(label='Parent Records' required=true)
    public List<SObject> parentRecords;
}