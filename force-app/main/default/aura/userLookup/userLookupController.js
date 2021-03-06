({
	searchRecords: function(cmp, evt, helper) {
        if (!$A.util.isEmpty(cmp.get('v.searchString'))) {
		    helper.searchRecordsHelper(cmp, '');
        } else {
            $A.util.removeClass(cmp.find('resultsDiv'), 'slds-is-open');
        }
	},

	selectUser: function(cmp, evt, helper) {
        if (!$A.util.isEmpty(evt.currentTarget.id)) {
    		var usersList = cmp.get('v.usersList');
            var index = usersList.findIndex(x => x.userId === evt.currentTarget.id)
            var selectedUser;
            if (index != -1) {
                selectedUser = usersList[index];
            }
            cmp.set('v.selectedUserId', selectedUser.userId);
            cmp.set('v.selectedUserName', selectedUser.userName);
            $A.util.removeClass(cmp.find('resultsDiv'), 'slds-is-open');
        }
	},

	removeUser: function(cmp, evt, helper) {
        cmp.set('v.selectedUserId', '');
        cmp.set('v.selectedUserName', '');
        cmp.set('v.searchString', '');
        setTimeout(function() {
            cmp.find('inputLookup').focus();
        }, 250);
    },

    onBlur: function(cmp, event, helper ){
    	$A.util.removeClass(cmp.find('resultsDiv'), 'slds-is-open');
    }
})