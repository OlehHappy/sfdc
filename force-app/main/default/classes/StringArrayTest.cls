public class StringArrayTest {
    
    
    public static String[] generateStringArray(Integer n) {
        String[] result = new List<String>();
        
        for(Integer i = 0; i < n; i++) {
            result.add('Test ' + i);
        }
        System.debug('>>>>>> ' + result);
        return result;
    }
}