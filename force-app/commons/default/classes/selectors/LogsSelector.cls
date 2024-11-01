public without sharing class LogsSelector extends fflib_SObjectSelector implements ILogsSelector {
    public static ILogsSelector newInstance() {
        return (ILogsSelector) Commons.Selector.newInstance(bn2gp__Log__c.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe()
            .get('bn2gp__Log__c')
            .getDescribe()
            .fields.getMap();
        return fieldMap.values();
    }

    public Schema.SObjectType getSObjectType() {
        return bn2gp__Log__c.SObjectType;
    }

    public List<bn2gp__Log__c> selectById(Set<Id> idSet) {
        return (List<bn2gp__Log__c>) selectSObjectsById(idSet);
    }

    public override String getOrderBy() {
        return 'CreatedDate DESC';
    }

    public Integer fetchRecordsCount(LogWrapper param) {
        Integer limitSize = Limits.getLimitQueryRows() - Limits.getQueryRows();
        if (param.limitSize == null || param.limitSize > limitSize) {
            param.limitSize = limitSize;
        }
        fflib_QueryFactory logsQuery = newQueryFactory(false, false, false);
        List<bn2gp__Log__c> records = fetchRecords(param, logsQuery);
        return records.size();
    }

    public List<bn2gp__Log__c> fetchRecords(LogWrapper param) {
        fflib_QueryFactory logsQuery = newQueryFactory(false, false, true)
            .selectField('bn2gp__Contact__r.Name')
            .selectField('Owner.Name');
        return fetchRecords(param, logsQuery);
    }

    public List<bn2gp__Log__c> fetchRecords(Set<Id> idSet) {
        return fetchRecords(null, null, idSet);
    }

    public List<bn2gp__Log__c> fetchRecords(Integer limitSize, Integer offsetSize, Set<Id> idSet) {
        LogWrapper param = new LogWrapper();
        param.limitSize = limitSize;
        param.offsetSize = offsetSize;
        param.idSet = idSet;
        return fetchRecords(param);
    }

    public List<bn2gp__Log__c> fetchRecords(LogWrapper param, fflib_QueryFactory logsQuery) {
        Integer limitSize = param.limitSize;
        Integer offsetSize = param.offsetSize;
        Set<Id> idSet = param.idSet;

        if (limitSize != null) {
            logsQuery.setLimit(limitSize);
        }
        if (offsetSize != null) {
            logsQuery.setOffset(offsetSize);
        }
        if (idSet != null) {
            QueryFactoryUtils.appendCondition(logsQuery, ' AND ', 'Id IN :idSet');
        }

        return (List<bn2gp__Log__c>) Database.query(logsQuery.toSOQL());
    }

    public List<Info> fetchRecordInfos(Integer limitSize, Integer offsetSize, Set<Id> idSet) {
        List<bn2gp__Log__c> records = fetchRecords(limitSize, offsetSize, idSet);
        List<Info> infos = new List<Info>();
        for (bn2gp__Log__c record : records) {
            infos.add(new Info(record));
        }
        return infos;
    }

    public List<Info> fetchRecordInfos(LogWrapper param) {
        List<bn2gp__Log__c> records = fetchRecords(param);
        List<Info> infos = new List<Info>();
        for (bn2gp__Log__c record : records) {
            infos.add(new Info(record));
        }
        return infos;
    }

    public Info fetchRecordInfo(Id recordId) {
        Set<Id> idSet = new Set<Id>{ recordId };
        bn2gp__Log__c con = fetchRecords(idSet)[0];
        return new Info(con);
    }

    public class Info {
        @AuraEnabled
        public Id id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String recordUrl { get; set; }
        @AuraEnabled
        public Datetime createdDate { get; set; }
        @AuraEnabled
        public String logId { get; set; }
        @AuraEnabled
        public String service { get; set; }
        @AuraEnabled
        public String level { get; set; }
        @AuraEnabled
        public String type { get; set; }
        @AuraEnabled
        public String feature { get; set; }
        @AuraEnabled
        public String deviceInfo { get; set; }
        @AuraEnabled
        public String ipAddress { get; set; }
        @AuraEnabled
        public Id ownerId { get; set; }
        @AuraEnabled
        public String ownerName { get; set; }
        @AuraEnabled
        public String description { get; set; }

        public Info(bn2gp__Log__c record) {
            this.id = record.Id;
            this.name = record.Name;
            this.recordUrl = '/' + record.Id;
            this.createdDate = record.CreatedDate;
            this.logId = record.bn2gp__LogId__c;
            this.service = record.bn2gp__Service__c;
            this.level = record.bn2gp__Level__c;
            this.type = record.bn2gp__Type__c;
            this.feature = record.bn2gp__Feature__c;
            this.deviceInfo = record.bn2gp__DeviceInfo__c;
            this.ipAddress = record.bn2gp__IpAddress__c;
            this.ownerId = record.OwnerId;
            this.ownerName = record.Owner.Name;
            this.description = record.bn2gp__Description__c;
        }
    }
}
