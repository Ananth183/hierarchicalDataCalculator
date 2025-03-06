/*
    Author: Anantha Gadamsetty
    Description: Selector class to get child records based on the parent record
    Date: 06/03/2025
*/

public with sharing class HierarchicalDataSelector {

    /*
        Method to retrieve child records based on the parent records passed in the request.
        
        @param request - The request object containing parent records and field names.
        @return A list of child records matching the parent Ids.
    */
    public static List<SObject> getChildRecords(HierarchicalDataRequest request) {
        List<Id> parentIds = new List<Id>();
        for (SObject parent : request.parentRecords) {
            parentIds.add((Id) parent.get('Id'));
        }
        
        String query = 'SELECT ' + request.parentField + ', ' + request.valueField + ' FROM ' + request.childObject + ' WHERE ' + request.parentField + ' IN :parentIds';
        return Database.query(query);
    }
}