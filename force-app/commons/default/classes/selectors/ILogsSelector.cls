public interface ILogsSelector extends fflib_ISObjectSelector {
    List<bn2gp__Log__c> selectById(Set<Id> idSet);
    List<bn2gp__Log__c> fetchRecords(Set<Id> idSet);
    List<bn2gp__Log__c> fetchRecords(Integer limitSize, Integer offsetSize, Set<Id> idSet);
    List<LogsSelector.Info> fetchRecordInfos(Integer limitSize, Integer offsetSize, Set<Id> idSet);
    LogsSelector.Info fetchRecordInfo(Id recordId);
}
