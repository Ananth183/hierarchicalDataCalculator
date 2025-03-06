/*
    Author: Anantha Gadamsetty
    Description: Test Data Factory class to generate test data for parent__c object
    Date: 06/03/2025
*/

@isTest
public with sharing class ParentDataFactory {

    /*
        Method to generate a list of Parent__c records.
        
        @param count - The number of Parent__c records to create.
        @return A list of created Parent__c records.
    */
    public static List<Parent__c> createParents(Integer count) {
        List<Parent__c> parents = new List<Parent__c>();
        for (Integer i = 0; i < count; i++) {
            parents.add(new Parent__c(Name = 'Parent ' + (i + 1)));
        }
        return parents;
    }
}