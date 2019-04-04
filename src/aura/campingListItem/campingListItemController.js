({
    doInit: function(cmp, ev, h) {

    },
    
	packItem: function(cmp, ev, h) {
        cmp.set('v.packed', true);
        ev.getSource().set('v.disabled', cmp.get('v.packed'));
	}
})