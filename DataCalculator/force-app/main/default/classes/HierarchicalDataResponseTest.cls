/*
    Author: Anantha Gadamsetty
    Description: Test class fpr HierarchicalDataResponse class
    Date: 06/03/2025
*/

@isTest
private class HierarchicalDataResponseTest {

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
    static void testHierarchicalDataResponse() {
        // Test Data Setup
        Id testParentId =  [SELECT Id, Name FROM Parent__c][0].Id;
        String testParentName = 'Test Parent';
        Decimal testAvg = 50.5;
        Decimal testMin = 10;
        Decimal testMax = 100;
        Decimal testSum = 505;
        String testChildValues = '10,20,30,40,50';
        
        // Instantiate the response class
        HierarchicalDataResponse response = new HierarchicalDataResponse(
            testParentId, testParentName, testAvg, testMin, testMax, testSum, testChildValues
        );
        
        // Assertions
        System.assertEquals(testParentId, response.parentId, 'Parent Id should match');
        System.assertEquals(testParentName, response.parentName, 'Parent Name should match');
        System.assertEquals(testAvg, response.avgValue, 'Average Value should match');
        System.assertEquals(testMin, response.minValue, 'Minimum Value should match');
        System.assertEquals(testMax, response.maxValue, 'Maximum Value should match');
        System.assertEquals(testSum, response.sumValue, 'Sum Value should match');
        System.assertEquals(testChildValues, response.childValues, 'Child Values should match');
    }
}