trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.New.size();

        EmailManager.sendMail('onlyhappyspam@hotmail.com', 'Trigger Tutorial', recordCount + ' contact(s) were inserted.');
    } else if (Trigger.isDelete) {
        // process after delete
    }
}