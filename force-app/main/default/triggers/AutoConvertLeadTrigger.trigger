trigger AutoConvertLeadTrigger on Lead (after insert, after update) {
    AutoConvertLeadHandler handler = new AutoConvertLeadHandler();
    handler.autoConvertLeads(Trigger.new);
}

