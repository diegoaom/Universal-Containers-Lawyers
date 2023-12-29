public with sharing class Ucl_ErrorLogManager {

    public void logError(String errorOrException, String errorMessage, String location) {
        Error_Log__c errorLog = new Error_Log__c(
            Name = errorOrException,
            Error_Message__c = errorOrException + errorMessage,
            Timestamp__c = Datetime.now(),
            Location__c = location
        );

        insert errorLog;
    }
}

