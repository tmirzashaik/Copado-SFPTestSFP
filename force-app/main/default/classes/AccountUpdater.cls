public with sharing class AccountUpdater {
    public static void updateAccountsByIndustry(String industryName, String newDescription) {
        List<Account> accountsToUpdate = [
            SELECT Id, Description 
            FROM Account 
            WHERE Industry = :industryName 
            LIMIT 200
        ];
        
        for (Account acc : accountsToUpdate) {
            acc.Description = newDescription;
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}