public with sharing class MI_WeatherController {
    private static final String ICON = 'icon';
    private static final String NOW_STR = 'now';
    private static final String TODAY_STR = 'today';
    private static final String SUMMARY = 'summary';
    private static final String ITIME = 'time';
    private static final String TEMPERATURE = 'temperatureCelsius';

    @AuraEnabled
    public static Map<String, Object> getUserWeather() {
        User currentUser = [SELECT City, Country FROM User WHERE Id = :UserInfo.getUserId()];
        Map<String, Object> resultMap = new Map<String, Object>();
        Map<String, Object> coordinates = getCoordinates(currentUser.City + ', ' + currentUser.Country);
        Map<String, Object> darkSkyMap = darkSkyReq(coordinates);

        // GETTING WEATHER NOW
        Map<String, Object> currentMap = (Map<String, Object>) darkSkyMap.get('currently');
        resultMap.put(NOW_STR, getValuesMap(currentMap));

        // GETTING ARRAY FOR WEATHER TODAY
        Map <String, Object> weatherByHour = (Map<String, Object>) darkSkyMap.get('hourly');
        List<Object> weatherToday = (List<Object>) weatherByHour.get('data');
//        weatherToday.remove(0); // coz its current one

        List<Map<String, Object>> weatherList = new List<Map<String, Object>>();
        for (Object s : weatherToday) {
//            System.debug('olehdebug >>> s: ' + s);
            weatherList.add((Map<String, Object>) s);
        }

        List<Map<String, Object>> todayList = new List<Map<String, Object>>();
        Datetime today = Datetime.now();
        for (Map<String, Object> m : weatherList) {
            Datetime calendarDatetime = Datetime.newInstanceGmt(1970, 1, 1, 0, 0, 0);
            calendarDatetime = calendarDatetime.addSeconds(Integer.valueOf(m.get(ITIME)));

            if (today.day() == calendarDatetime.day() && today.year() == calendarDatetime.year()) {
                todayList.add(getValuesMap(m));
            }
        }

        resultMap.put(TODAY_STR, todayList);

        return resultMap;
    } //

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

    public static Map<String, Object> darkSkyReq(Map<String, Object> coordinates) {
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

    private static Map<String, Object> getValuesMap(Map<String, Object> values) {
        Map<String, Object> rtnValue = New Map<String, Object>();

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
        String resultString;
        DateTime dateInstance = Datetime.newInstanceGmt(1970, 1, 1, 0, 0, 0);
        dateInstance = dateInstance.addSeconds(unixTimeStamp);
        resultString = String.valueOf(dateInstance.hour());
        if (Integer.valueOf(dateInstance.minute()) == 0) {
            resultString += ' : 00';
        } else {
            resultString += ' : ' + String.valueOf(dateInstance.minute());
        }

        return resultString;
    }
}