public class AnimalLocator {

	public static String getAnimalNameById(Integer num) {
		String result;

		Http http = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + num);
		req.setMethod('GET');
		HttpResponse res = http.send(req);

		if (res.getStatusCode() == 200) {
			Map<String, Object> obj = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
			Map<String, Object> animal = (Map<String, Object>) obj.get('animal');

			result = String.valueOf(animal.get('name'));
		}

		return result;
	}
}