({
	getUserWeather: function(cmp) {
        var action = cmp.get('c.getUserWeather');

        action.setCallback(this, function(res) {
            var state = res.getState();
            var resObj = new Object();

            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();
                console.log('olehdebug >>> rtnValue: ', rtnValue);

                cmp.set('v.weather', res.getReturnValue());
            }
        });

        $A.enqueueAction(action);
	},

    getTime: function(unixTimeStamp) {
        var a = new Date(unixTimeStamp * 1000);
        var hour = a.getHours();
        var min = a.getMinutes();
        if (min < 10) {
            min = '0' + min;
        }
  		var time = hour + ':' + min;

        return time;
    },

    getDate: function(unixTimeStamp) {
        var a = new Date(unixTimeStamp * 1000);
        var date = a.getDate();

        return date;
    },

    getHours: function(unixTimeStamp) {
        var a = new Date(unixTimeStamp * 1000);
        var hours = a.getHours();

        return hours;
    },

    timeConverter: function(unixTimeStamp) {
        var a = new Date(unixTimeStamp * 1000);
        var date = a.getDate();
        var hours = a.getHours();
        var min = a.getMinutes();
  		var time = date + ' ' + hours + ':' + min;

        return time;
    },

    capitalizeFirstLetter: function(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
})