import com.wuage.utils.security.RandomUtils;
import org.junit.Test;

import java.util.Random;

public class OrdinaryTest {

    @Test
   public void randomTest(){

        Random random = new Random();
        for(int i =0;i<20;i++){
            System.out.println(RandomUtils.getSalt(16));
        }
    }

    @Test
    public void stringnull(){
        String s = "    ";
        System.out.println(s.equals(""));
        System.out.println(s == null);
        System.out.println(s.isEmpty());
        System.out.println(s.trim().isEmpty());
    }

}
