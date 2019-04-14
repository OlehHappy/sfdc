({
	getList: function(cmp) {
        var action = cmp.get('c.getProjectsList');
        var offSetVal = cmp.get('v.pageNumber') * 20;

        console.log('olehdebug >>> offSetVal: ', offSetVal);
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