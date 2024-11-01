public class Commons {
    // Configure and create the UnitOfWorkFactory for this Commons
    public static final fflib_Application.UnitOfWorkFactory UnitOfWork = new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType>{ bn2gp__Log__c.SObjectType }
    );

    // Configure and create the ServiceFactory for this Commons
    public static final fflib_Application.ServiceFactory Service = new fflib_Application.ServiceFactory(
        new Map<Type, Type>{ ILogsService.class => LogsServiceImpl.class }
    );

    // Configure and create the SelectorFactory for this Commons
    public static final fflib_Application.SelectorFactory Selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type>{ bn2gp__Log__c.SObjectType => LogsSelector.class }
    );

    // Configure and create the DomainFactory for this Commons
    public static final fflib_Application.DomainFactory Domain = new fflib_Application.DomainFactory(
        Commons.Selector,
        new Map<SObjectType, Type>{ bn2gp__Log__c.SObjectType => Logs.Constructor.class }
    );
}
