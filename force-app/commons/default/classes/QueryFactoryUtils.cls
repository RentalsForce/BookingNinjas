public with sharing class QueryFactoryUtils {
    public static void appendCondition(fflib_QueryFactory qf, String logic, String condition) {
        String currentCondition = qf.getCondition();
        qf.setCondition(String.isBlank(currentCondition) ? condition : currentCondition + logic + condition);
    }
}
