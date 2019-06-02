public abstract class TriggerHandler {

    private abstract void beforeInsert(List<Expense_Item__c> itemList);

    private abstract void beforeUpdate(List<Expense_Item__c> itemList);

    private abstract void beforeDelete(List<Expense_Item__c> itemList);

    private abstract void afterInsert(List<Expense_Item__c> itemList);

    private abstract void afterUpdate(List<Expense_Item__c> itemList);

    private abstract void afterDelete(List<Expense_Item__c> itemList);

    public void execute() {

        if (Trigger.isBefore) {
            if(Trigger.isInsert) {
                beforeInsert(trigger.New);
            } else if(Trigger.isUpdate) {
                beforeUpdate(trigger.New);
            } else if (Trigger.isDelete) {
                beforeDelete(trigger.New);
            } 
        } else if (Trigger.isAfter) {
             if(Trigger.isInsert) {
                afterInsert(trigger.New);
            } else if(Trigger.isUpdate) {
                afterUpdate(trigger.New);
            } else if (Trigger.isDelete) {
                afterDelete(trigger.New);
            } 
        }
    }
}