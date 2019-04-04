public without sharing class BW_TestClass {
    

    
    @AuraEnabled
    public static Map<String, Object> getWeather(String address){
        Map<String, Object> coordinates = getCoordinates(address);
        Map<String, Object> resultMap = darkSkyReq(coordinates);
        
        return resultMap;
    } // getWeather
    
    public static Map<String, Object> getCoordinates(String address) {
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
            
        } catch(exception e) {
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
    
}