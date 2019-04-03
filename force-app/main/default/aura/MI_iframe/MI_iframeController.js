/**
 * Created by leon on 31.10.18.
 */
({
    doInit: function (cmp, evt, helper) {
        var userInfoAction = cmp.get('c.getUserInfo');

        userInfoAction.setCallback(this, function(res) {
            var state = res.getState();
            if (state === 'SUCCESS') {
                cmp.set('v.user', res.getReturnValue());
            }
        });

        $A.enqueueAction(userInfoAction);
    }
})