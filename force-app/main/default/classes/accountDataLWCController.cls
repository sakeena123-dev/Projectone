public with sharing class accountDataLWCController {
     @AuraEnabled(cacheable=true)
public static List<Account> AccountMethod()
{
    return[select Name,AccountNumber,Phone from account];
}
}