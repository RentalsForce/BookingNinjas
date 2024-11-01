public with sharing class LogWrapper {
    @AuraEnabled
    public Integer limitSize { get; set; }
    @AuraEnabled
    public Integer offsetSize { get; set; }
    @AuraEnabled
    public Set<Id> idSet { get; set; }
    @AuraEnabled
    public Logs.Level level { get; set; }
    @AuraEnabled
    public Logs.Type type { get; set; }
    @AuraEnabled
    public Logs.Feature feature { get; set; }
    @AuraEnabled
    public Id id { get; set; }
    @AuraEnabled
    public Id contactId { get; set; }
    @AuraEnabled
    public String contactName { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public String details { get; set; }
    @AuraEnabled
    public String deviceInfo { get; set; }
    @AuraEnabled
    public String ipAddress { get; set; }
    @AuraEnabled
    public String logId { get; set; }
    @AuraEnabled
    public String service { get; set; }
}
