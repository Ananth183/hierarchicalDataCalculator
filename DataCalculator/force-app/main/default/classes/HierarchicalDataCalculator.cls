/*
    Author: Anantha Gadamsetty
    Description: Service class to calculate hierarchical data from child and parent records
    Date: 06/03/2025
*/

public with sharing class HierarchicalDataCalculator {

     /*
        Main method to perform hierarchical data calculations.

        @param request - Contains information about the fields for calculation.
        @param childRecords - List of child records to be processed.
        @return A list of hierarchical data responses containing the calculation results.
    */
    public static List<HierarchicalDataResponse> performCalculations(HierarchicalDataRequest request, List<SObject> childRecords) {
        
        // Group child records by parent Id
        Map<Id, List<SObject>> parentToChildrenMap = new Map<Id, List<SObject>>();
        for (SObject child : childRecords) {
            Id parentId = (Id)child.get(request.parentField);
            if (!parentToChildrenMap.containsKey(parentId)) {
                parentToChildrenMap.put(parentId, new List<SObject>());
            }
            parentToChildrenMap.get(parentId).add(child);
        }

        // Map parent records by Id
        Map<Id, SObject> parentRecordMap = new Map<Id, SObject>();
        for (SObject parent : request.parentRecords) {
            parentRecordMap.put((Id) parent.get('Id'), parent);
        }

        // Prepare list to hold calculation results
        List<HierarchicalDataResponse> calculationResults = new List<HierarchicalDataResponse>();
        for (Id parentId : parentRecordMap.keySet()) {
            List<SObject> childList = parentToChildrenMap.get(parentId);
            
            // Initialize calculation variables
            Decimal totalValue = 0, minValue = null, maxValue = null;
            List<String> childValuesList = new List<String>();
            
            // Calculate total, min, max, and format child values
            if (childList != null && !childList.isEmpty()) {
                for (SObject child : childList) {
                    Decimal value = (Decimal)child.get(request.valueField);

                    // Ensure value is not null
                    if (value == null) {
                        value = 0; 
                    }

                    totalValue += value;
                    String formattedValue = value == value.setScale(0) ? String.valueOf(value.intValue()) : String.valueOf(value);
                    childValuesList.add(formattedValue);

                    // Update min and max values
                    if (minValue == null || value < minValue) minValue = value;
                    if (maxValue == null || value > maxValue) maxValue = value;
                }
            }
            
            // Calculate average value and ensure min/max are set
            Decimal avgValue = (childList != null && !childList.isEmpty()) ? totalValue / childList.size() : 0;
            minValue = (minValue != null) ? minValue : 0;
            maxValue = (maxValue != null) ? maxValue : 0;
            
            // Join child values into a single string
            String childValues = String.join(childValuesList, ' , ');
            
            // Add results to list
            calculationResults.add(new HierarchicalDataResponse(parentId, 
                                                                (String)parentRecordMap.get(parentId).get('Name'),
                                                                avgValue, 
                                                                minValue, 
                                                                maxValue, 
                                                                totalValue,
                                                                childValues
                                                                ));
        }

        // Sort results by parent name
        calculationResults.sort(new HierarchicalDataResponseSorter());
        return calculationResults;
    }

    /*
        Custom comparator to sort results by parent name.
    */
    public class HierarchicalDataResponseSorter implements Comparator<HierarchicalDataResponse> {
        
           /*
            Compare method to sort by parent name in lowercase for case-insensitive comparison.

            @param a - First HierarchicalDataResponse object.
            @param b - Second HierarchicalDataResponse object.
            @return An integer value for sorting order.
        */
        public Integer compare(HierarchicalDataResponse a, HierarchicalDataResponse b) {
            return a.parentName.toLowerCase().compareTo(b.parentName.toLowerCase());
        }
    }
}
