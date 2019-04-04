({
	getList: function(cmp, offSetVal) {
		var action = cmp.get('c.getProjectsList');

        action.setParams({
            offSetVal: offSetVal
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                console.log('olehdebug >>> res: ', response.getReturnValue());
                cmp.set('v.projects', response.getReturnValue());
            } else if (state === 'ERROR') {
                //TODO: error handling
            }
        });
        
        $A.enqueueAction(action);
    },
    
    changeOwner: function(cmp) {
        var action = cmp.get('c.changeProjectsOwner');

        action.setParams({
            projectIds: cmp.get('v.selectedIds')
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                //console.log('olehdebug >>> res: ', response.getReturnValue());

            } else if (state === 'ERROR') {
                //TODO: error handling
            }
        });
        
        $A.enqueueAction(action);
    }
})