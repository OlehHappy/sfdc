({
	doInit: function(cmp, evt, helper) {
		helper.getList(cmp, 0);
	},

	onCheckboxClick: function(cmp, evt, helper) {
		var checkboxEl = evt.getSource();
		var isChecked = checkboxEl.get('v.checked');
		var projectId = checkboxEl.get('v.label');
		var selectedIds = cmp.get('v.selectedIds');
		
		if (isChecked) {
			selectedIds.push(projectId);
		}

		if (!isChecked) {
			var indexNum = selectedIds.indexOf(projectId);
			selectedIds.splice(indexNum, 1);
		}

		cmp.set('v.selectedIds', selectedIds);
	},

	assignForUser: function(cmp, evt, helper) {
		var selectedIds = cmp.get('v.selectedIds');
		console.log('olehdebug >>> selectedIds: ', selectedIds);
		helper.changeOwner(cmp);
	}
})