trigger MyObjectTrigger on MyObject__c (after insert) {
	//Assuming only one record since this is a repro case
	MyObject__c updatedRecord = Trigger.new[0];

	String soql;
	if(updatedRecord.Name == 'Add Namespace'){
		soql = 'SELECT Name, PatronTicket__MyField__c FROM PatronTicket__MyObject__c';
	}
	else{
		soql = 'SELECT Name, MyField__c FROM MyObject__c';
	}

	Database.Cursor c = Database.getCursor(soql);
	//Gack if SOQL doesn't contain namespaces
	System.debug(c.getNumRecords());

	List<MyObject__c> myObjList = c.fetch(0,1);
	for(MyObject__c o : myObjList){
		o.Name = 'In trigger';
	}

	update myObjList;
}