/**
 * Created by leon on 22.9.18.
 */

public class EinsteinGetMood {
    public static final String EINSTEIN_EMAIL = 'oleh.daybov@ibm.com';
    public static final String VISION_API = 'https://api.einstein.ai/v2/language';
    public static final String SENTIMENT_COMMUNITY = 'CommunitySentiment';

    public void getProbabilities(String txt) {
        String access_token = getAccessTokenNew();
        System.debug('olehdebug >>> ACCESS_TOKEN: ' + ACCESS_TOKEN);
        HttpRequest req = new HttpRequest();

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('modelId', SENTIMENT_COMMUNITY);
        gen.writeStringField('document', txt);
        gen.writeEndObject();

        String jsonString = gen.getAsString();

        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + access_token);
        req.setHeader('Cache-Control', 'no-cache');
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(VISION_API + '/sentiment');
        req.setTimeout(120000);
        req.setBody(jsonString);

        Http http = new Http();
        if (!Test.isRunningTest()) {
            try {
                HTTPResponse res = http.send(req);
                if (res.getStatusCode() == 200) {
                    System.JSONParser parser = System.JSON.createParser(res.getBody());
                    while (parser.nextToken() != null) {
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)
                            && (parser.getText() == 'probabilities')) {

                            parser.nextToken();

                            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {

                                while (parser.nextToken() != null) {
                                    // Advance to the start object marker to
                                    //  find next probability object.
                                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                                        // Read entire probability object
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
            } catch (System.CalloutException e) {
                System.debug('ERROR:' + e);
            }
        }

    }

    public String getAccessTokenNew() {
        ContentVersion base64Content;

        try {
            base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform' LIMIT 1];
        } catch (Exception e) {
            System.debug('Error during EinsteinVisionController.getAccessTokenNew: ' + e.getMessage());
            throw new AuraHandledException('Cannot create Einstein Vision token: einstein_platform.pem file not found');
        }

        String keyContents = base64Content.VersionData.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');

        // Get a new token
        JWT jwt = new JWT('RS256');
        jwt.pkcs8 = keyContents; // Comment this if you are using jwt.cert
        jwt.iss = 'developer.force.com';
        jwt.sub = EINSTEIN_EMAIL;
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token;

        if (!Test.isRunningTest()) {
            access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);
        }

        return access_token;
    }
}