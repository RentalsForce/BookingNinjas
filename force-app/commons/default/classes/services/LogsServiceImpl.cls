public without sharing class LogsServiceImpl implements ILogsService {
    public Map<String, Object> create(List<LogWrapper> logsData) {
        Boolean success = false;
        String message = 'No records created.';
        if (logsData != null & logsData.size() > 0) {
            List<bn2gp__Log__c> logs = new List<bn2gp__Log__c>();
            for (LogWrapper logData : logsData) {
                String description = logdata.description;
                bn2gp__Log__c log = new bn2gp__Log__c(
                    bn2gp__Contact__c = logData.contactId,
                    bn2gp__Description__c = description.length() > 255 ? description.substring(0, 255) : description,
                    bn2gp__Details__c = logdata.details,
                    bn2gp__DeviceInfo__c = logdata.deviceInfo,
                    bn2gp__IpAddress__c = logData.ipAddress,
                    bn2gp__Level__c = logData.level.name(),
                    bn2gp__Type__c = logData.type.name(),
                    bn2gp__Feature__c = logData.feature.name(),
                    bn2gp__LogId__c = logData.logId,
                    bn2gp__Service__c = logData.service
                );
                logs.add(log);
            }
            // persist to database
            insert logs;
        }

        return BNUtils.responseCreator(new List<String>{ 'success', 'message' }, new List<Object>{ success, message });
    }
}
