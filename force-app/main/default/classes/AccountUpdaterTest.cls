@IsTest
private class AccountUpdaterTest {
    
    @TestSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>();
        
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Tech Account ' + i, Industry = 'Technology'));
        }
        
        for (Integer i = 0; i < 3; i++) {
            testAccounts.add(new Account(Name = 'Retail Account ' + i, Industry = 'Retail'));
        }
        
        insert testAccounts;
    }
    
    @IsTest
    static void testUpdateAccountsByIndustry() {
        Test.startTest();
        AccountUpdater.updateAccountsByIndustry('Technology', 'Updated by test');
        Test.stopTest();
        
        List<Account> updatedAccounts = [SELECT Id, Description FROM Account WHERE Industry = 'Technology'];
        for (Account acc : updatedAccounts) {
            System.assertEquals('Updated by test', acc.Description, 'The description should match the updated value.');
        }
        
        List<Account> unchangedAccounts = [SELECT Id, Description FROM Account WHERE Industry = 'Retail'];
        for (Account acc : unchangedAccounts) {
            System.assertNotEquals('Updated by test', acc.Description, 'Retail accounts must remain unchanged.');
        }
    }
}