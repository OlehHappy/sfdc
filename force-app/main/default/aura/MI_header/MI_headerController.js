/**
 * Created by leon on 29.10.18.
 */
({
    onInit: function (cmp, evt, helper) {
        var initAction = cmp.get('c.getUserAccount');

        initAction.setCallback(this, function(res) {
           var state = res.getState();
           if (state === 'SUCCESS') {
               cmp.set('v.account', res.getReturnValue());
           }
        });

        $A.enqueueAction(initAction);
    }
})