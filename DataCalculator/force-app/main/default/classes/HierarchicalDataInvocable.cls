/*
    Author: Anantha Gadamsetty
    Description: Invocable apex class to calculate hierarchical data from child and parent records
    Date: 06/03/2025
*/

public with sharing class HierarchicalDataInvocable {
    @InvocableMethod(label='Calculate Hierarchical Data' description='Calculates AVG, MIN, MAX, and SUM for child records under each parent dynamically.')
    //public static List<HierarchicalDataResponse> calculateHierarchicalData(List<HierarchicalDataRequest> requestList) {
    public static List<List<HierarchicalDataResponse>> calculateHierarchicalData(List<HierarchicalDataRequest> requestList) {
        Nebula.Logger.info('Starting hierarchical data calculation.');
        Nebula.Logger.debug('Input request: ' + JSON.serialize(requestList));
        
        if (requestList.isEmpty()) {
            Nebula.Logger.info('No input data received. Exiting.');
            //return new List<HierarchicalDataResponse>();
            return new List<List<HierarchicalDataResponse>>();
        }
        
        HierarchicalDataRequest request = requestList[0];
        List<SObject> childRecords = HierarchicalDataSelector.getChildRecords(request);
        List<HierarchicalDataResponse> results = HierarchicalDataCalculator.performCalculations(request, childRecords);
        
        Nebula.Logger.debug('Calculation results: ' + JSON.serialize(results));
        Nebula.Logger.saveLog();
        
        //return results;
        return new List<List<HierarchicalDataResponse>>{results};
    }
}