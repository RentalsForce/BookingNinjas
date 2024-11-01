public without sharing class LogController {
    @AuraEnabled
    public static Map<String, Object> create(List<LogWrapper> logsData) {
        return LogsService.create(logsData);
    }

    @AuraEnabled
    public static Integer getTotalRecords(LogWrapper param) {
        return new LogsSelector().fetchRecordsCount(param);
    }

    @AuraEnabled
    public static List<LogsSelector.Info> getRecordInfos(LogWrapper param) {
        return new LogsSelector().fetchRecordInfos(param);
    }
}
