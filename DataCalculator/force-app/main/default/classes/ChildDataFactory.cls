/*
    Author: Anantha Gadamsetty
    Description: Test Data Factory class to generate test data for child__c object  
    Date: 06/03/2025
*/

@isTest
public with sharing class ChildDataFactory {

     /*
        Method to create test child records for a given list of parent records.
        Each parent gets 2 child records.

        @param parents - List of Parent__c records to associate with children.
        @param values - List of values to assign to the child records' Value__c field.
        @return A list of Child__c records.
    */
    public static List<Child__c> createChildren(List<Parent__c> parents, List<Integer> values) {
        List<Child__c> children = new List<Child__c>();
        Integer index = 0;
        for (Parent__c parent : parents) {
            for (Integer j = 0; j < 2; j++) { 
                children.add(new Child__c(
                    Name = 'Child ' + (index + 1),
                    Parent__c = parent.Id,
                    Value__c = values[index]
                ));
                index++;
            }
        }
        return children;
    }
}