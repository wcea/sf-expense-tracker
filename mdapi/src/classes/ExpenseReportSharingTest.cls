@isTest
private class ExpenseReportSharingTest {

    @isTest
  static void whenProfileIsFinanceCanGetAllExpenseReports() {

    Expense_Report__c anothers = new Expense_Report__c(
      Name = 'Show me their money',
      Amount__c = 100
    );
    insert anothers;

    User user = [SELECT Id
                FROM User
                WHERE Profile.Name = 'Finance'
                LIMIT 1];
    System.assert(user != null, 'User Exists');

    System.runAs(user) {
      Expense_Report__c mine = new Expense_Report__c(
        Name = 'Show me my money',
        Amount__c = 500
      );
      insert mine;

      Test.startTest();
      List<Expense_Report__c> saved = [
        SELECT Id
        FROM Expense_Report__c
      ];
      Test.stopTest();

      System.assertEquals(2, saved.size(), 'can see all the money');
 
    }
  }

  @isTest
  static void whenProfileIsConsultantCanOnlyGetOwnedExpenseReports() {

    Expense_Report__c anothers = new Expense_Report__c(
      Name = 'Show me the money',
      Amount__c = 100
    );
    insert anothers;

    User user = [SELECT Id
                FROM User
                WHERE Profile.Name = 'Consultant'
                LIMIT 1];
    System.assert(user != null, 'User Exists');

    System.runAs(user) {
      Expense_Report__c mine = new Expense_Report__c(
        Name = 'Show me my money',
        Amount__c = 500
      );
      insert mine;

      Test.startTest();
      List<Expense_Report__c> saved = [
        SELECT Id
        FROM Expense_Report__c
      ];
      Test.stopTest();

      System.assertEquals(1, saved.size(), 'can see all the money');
   
    }
  }
}