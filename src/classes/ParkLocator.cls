/**
 * Created by leon on 1.10.18.
 */

public class ParkLocator {

    public static String[] country(String countryString) {
        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();

        return parks.byCountry(countryString);
    }
}