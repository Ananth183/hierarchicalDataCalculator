/*
    Author: Anantha Gadamsetty
    Description: Test class for the HierarchicalDataInvocable class
    Date: 06/03/2025
*/

@isTest
public with sharing class HierarchicalDataInvocableTest {

    @testSetup
    static void setupTestData() {
        // Create Parent Records
        List<Parent__c> parents = ParentDataFactory.createParents(2);
        insert parents;
        
        // Create Child Records
        List<Integer> values = new List<Integer>{10, 20, 30, 40};
        List<Child__c> children = ChildDataFactory.createChildren(parents, values);
        insert children;
    }

    /*
        Test method to validate the invocable method calculation results.
    */
    @isTest
    static void testInvocableMethod() {
        List<Parent__c> parents = [SELECT Id, Name FROM Parent__c];
        
        HierarchicalDataRequest request = new HierarchicalDataRequest();
        request.parentObject = 'Parent__c';
        request.childObject = 'Child__c';
        request.parentField = 'Parent__c';
        request.valueField = 'Value__c';
        request.parentRecords = new List<SObject>();
        for (Parent__c parent : parents) {
            request.parentRecords.add(parent);
        }
        
        List<List<HierarchicalDataResponse>> result = HierarchicalDataInvocable.calculateHierarchicalData(new List<HierarchicalDataRequest>{ request });
        
        System.assertEquals(1, result.size());
        System.assertEquals(2, result[0].size());
    }
}