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
                cmp.set('v.projects', response.getReturnValue());
            } else if (state === 'ERROR') {
                //TODO: error handling
            }
        });
        
        $A.enqueueAction(action);
    },
    
    changeOwner: function(cmp) {
        this.toggleSpinner(cmp);
        var action = cmp.get('c.changeProjectsOwner');
        var offSetVal = cmp.get('v.pageNumber') * 20;

        action.setParams({
            projectIds: cmp.get('v.selectedIds'), 
            userId: cmp.get('v.selectedUserId'), 
            offSetVal: offSetVal
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                cmp.set('v.projects', response.getReturnValue());
            } else if (state === 'ERROR') {
                //TODO: error handling
            }
            this.toggleSpinner(cmp);
        });
        
        $A.enqueueAction(action);
    }, 

    showToast: function(tittle, type, msg) {
        var toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            title: tittle,
            type: type, 
            message: msg
        });
        toastEvent.fire();
    }, 

    toggleSpinner: function(cmp) {
        var spinner = cmp.find('spinner');
        $A.util.toggleClass(spinner, 'slds-hide');
    }
})