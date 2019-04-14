({
    doInit: function(cmp, e, h) {
        var action = cmp.get('c.init');
        
        action.setCallback(this, function(res) {
            var state = res.getState();
            console.log('olehdebug >>> state: ', state);
            if (state === 'SUCCESS') {
                var record = res.getReturnValue(); 
                console.log('olehdebug >>>> record: ', record);
				cmp.set('v.record', record);
                cmp.set('v.recordPrimary', record);
            } 
            
        });
        
        $A.enqueueAction(action);
        
    },
    
    onButton: function(cmp, e, h) {
        console.log('olehdebug >>> record: ', cmp.get('v.record'));
        console.log('olehdebug >>> recordPrimary: ', cmp.get('v.recordPrimary'));
    },
    
    onRecordChange: function(cmp, e, h) {
        console.log('olehdebug >>> onRecordChange: ', cmp.get('v.record'));
    }

})