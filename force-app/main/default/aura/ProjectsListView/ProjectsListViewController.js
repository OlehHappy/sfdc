({
	doInit: function(cmp, evt, helper) {
		helper.getList(cmp);
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
		// helper.changeOwner(cmp);
		$A.createComponent('c:assignProjectToUser',{
			closeComponent: cmp.getReference('c.handleCloseModal')
		}, function(assignProjectToUser, status, errorMessage){
			if (status === 'SUCCESS') {
				var modal = cmp.get('v.modal');
				modal.push(assignProjectToUser);

				cmp.set('v.modal', modal);
			}
		});
	},

	handleCloseModal: function(cmp, evt, helper) {
		var modal = cmp.get('v.modal');
		modal.shift();

		cmp.set('v.modal', modal);
	},

	navigateToUser: function(cmp, evt, helper) {
		var userId = evt.getSource().get('v.name');
		var navEvt = $A.get('e.force:navigateToSObject');

		navEvt.setParams({
			recordId: userId
		});

		navEvt.fire();
	},

	gotToPrevius: function (cmp, evt, helper) {
		var pageNumber = cmp.get('v.pageNumber');
		cmp.set('v.pageNumber', pageNumber - 1);

		helper.getList(cmp);
	},

	gotToNext: function (cmp, evt, helper) {
		var pageNumber = cmp.get('v.pageNumber');
		cmp.set('v.pageNumber', pageNumber + 1);

		helper.getList(cmp);
	}
})