public with sharing class Logs extends fflib_SObjects implements ILogs {
    public enum Level {
        DEBUG,
        INFO,
        WARN,
        ERROR,
        FATAL
    }

    public enum Type {
        SALESFORCE,
        APPLICATION,
        SECURITY,
        DATABASE
    }

    public enum Feature {
        PROPERTY_MANAGEMENT,
        POINT_OF_SALES,
        BOOKING_ENGINE,
        STUDENT_PORTAL
    }

    public static ILogs newInstance(List<bn2gp__Log__c> recordList) {
        return (ILogs) Commons.Domain.newInstance(recordList);
    }

    public static ILogs newInstance(Set<Id> recordIdSet) {
        return (ILogs) Commons.Domain.newInstance(recordIdSet);
    }

    public Logs(List<bn2gp__Log__c> sObjectList) {
        super(sObjectList, Schema.bn2gp__Log__c.SObjectType);
    }

    public List<bn2gp__Log__c> getLogs() {
        return (List<bn2gp__Log__c>) getRecords();
    }

    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new Logs((List<SObject>) objectList);
        }
    }
}
