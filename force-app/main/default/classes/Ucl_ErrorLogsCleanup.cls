global with sharing class Ucl_ErrorLogsCleanup implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Date oneMonthAgo = System.today().addMonths(-1);

        List<Error_Log__c> errorLogsToDelete = [SELECT Id FROM Error_Log__c WHERE Timestamp__c < :oneMonthAgo];

        if (!errorLogsToDelete.isEmpty()) {
            delete errorLogsToDelete;
        }
    }
}
