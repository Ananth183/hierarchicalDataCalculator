/*
    Author: Anantha Gadamsetty
    Description: Test class for the HierarchicalDataCalculator class
    Date: 06/03/2025
*/
@isTest
public with sharing class HierarchicalDataCalculatorTest {
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
        Test method to verify the calculations performed by the HierarchicalDataCalculator class.
    */
    @isTest
    static void testPerformCalculations() {
        List<Parent__c> parents = [SELECT Id, Name FROM Parent__c];
        List<Child__c> children = [SELECT Id, Parent__c, Value__c FROM Child__c];
        
        HierarchicalDataRequest request = new HierarchicalDataRequest();
        request.parentObject = 'Parent__c';
        request.childObject = 'Child__c';
        request.parentField = 'Parent__c';
        request.valueField = 'Value__c';
        request.parentRecords = new List<SObject>();
        for (Parent__c parent : parents) {
            request.parentRecords.add(parent);
        }
        
        List<HierarchicalDataResponse> responses = HierarchicalDataCalculator.performCalculations(request, children);
        
        System.assertEquals(2, responses.size());
        for (HierarchicalDataResponse res : responses) {
            if (res.parentName == 'Parent 1') {
                System.assertEquals(15, res.avgValue);
                System.assertEquals(10, res.minValue);
                System.assertEquals(20, res.maxValue);
                System.assertEquals(30, res.sumValue);
            } else if (res.parentName == 'Parent 2') {
                System.assertEquals(35, res.avgValue);
                System.assertEquals(30, res.minValue);
                System.assertEquals(40, res.maxValue);
                System.assertEquals(70, res.sumValue);
            }
        }
    }
}