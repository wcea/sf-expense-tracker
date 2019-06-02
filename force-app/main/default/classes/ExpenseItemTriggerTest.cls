@isTest
public class ExpenseItemTriggerTest {
    @isTest
    public static void whenExpenseItemInsertedReimbursableAmountCorrect() {

      // select consultant into user 
      User user = [
          SELECT Id
          FROM User
          WHERE Profile.Name = 'Consultant'
          LIMIT 1
        ];

      // assert user exists
      System.assert(user != null, 'Consultant exists');

      System.runAs(user) {
        // create a new expense report called expenseReport and insert it
        Expense_Report__c itemJPY100 = new Expense_Report__c(
          Name = 'Test Expense Report'
        );

        // get category with reimbursable percent 1 and store in variable reimbursable100
        Category__c reimbursable100 = [
          SELECT Id
          FROM Category__c
          WHERE Reimbursable_Percentage__c = 100
          LIMIT 1
        ];
        // get category with reimbursable percent .5 and store in variable reimbursable50
        Category__c reimbursable50 = [
          SELECT Id
          FROM Category__c
          WHERE Reimbursable_Percentage__c = 50
          LIMIT 1
        ];

        // instantiate list of expense items to save later
        List<Expense_Item__c> items = new List<Expense_Item__c>();       

        // instantiate a expense item itemJPY100 with currency JPY, category: reimbursable100, amount: 100, date: yesterday
        // Expense_Item__c itemJPY100 = new Expense_Item__c(
        //   Expense_Report__c = expenseReport.Id,
        //   Category__c = reimbursable100.Id,
        //   Description__c = 'JPY 100',
        //   Date__c = System.today() - 1,
        //   Currency__c = 'JPY',
        //   Amount__c = 100
        // );

        // add to list
        // items.add(itemJPY100);

        // instantiate an expense item itemUSD100 with currency USD, category: reimbursable100, amount: 100, date: yesterday
        Expense_Item__c itemUSD100 = new Expense_Item__c(
          // Expense_Report__c = expenseReport.Id,
          Category__c = reimbursable100.Id,
          Description__c = 'USD 100',
          Date__c = System.today() - 1,
          Currency__c = 'USD',
          Amount__c = 100
        );
        // add to list
        items.add(itemUSD100);

        // instantiate an expense item itemJPY50 with currency JPY, category: reimbursable50, amount:100, date: day before yesterday
        Expense_Item__c itemJPY50 = new Expense_Item__c(
          // Expense_Report__c = expenseReport.Id,
          Category__c = reimbursable50.Id,
          Description__c = 'JPY 50',
          Date__c = System.today() - 2,
          Currency__c = 'JPY',
          Amount__c = 100
        );
        // add to list
        items.add(itemJPY50);

        // instantiate an expense item itemUSD50 with currency USD, category: reimbursable50, amount: 100, date: day before yesterday
        Expense_Item__c itemUSD50 = new Expense_Item__c(
          // Expense_Report__c = expenseReport.Id,
          Category__c = reimbursable50.Id,
          Description__c = 'USD 50',
          Date__c = System.today() - 2,
          Currency__c = 'USD',
          Amount__c = 100
        );
        // add to list
        items.add(itemUSD50);

        Test.startTest();
          // insert items
          insert items;
        Test.stopTest();

        // select saved items and data to assert into a map for easy fetching by id
        Map<Id, Expense_Item__c> savedItems = new Map<Id, Expense_Item__c>([
          SELECT Id, Exchange_Rate__c, Reimbursable_Amount__c
          FROM Expense_Item__c
        ]);

        // TODO update test when fx rates are captured
        // get itemJPY100 by Id from the map
        // assert exchange rate is 0
        // System.assertEquals(0, savedItems.get(itemJPY100.Id).Exchange_Rate__c, 'Assert exchange rate is 0');
        // assert reimbursable amount is 0
        System.assertEquals(0, savedItems.get(itemJPY100.Id).Reimbursable_Amount__c, 'Reimbursable amount is 0');
 
        // get itemUSD100 by Id from the map
        // assert exchange rate is 1
        // System.assertEquals(1, savedItems.get(itemUSD100.Id).Exchange_Rate__c, 'Assert exchange rate is 1');
        // assert reimbursable amount is 100
        System.assertEquals(100, savedItems.get(itemUSD100.Id).Reimbursable_Amount__c, 'Reimbursable amount is 100');
 
        // TODO update test when fx rates are captured
        // get itemJPY50 by Id from the map
        // assert exchange rate is 0
        // System.assertEquals(0, savedItems.get(itemJPY50.Id).Exchange_Rate__c, 'Assert exchange rate is 0');
        // assert reimbursable amount is 0
        System.assertEquals(0, savedItems.get(itemJPY50.Id).Reimbursable_Amount__c, 'Reimbursable amount is 0');

        // get itemUSD50 by Id from the map
        // assert exchange rate is 1
        // System.assertEquals(1, savedItems.get(itemUSD50.Id).Exchange_Rate__c, 'Assert exchange rate is 1');
        // assert reimbursable amount is 50
        System.assertEquals(50, savedItems.get(itemUSD50.Id).Reimbursable_Amount__c, 'Reimbursable amount is 50');

      }
    }

    @isTest
    public static void whenExpenseItemUpdatedReimbursableAmountCorrect() {

      // create test to verify when saved expense item is updated to USD from JPY, exchange rate changes from 0 to 1 
      // create test to verify when saved expense item is updated to JPY from USD, exchange rate changes from 1 to 0
      // run as Consultant
     
    }

    @testSetup
    static void makeData() {
        List<Category__c> categories = new List<Category__c>();

        // categories.add(
        //     new Category__c(
        //         Name = 'Gasoline',
        //         Reimbursable_Percentage__c = 100
        //     )
        // );
        // categories.add(
        //     new Category__c(
        //         Name = 'Meals',
        //         Reimbursable_Percentage__c = 50
        //     )
        // );
    
    insert categories;
      
      // setup test 2 categories for each test
      // 100% and 50% reimbursable
      // practice bulkification
      // add categories to list
      // save list

    }
}