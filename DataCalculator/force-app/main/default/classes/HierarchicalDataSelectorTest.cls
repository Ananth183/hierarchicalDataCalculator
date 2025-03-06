/*
    Author: Anantha Gadamsetty
    Description: Test class for the HierarchicalDataSelector class
    Date: 06/03/2025
*/

@isTest
public with sharing class HierarchicalDataSelectorTest {

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

    
    @isTest
    static void testGetChildRecords() {
        List<Parent__c> parents = [SELECT Id FROM Parent__c];
        HierarchicalDataRequest request = new HierarchicalDataRequest();
        request.childObject = 'Child__c';
        request.parentField = 'Parent__c';
        request.valueField = 'Value__c';
        request.parentRecords = new List<SObject>();
        for (Parent__c parent : parents) {
            request.parentRecords.add(parent);
        }
        
        Test.startTest();
        List<SObject> children = HierarchicalDataSelector.getChildRecords(request);
        Test.stopTest();
        
        System.assertEquals(4, children.size());
    }
}