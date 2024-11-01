public without sharing class LogsService {
    public static Map<String, Object> create(List<LogWrapper> logsData) {
        return service().create(logsData);
    }

    private static ILogsService service() {
        return (ILogsService) Commons.Service.newInstance(ILogsService.class);
    }
}
