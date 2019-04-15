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
	
	onSelectAll: function(cmp, evt, helper) {

	},

	assignForUser: function(cmp, evt, helper) {
		if ($A.util.isEmpty(cmp.get('v.selectedIds'))) {
			helper.showToast('Unsuccess!', 'error', 'Please choose the at least one record before.');
		} else {
			$A.createComponent('c:assignProjectToUser',{
				onClose: cmp.getReference('c.handleCloseModal'), 
				onSave: cmp.getReference('c.handleSaveModal'), 
				userId: cmp.getReference('v.selectedUserId')
			}, function(assignProjectToUser, status, errorMessage){
				if (status === 'SUCCESS') {
					var modal = cmp.get('v.modal');
					modal.push(assignProjectToUser);
	
					cmp.set('v.modal', modal);
				}
			});
		}
	},

	handleSaveModal: function(cmp, evt, helper) {
		console.log('olehdebug >>> handleSaveModal: ', cmp.get('v.selectedUserId'));
		if ($A.util.isEmpty(cmp.get('v.selectedUserId'))) {
			helper.showToast('Unsuccess!', 'error', 'Please choose User to assign.');
		} else {
			var modal = cmp.get('v.modal');
			modal.shift();
	
			cmp.set('v.modal', modal);
			helper.changeOwner(cmp);
		}
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