// Response Class
public with sharing class HierarchicalDataResponse {
    @AuraEnabled @InvocableVariable(label='Parent Id' required=true)
    public Id parentId;
    
    @AuraEnabled @InvocableVariable(label='Parent Name')
    public String parentName;
    
    @AuraEnabled @InvocableVariable(label='Average Value')
    public Decimal avgValue;
    
    @AuraEnabled @InvocableVariable(label='Minimum Value')
    public Decimal minValue;
    
    @AuraEnabled @InvocableVariable(label='Maximum Value')
    public Decimal maxValue;
    
    @AuraEnabled @InvocableVariable(label='Sum Value')
    public Decimal sumValue;
    
    @AuraEnabled @InvocableVariable(label='Child Values')
    public String childValues;
    
    public HierarchicalDataResponse(Id parentId, String parentName, Decimal avg, Decimal min, Decimal max, Decimal sum, String childValues) {
        this.parentId = parentId;
        this.parentName = parentName;
        this.avgValue = avg;
        this.minValue = min;
        this.maxValue = max;
        this.sumValue = sum;
        this.childValues = childValues;
    }
}