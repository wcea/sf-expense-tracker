public class ExpenseItemTriggerHandler extends TriggerHandler {
    public static void AssignExchangeRate(List < Expense_Item__c > expenseItemList) {
        List < Expense_Item__c > itemsToUpdate = new List < Expense_Item__c > ();
        for (Expense_Item__c expenseItem: expenseItemList) {
            if (expenseItem.Currency__c == 'USD') {
                expenseItem.Exchange_Rate__c = 1;
            } else {
                expenseItem.Exchange_Rate__c = 0;
            }
            itemsToUpdate.add(expenseItem);
        }
    }

    public static void CalculateReimbursableAmount(List < Expense_Item__c > itemList) {
        List < Expense_Item__c > listToUpdate = new List < Expense_Item__c > ();
        Map < Id, Expense_Category__c > categories = new Map < Id, Expense_Category__c > ([
            SELECT Id, Reimbursable_Percentage__c
            FROM Expense_Category__c
        ]);
        for (Expense_Item__c expenseItem: itemList) {
            expenseItem.Reimbursable_amount__c = expenseItem.Exchange_Rate__c * itemObj.Amount__c * (categories.get(expenseItem.Expense_Category__c).Reimbursable_Percentage__c / 100);
            listToUpdate.add(expenseItem);
        }
        categories.get(expenseItem.Reimbursable_amount__c);
    }


    private void beforeInsert(List < Expense_Item__c > itemList) {
        AssignExchangeRate(itemList);
        CalculateReimbursableAmount(itemList);
    }

    private void beforeUpdate(List < Expense_Item__c > itemList) {
        AssignExchangeRate(itemList);
        CalculateReimbursableAmount(itemList);
    }

    private void beforeDelete(List < Expense_Item__c > itemList) {
        //Not much going on here... 
    }

    private void afterInsert(List < Expense_Item__c > itemList) {
        //Not much going on here...
    }

    private void afterUpdate(List < Expense_Item__c > itemList) {
        //Not much going on here...
    }

    private void afterDelete(List < Expense_Item__c > itemList) {
        //Not much going on here...
    }
}