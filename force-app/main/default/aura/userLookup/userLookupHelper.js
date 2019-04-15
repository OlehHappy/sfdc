({
	searchRecordsHelper: function(cmp, value) {
		$A.util.removeClass(cmp.find('spinner'), 'slds-hide');
        // component.set('v.message', '');
        // component.set('v.recordsList', null);
    	var action = cmp.get('c.getUsersByName');
        action.setStorable();
        action.setParams({
            searchString: component.get('v.searchString')
        });
        action.setCallback(this, function(response){
        	if(response.getState() === 'SUCCESS') {
                var result = response.getReturnValue();
    			if(result.length > 0) {
                    cmp.set('v.usersList', result);        
    			} else {
    				cmp.set('v.errorMessage', 'No Records Found');
    			}
        	} else if(response.getState() === 'INCOMPLETE') {
                cmp.set('v.errorMessage', 'No Server Response or client is offline');
            } else if(response.getState() === 'ERROR') {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    cmp.set('v.errorMessage', errors[0].message);
                }
            }
            // if( $A.util.isEmpty(value) )
            $A.util.addClass(cmp.find('resultsDiv'), 'slds-is-open');
        	$A.util.addClass(cmp.find('spinner'), 'slds-hide');
        });
        $A.enqueueAction(action);
	}
})