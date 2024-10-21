public with sharing class ChecklistController {
    @AuraEnabled(cacheable=true)
    public static List<Checklist__c> getChecklist(Id projectId){
        return[SELECT Id, Check_Point__c, Projects__c, Status__c
               FROM Checklist__c
               WHERE Status__c IN ('Open', 'Escalated') AND Projects__c =:projectId
               ORDER BY CreatedDate];
    }

    @AuraEnabled
    public static void deleteChecklist(Id checklistId) {
        Checklist__c check = [SELECT Id 
                                         FROM Checklist__c 
                                         WHERE Id = :checklistId];
        if (check != null) {
            delete check;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Checklist__c> getClosedChecklist(Id projectId){
        return [SELECT Id, Check_Point__c, Status__c, Projects__c
               FROM Checklist__c
               WHERE Status__c = 'Closed' AND Projects__c = :projectId
               ORDER BY CreatedDate];
    }    
}