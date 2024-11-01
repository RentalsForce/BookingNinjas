public without sharing class BNUtils {
    public static Decimal sampleError(String param) {
        try {
            return 10 / 0;
        } catch (Exception e) {
            // Save log
            LogWrapper log = new LogWrapper();
            log.description = e.getMessage();
            log.details = 'Error details:\n' + e.getStackTraceString() + '\n\n' + 'Parameters:\n' + stringify(param);
            log.logId = Logs.Level.ERROR.name() + '-' + Datetime.now().getTime();
            log.level = Logs.Level.ERROR;
            log.type = Logs.Type.APPLICATION;
            log.feature = Logs.Feature.PROPERTY_MANAGEMENT;
            log.service = 'bnutils sample error'; // specify something here
            LogController.create(new List<LogWrapper>{ log });
        }
        return 0.0;
    }

    public static String stringify(Object value) {
        try {
            return JSON.serialize(value, false);
        } catch (Exception error) {
            return '' + value;
        }
    }

    public static Map<String, Object> responseCreator(List<String> keys, List<Object> values) {
        Map<String, Object> response = new Map<String, Object>();

        for (Integer i = 0; i < keys.size(); i++) {
            response.put(keys[i], values[i]);
        }

        return response;
    }
}
