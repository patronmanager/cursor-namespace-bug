@IsTest
private class Test_MyObjectTrigger {
	@IsTest
	static void testNoNamespace() {
		insertAndAssert('No Namespace');
	}

	@IsTest
	static void testWithNamespace() {
		insertAndAssert('Add Namespace');
	}

	@IsTest
	static void testSynchronous(){
		String soql = 'SELECT Name, MyField__c FROM MyObject__c';
		Database.Cursor c = Database.getCursor(soql);
		Assert.areEqual(0,c.getNumRecords());
	}

	private static void insertAndAssert(String name){
		insert new MyObject__c(Name=name);

		List<MyObject__c> objList = [SELECT Id, Name FROM MyObject__c];

		Assert.areEqual(1,objList.size());
		Assert.areEqual('In trigger',objList[0].Name);

	}

}