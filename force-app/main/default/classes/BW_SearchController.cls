public without sharing class BW_SearchController {
    
    @AuraEnabled
    public static Boolean isUserExists(String browserId) {

		List<BW_User__c> query = [SELECT Id, Name FROM BW_User__c WHERE browserId__c = :browserId LIMIT 1];
        
        return !query.isEmpty();
    }
    
    @AuraEnabled
    public static Boolean newUser(String browserId, String value) {
        ID userId;
        
        try {
		    BW_User__c user = new BW_User__c(browserId__c = browserId);
            
            insert user;
            
            userId = user.ID;
            
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        BW_User_History__c searchVal = new BW_User_History__c(searchValue__c = value, user__c = userId);
        Database.SaveResult saveResults = database.insert(searchVal, false);
        
        return saveResults.isSuccess();
    }

    @AuraEnabled
    public static Boolean updateUser(String browserId, String value) {
        BW_User__c user = [SELECT Id, Name FROM BW_User__c WHERE browserId__c = :browserId LIMIT 1];
        
        BW_User_History__c searchVal = new BW_User_History__c(searchValue__c = value, user__c = user.Id);
        Database.SaveResult saveResults = database.insert(searchVal, false);
        
        return saveResults.isSuccess();
    }
    
    @AuraEnabled
    public static List<String> getHistory(String browserId) {
        List<String> userHistory = new List<String>();
        BW_User__c user = [SELECT Id, Name FROM BW_User__c WHERE browserId__c = :browserId LIMIT 1];
        List<BW_User_History__c> query = [SELECT Id, Name, searchValue__c FROM BW_User_History__c WHERE user__c = :user.id LIMIT 10];
        
        for (BW_User_History__c item : query) {
            String searchValue = String.valueOf(item.searchValue__c);
            userHistory.add(searchValue);
        }
        
        
        
        return userHistory;
    }
    
    @AuraEnabled
    public static Map<String, Object> getBluewolfWeather(String address) {
        Map<String, Object> resultMap = new Map<String, Object>();
        Map<String, Object> tmpVar = getCoordinates(address);
        Map<String, Object> darkSkyMap = darkSkyReq(tmpVar);

		// GETTING WEATHER NOW        
        tmpVar = (Map<String, Object>) darkSkyMap.get('currently');
        Map<String, Object> weatherNow = getValues(tmpVar);
        resultMap.put('now', weatherNow);
        
        // GETTING ARRAY FOR WEATHER TODAY
        tmpVar = (Map<String, Object>) darkSkyMap.get('hourly');
        List<Object> weatherToday = (List<Object>) tmpVar.get('data');
        weatherToday.remove(0); // coz its current one
        List<Map<String, Object>> tmpList = new List<Map<String, Object>>();

        for (Object s : weatherToday) {
            tmpList.add((Map<String, Object>) s);
        }
        
        for (Map<String, Object> m : tmpList) {
            System.debug('olehdebug >>> time: ' + m.get('time'));
        }
		// I FINISHED THERE 
		// IF YOU SAW I WOULD LOVE TO TRANSFER OUR FORMATED JSON LOGIC TO THERE

       
        resultMap.put('today', weatherToday);
        
        return resultMap;
    } // 
    
    @AuraEnabled
    public static Map<String, Object> getWeather(String address){
        Map<String, Object> coordinates = getCoordinates(address);
        Map<String, Object> resultMap = darkSkyReq(coordinates);
        
        return resultMap;
    } // getWeather

    public static Map<String, Object> getCoordinates(String address) {
        Map<String, Object> resultMap = new Map<String, Object>();
        String apiKey = 'WlDs7kdcXx4H4fFjbrThBmBCv90nWnnt';

        Http h = new Http();
        HttpRequest req = new HttpRequest();

        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('http://www.mapquestapi.com/geocoding/v1/address?key=' + apiKey + '&maxResults=1&location=' + address);
        req.setMethod('GET');
        req.setTimeout(60000);

        try {
            HttpResponse res = h.send(req);

            if (res.getStatusCode() == 200) {

                JSONParser parser = JSON.createParser(res.getBody());
                while (parser.nextToken() != null) {

                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getCurrentName() == 'latLng')) {

                        parser.nextToken();

                        while(parser.nextToken() != JSONToken.END_OBJECT) {

                            if ((parser.getCurrentName() == 'lat' || parser.getCurrentName() == 'lng')
                                    && (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_FLOAT)) {

                                resultMap.put(parser.getCurrentName(), parser.getDoubleValue());
                            }
                        }
                    }

                }
            }

        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error MI_WeatherController getCoordinates - ' + e.getMessage());
        } // try

        return resultMap;
    } // getLatLng
    
    public static Map<String, Object> getCoordinatesOld(String address) {
        Map<String, Object> resultMap = new Map<String, Object>();
        String apiKey = 'AIzaSyA2YgW3GrUEPTUpL0fye0RzkACtytSqaL4';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&key=' + apiKey);
        req.setMethod('GET');
        req.setTimeout(60000);
        
        try {
            HttpResponse res = h.send(req);
            
            if (res.getStatusCode() == 200) {
    
                JSONParser parser = JSON.createParser(res.getBody());
                while (parser.nextToken() != null) {
                    
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getCurrentName() == 'location')) {
                        
                        parser.nextToken();
                        
                        while(parser.nextToken() != JSONToken.END_OBJECT) {
                            
                            if ((parser.getCurrentName() == 'lat' || parser.getCurrentName() == 'lng') && (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_FLOAT)) {
                                
                                resultMap.put(parser.getCurrentName(), parser.getDoubleValue());
                            } // if
                        } // while
                    } // if
                    
                } // while
            } // if 200
            
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error Google Geocoding Address - ' + e.getMessage());
        } // try
        
        return resultMap;
    } // getLatLng
    
    private static Map<String, Object> darkSkyReq(Map<String, Object> coordinates) {
        Map<String, Object> resultMap = new Map<String, Object>();
        String apiKey = 'cf81a5a5b4b031b6ab153debcbd0c74e';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://api.darksky.net/forecast/'+ apiKey +'/'+ coordinates.get('lat') +','+ coordinates.get('lng'));
        req.setMethod('GET');
        req.setTimeout(60000);
        
        try {
            HttpResponse res = h.send(req);
            
            if (res.getStatusCode() == 200) {
                
                resultMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            } // if 200
            
        } catch(exception e) {
            System.debug(LoggingLevel.ERROR, 'Error Parsing Dark Sky Weather API: ' + e.getMessage());
        } // try
        
        return resultMap;
    } //darkSkyReq
    
    
    private static Map<String, Object> getValues(Map<String, Object> values) {
     	Map<String, Object> rtnValue = New Map<String, Object>();
        String ICON = 'icon'; String SUMMARY = 'summary'; String ITIME = 'time';
        String TEMPERATURE = 'temperatureCelsius';
        
        rtnValue.put(ICON, values.get(ICON));
        rtnValue.put(SUMMARY, values.get(SUMMARY));
        Integer ourTime = integer.valueof(values.get(ITIME));
        rtnValue.put(ITIME, preprocessTime(ourTime));
        Double fariengheit = Double.valueOf(values.get('temperature'));
        Double celsius = Math.roundToLong((fariengheit - 32) * 5/9);
        rtnValue.put(TEMPERATURE, celsius);
        
        return rtnValue;
    }
    
    private static String preprocessTime(Integer unixTimeStamp) {

        DateTime dateInstance = datetime.newInstanceGmt(1970, 1, 1, 0, 0, 0);
        String rtnVal = dateInstance.addSeconds(unixTimeStamp).format();
        
        return rtnVal;
    }
    
}