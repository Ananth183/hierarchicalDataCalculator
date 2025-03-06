/*
    Author: Anantha Gadamsetty
    Description: Service class to calculate hierarchial data from child and parent records
    Date: 06/03/2025
*/


public with sharing class HierarchicalDataCalculator {
    public static List<HierarchicalDataResponse> performCalculations(HierarchicalDataRequest request, List<SObject> childRecords) {
        Map<Id, List<SObject>> parentToChildrenMap = new Map<Id, List<SObject>>();
        for (SObject child : childRecords) {
            Id parentId = (Id)child.get(request.parentField);
            if (!parentToChildrenMap.containsKey(parentId)) {
                parentToChildrenMap.put(parentId, new List<SObject>());
            }
            parentToChildrenMap.get(parentId).add(child);
        }

        Map<Id, SObject> parentRecordMap = new Map<Id, SObject>();
        for (SObject parent : request.parentRecords) {
            parentRecordMap.put((Id) parent.get('Id'), parent);
        }
        
        List<HierarchicalDataResponse> calculationResults = new List<HierarchicalDataResponse>();
        for (Id parentId : parentToChildrenMap.keySet()) {
            List<SObject> childList = parentToChildrenMap.get(parentId);
            if (childList == null || childList.isEmpty()) continue;
            List<String> childValuesList = new List<String>();
            Decimal totalValue = 0, minValue = null, maxValue = null;
            for (SObject child : childList) {
                Decimal value = (Decimal)child.get(request.valueField);
                totalValue += value;
                
                childValuesList.add(String.valueOf(value));
                if (minValue == null || value < minValue) minValue = value;
                if (maxValue == null || value > maxValue) maxValue = value;
            }
            Decimal avgValue = totalValue / childList.size();
            String childValues = String.join(childValuesList, ',');
            
            calculationResults.add(new HierarchicalDataResponse(parentId, 
                                                                (String)parentRecordMap.get(parentId).get('Name'),
                                                                avgValue, 
                                                                minValue, 
                                                                maxValue, 
                                                                totalValue,
                                                                childValues
                                                               	));

            calculationResults.sort(new HierarchicalDataResponseSorter());

        }
        return calculationResults;
    }

      // Custom Comparator for sorting by parent name
      public class HierarchicalDataResponseSorter implements Comparator<HierarchicalDataResponse> {
        public Integer compare(HierarchicalDataResponse a, HierarchicalDataResponse b) {
            return a.parentName.toLowerCase().compareTo(b.parentName.toLowerCase());
        }
    }
}