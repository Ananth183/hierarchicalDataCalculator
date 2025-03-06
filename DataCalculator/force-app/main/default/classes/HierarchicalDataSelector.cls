// Selector Class
public with sharing class HierarchicalDataSelector {
    public static List<SObject> getChildRecords(HierarchicalDataRequest request) {
        List<Id> parentIds = new List<Id>();
        for (SObject parent : request.parentRecords) {
            parentIds.add((Id) parent.get('Id'));
        }
        
        String query = 'SELECT ' + request.parentField + ', ' + request.valueField + ' FROM ' + request.childObject + ' WHERE ' + request.parentField + ' IN :parentIds';
        return Database.query(query);
    }
}