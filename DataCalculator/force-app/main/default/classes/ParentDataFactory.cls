@isTest
public with sharing class ParentDataFactory {
    public static List<Parent__c> createParents(Integer count) {
        List<Parent__c> parents = new List<Parent__c>();
        for (Integer i = 0; i < count; i++) {
            parents.add(new Parent__c(Name = 'Parent ' + (i + 1)));
        }
        return parents;
    }
}