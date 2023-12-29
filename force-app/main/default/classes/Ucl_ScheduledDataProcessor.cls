global with sharing class Ucl_ScheduledDataProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        schedulableDataProcessor();
    }

    @AuraEnabled
    public static void executeScheduledDataProcessor() {
        Ucl_ScheduledDataProcessor invocation = new Ucl_ScheduledDataProcessor();
        invocation.dataProcessingService();
    }

    @future(callout=true)
    public static void schedulableDataProcessor() {
        Ucl_ScheduledDataProcessor scheduled = new Ucl_ScheduledDataProcessor();
        scheduled.dataProcessingService();
    }

    public void dataProcessingService() {
        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        if (!legalAdvisorMap.isEmpty()) {
            Ucl_UpsertManager upsertManager = new Ucl_UpsertManager();
            Map<String, List<Ucl_Client>> clientsToUpsert = upsertManager.upsertLegalAdvisors(legalAdvisorMap);

            if (!clientsToUpsert.isEmpty()) {
                upsertManager.upsertClients(clientsToUpsert);
            }

            Ucl_UpdateLegalAdvisorStatus updateManager = new Ucl_UpdateLegalAdvisorStatus();
            updateManager .updateLegalAdvisorStatus(legalAdvisorMap);

            Ucl_ClientDelete deleteManager = new Ucl_ClientDelete();
            deleteManager.clientDelete(legalAdvisorMap);
        }
    }
}