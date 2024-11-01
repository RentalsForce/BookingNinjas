@isTest
public with sharing class QueryFactoryUtilsTest {
    @isTest
    public static void testAppendCondition() {
        fflib_QueryFactory qf = new fflib_QueryFactory(Contact.SObjectType);
        qf.selectField('name');
        qf.selectField('email');

        String whereClause = 'name = \'test\' AND email = \'test@test\'';

        Test.startTest();
        QueryFactoryUtils.appendCondition(qf, ' AND ', 'name = \'test\'');
        QueryFactoryUtils.appendCondition(qf, ' AND ', 'email = \'test@test\'');
        Test.stopTest();

        System.assertEquals(whereClause, qf.getCondition());
        String query = qf.toSOQL();
        System.assert(
            query.endsWith('WHERE ' + whereClause),
            'Query should have ended with a filter on name and email, got: ' + query
        );
    }
}
