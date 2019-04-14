({
    isUserExists: function(cmp) {
        
        return new Promise(function(resolve, reject) {
            var action = cmp.get('c.isUserExists');
            
            action.setParams({
                browserId: cmp.get('v.browserId')
            });
            
            action.setCallback(this, function(res) {
                var state = res.getState();
                
                if (state === "SUCCESS") {
                    var rtnValue = res.getReturnValue();
                    resolve(rtnValue);
                } else {
                    reject(res);
                }
            });
            
            $A.enqueueAction(action);
        });
    },
    
    createUser: function(cmp) {
        var action = cmp.get('c.newUser');
        
        action.setParams({
            browserId: cmp.get('v.browserId'),
            value: cmp.get('v.value')
        });
        
        action.setCallback(this, function(res) {
            var state = res.getState();
            
            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();
                cmp.set('v.hasHistory', rtnValue);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    updateSearchHistory: function(cmp) {
        var action = cmp.get('c.updateUser');
        
        action.setParams({
            browserId: cmp.get('v.browserId'),
            value: cmp.get('v.value')
        });
        
        action.setCallback(this, function(res) {
            var state = res.getState();
            
            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();
                cmp.set('v.hasHistory', rtnValue);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    retrieveHistory: function(cmp) {
        var action = cmp.get('c.getHistory');
        var browserId = cmp.get('v.browserId');
        
        action.setParams({
            browserId: browserId
        });
        
        action.setCallback(this, function(res) {
            var state = res.getState();

            
            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();
                console.log('olegdebug >>> retrieveHistory: ', rtnValue);
                cmp.set('v.searchHistory', rtnValue);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    doSearchNew: function(cmp) {
        var action = cmp.get('c.getBluewolfWeather');
        
        action.setParams({
            address: cmp.get('v.value')
        });
        
        action.setCallback(this, function(res) {
            var state = res.getState();

            
            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();

              
            }
        });
        
        $A.enqueueAction(action);
	},
    
	doSearch: function(cmp) {
        $A.util.toggleClass(cmp.find('spinner'), 'slds-hide');
        var action = cmp.get('c.getWeather');
        
        action.setParams({
            address: cmp.get('v.value')
        });
        
        action.setCallback(this, function(res) {
            var state = res.getState();
            var resObj = new Object();
            
            if (state === "SUCCESS") {
                var rtnValue = res.getReturnValue();
                
                resObj.timezone = rtnValue.timezone;
                
                resObj.now = new Object();
                resObj.now.icon = rtnValue.currently.icon;
                resObj.now.temperatureCelsius = Math.round((rtnValue.currently.temperature - 32) * 5/9);
                resObj.now.time = this.getTime(rtnValue.currently.time);
                resObj.now.summary = rtnValue.currently.summary;
                
                var curDate = this.getDate(rtnValue.currently.time);
                var curHours = this.getHours(rtnValue.currently.time);
                resObj.today = new Array();
                resObj.night = new Array();
                resObj.tomorrow = new Object();
                resObj.tomorrow.morning = new Array();
                resObj.tomorrow.daytime = new Array();
                resObj.tomorrow.evening = new Array();
                
                for (var i = 0; i < rtnValue.hourly.data.length; i++) {
                
                    var date = this.getDate(rtnValue.hourly.data[i].time);
                    var hours = this.getHours(rtnValue.hourly.data[i].time);
                    
                    if (date == curDate && hours != curHours && hours < 21) {
                        var obj = {};
                        
                        obj.time = this.getTime(rtnValue.hourly.data[i].time);
                        obj.icon = rtnValue.hourly.data[i].icon;
                        obj.summary = rtnValue.hourly.data[i].summary;
                        obj.temperatureCelsius = Math.round((rtnValue.hourly.data[i].temperature - 32) * 5/9);
                    
                        resObj.today.push(obj);
                    }
                    
                    if ((date == curDate && hours >= 21) || (date == (curDate + 1) && hours <= 5)) {
                        var obj = {};
                        
                        obj.time = this.getTime(rtnValue.hourly.data[i].time);
                        obj.icon = rtnValue.hourly.data[i].icon;
                        obj.summary = rtnValue.hourly.data[i].summary;
                        obj.temperatureCelsius = Math.round((rtnValue.hourly.data[i].temperature - 32) * 5/9);
                    
                        resObj.night.push(obj);
                    }
                    
                    if (date == (curDate + 1)) {
                        
                        if (hours < 11 && hours > 5) {
                            var obj = {};
                            
                            obj.time = this.getTime(rtnValue.hourly.data[i].time);
                            obj.icon = rtnValue.hourly.data[i].icon;
                            obj.summary = rtnValue.hourly.data[i].summary;
                            obj.temperatureCelsius = Math.round((rtnValue.hourly.data[i].temperature - 32) * 5/9);
                            
                            resObj.tomorrow.morning.push(obj);
                        } else if (hours >= 11 && hours < 16) {
                            var obj = {};
                            
                            obj.time = this.getTime(rtnValue.hourly.data[i].time);
                            obj.icon = rtnValue.hourly.data[i].icon;
                            obj.summary = rtnValue.hourly.data[i].summary;
                            obj.temperatureCelsius = Math.round((rtnValue.hourly.data[i].temperature - 32) * 5/9);
                            
                            resObj.tomorrow.daytime.push(obj);
                        } else if (hours >= 16 && hours < 21) {
                            var obj = {};
                            
                            obj.time = this.getTime(rtnValue.hourly.data[i].time);
                            obj.icon = rtnValue.hourly.data[i].icon;
                            obj.summary = rtnValue.hourly.data[i].summary;
                            obj.temperatureCelsius = Math.round((rtnValue.hourly.data[i].temperature - 32) * 5/9);
                            
                            resObj.tomorrow.evening.push(obj);
                        }
                    }
                                        
                }
                
                
                cmp.set('v.weather', resObj);
                $A.util.removeClass(cmp.find('weather'), 'slds-hide');
                $A.util.removeClass(cmp.find('time'), 'slds-hide');
                $A.util.toggleClass(cmp.find('spinner'), 'slds-hide');
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
    
    getBrowserId: function() {
        var cname = 'BrowserId' + "=";
        var cookieArr = document.cookie.split(';');
        
        for (var i = 0; i < cookieArr.length; i++) {
            
            if (cookieArr[i].indexOf(cname) == 1) {
                var id = cookieArr[i].trim();
                
                return id.substring(cname.length);
            } 
        }
    },
    
    capitalizeFirstLetter: function(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
}
})