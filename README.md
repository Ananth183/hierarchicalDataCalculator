1.Overview 

Invocable action will allow Salesforce Flow to process hierarchical data efficiently while dynamically adapting to various data structures. This ensures businesses can leverage real-time calculations without exceeding governor limits or encountering system failures due to unhandled exceptions. 

Our newly developed Salesforce Flow Invocable Action empowers organizations with advanced data processing capabilities, ensuring that hierarchical data is handled efficiently while maintaining high system reliability. 

2. Apex Classes 

2.1 Overview 

Apex classes contain the logic for performing hierarchical data calculations, handling requests, and selecting the relevant records. They also include test classes for unit testing the functionality. 

2.2 List of Apex Classes 

HierarchicalDataResponse: Defines the structure of the response for hierarchical data calculations. 

HierarchicalDataRequest: Manages the request for hierarchical data operations. 

HierarchicalDataSelector: Determines which records should be processed in hierarchical data calculations. 

HierarchicalDataCalculator: Implements the core logic for calculating AVG, MIN, MAX, and SUM for hierarchical data. 

HierarchicalDataInvocable: An invocable class that can be called from Salesforce Flow to trigger hierarchical data calculations. 

HierarchicalDataCalculatorTest: A test class to ensure the functionality of the HierarchicalDataCalculator. 

HierarchicalDataInvocableTest: A test class for the HierarchicalDataInvocable class. 

HierarchicalDataSelectorTest: A test class for the HierarchicalDataSelector. 

HierarchicalDataResponseTest: A test class for the HierarchicalDataResponse. 

2.3 Usage 

These classes encapsulate the logic for hierarchical data calculation, record selection, and response formatting. They integrate with other Salesforce components such as Flows and Custom Objects. 

 

3. Flow Components 

3.1 Overview 

Flows in this package automate the calculation of hierarchical data. They invoke Apex classes to calculate and return results for parent-child records. 

3.2 List of Flows 

Calculate_Hierarchical_data: A Flow for calculating hierarchical data across multiple records. 

Calculate_Hierarchical_Data_Of_Parent_Record: A Flow that calculates hierarchical data for a specific parent record. 

3.3 Usage 

These Flows trigger Apex logic to calculate hierarchical data for records, allowing users to automate the data processing workflow. 

 

4. Custom Objects 

4.1 Overview 

Custom Objects store parent and child record data, which are essential for hierarchical calculations. 

4.2 List of Custom Objects 

Parent__c: Represents a parent record in a hierarchical structure. 

Child__c: Represents a child record related to a parent. 

4.3 Usage 

The Parent__c and Child__c objects hold data that will be used for hierarchical calculations and are crucial for determining relationships between records. 

 

5. Custom Tabs 

5.1 Overview 

Custom Tabs provide easy access to the custom objects within the Salesforce user interface. 

5.2 List of Custom Tabs 

Parent__c: A custom tab for accessing Parent records. 

Child__c: A custom tab for accessing Child records. 

5.3 Usage 

These tabs allow users to navigate quickly to the Parent and Child records to view and manage data involved in hierarchical calculations. 

 

6. Custom Application 

6.1 Overview 

This custom application integrates all hierarchical data calculation features, providing users with access to data processing tools. 

6.2 Custom Application 

Hierarchical_Data_Calculator: The application that allows users to manage hierarchical data calculations. 

6.3 Usage 

The Hierarchical_Data_Calculator application serves as the central hub for users to interact with the data, access records, and trigger calculation processes. 

 

7. FlexiPages 

7.1 Overview 

FlexiPages define custom layouts for displaying hierarchical data and calculation results on Salesforce pages. 

7.2 List of FlexiPages 

Hierarchical_Data_Calculator: FlexiPage for managing hierarchical data calculations. 

Parent_Record_Page: FlexiPage for displaying Parent records and related data. 

Home_Page_DataCalculator: FlexiPage for the homepage, providing easy access to data calculation tools. 

7.3 Usage 

These FlexiPages control how hierarchical data and its calculation results are displayed on Salesforce pages, allowing for a streamlined user interface. 

 

8. Quick Actions 

8.1 Overview 

Quick Actions allow users to perform actions, such as triggering hierarchical data calculations, directly from the Salesforce interface. 

8.2 List of Quick Actions 

Parent__c.Calculate_Hierarchical_Data: A Quick Action for calculating hierarchical data on a Parent record. 

8.3 Usage 

This Quick Action enables users to perform hierarchical data calculations on Parent records without navigating away from the page. 

 

9. Salesforce Version 

API Version: 62.0 

This version specifies the metadata API version used for deployment and is compatible with the features provided by Salesforce. 

 

10. Functional Workflow 

10.1 Overview 

The workflow for calculating hierarchical data involves a series of user interactions and automated processes. The user triggers actions via Quick Actions or Flows, which in turn invoke Apex classes to perform calculations. The results are displayed through FlexiPages and custom tabs. 

10.2 Steps in the Workflow 

User Interaction: 

Access Parent__c or Child__c records via custom tabs. 

Trigger hierarchical data calculations using Quick Actions or Flows. 

Flow Execution: 

The Flow calls the relevant Apex classes to perform calculations and return results. 

Data Display: 

The results are displayed via the Hierarchical_Data_Calculator FlexiPage or on Parent and Child record pages. 

Testing: 

Apex test classes ensure the correctness and functionality of the entire process. 

 

11. Conclusion 

This package provides a comprehensive solution for calculating hierarchical data in Salesforce. It integrates Apex classes, Flows, Custom Objects, Tabs, FlexiPages, and Quick Actions into a unified system that automates complex data calculations while providing an intuitive interface for users. 
