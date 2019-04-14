({
    doInit: function(cmp, e, h) {
        cmp.set('v.browserId', h.getBrowserId());
        
        h.isUserExists(cmp).then($A.getCallback(function resolve(exists) {
            cmp.set('v.hasHistory', exists);
            
            if (exists) {
                
                h.retrieveHistory(cmp);
            }

        						   }), 
                                    $A.getCallback(function reject(reason) { console.log(reason) })
                                   );
        
    },
    
    onItemClick: function(cmp, e, h) {
        var value = e.target.name;
        
        cmp.set('v.value', value);
        h.doSearch(cmp);
    },
    
	onKeyPress: function(cmp, e, h) {
        
        if (e.getParams().keyCode === 13) {
            //h.doSearchNew(cmp);
            var hasHistory = cmp.get('v.hasHistory');
            var value = cmp.get('v.value');
            var browserId = cmp.get('v.browserId');
            
            if (hasHistory 
                && !$A.util.isEmpty(value)
                && !$A.util.isEmpty(browserId)) {
                
            	h.doSearch(cmp);
                h.updateSearchHistory(cmp);
                h.retrieveHistory(cmp);
            } 
            
            if (!hasHistory 
                && !$A.util.isEmpty(value)
                && !$A.util.isEmpty(browserId)) {
                
                h.doSearch(cmp);
                h.createUser(cmp);
            }
            
        }
		
	},
    
    onClick: function(cmp, e, h) {
        //h.doSearchNew(cmp);
        var hasHistory = cmp.get('v.hasHistory');
        var value = cmp.get('v.value');
        var browserId = cmp.get('v.browserId');
        
        if (hasHistory 
            && !$A.util.isEmpty(value)
            && !$A.util.isEmpty(browserId)) {
            
            h.doSearch(cmp);    
            h.updateSearchHistory(cmp);
            h.retrieveHistory(cmp);
        } 
        
        if (!hasHistory 
            && !$A.util.isEmpty(value)
            && !$A.util.isEmpty(browserId)) {
            
            h.doSearch(cmp);
            h.createUser(cmp);
        }
    }
})