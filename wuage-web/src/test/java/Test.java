import com.wuage.entity.Config;
import com.wuage.entity.Menu;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import java.io.UnsupportedEncodingException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

public class Test {

    @org.junit.Test
    public void localDate() {

        System.out.println(LocalDateTime.now());
    }

    @org.junit.Test
    public void listtoMap() {

        List<Config> list = new ArrayList<>();

//        list.add(new Config().setConfigCode("aa").setConfigValue(2));
//        list.add(new Config().setConfigCode("bb").setConfigValue(56));
//        list.add(new Config().setConfigCode("cc").setConfigValue(6));
//        list.add(new Config().setConfigCode("dd").setConfigValue(198));

        HashMap<String, Integer> map = (HashMap<String, Integer>) list.stream()
                .collect(Collectors.toMap(Config::getConfigCode, Config::getConfigValue));

        System.out.println(map);

    }


    @org.junit.Test
    public void getLocalDateDiff() throws InterruptedException {

//        LocalDateTime now = LocalDateTime.now();
//        Thread.sleep(3000);
//        LocalDateTime current = LocalDateTime.now();
//        System.out.println(Duration.between(current, now).getSeconds());
        Duration duration = Duration.of(4536, ChronoUnit.SECONDS);
        System.out.println(duration.toHours());

    }

    @org.junit.Test
    public void Base64Test() throws UnsupportedEncodingException {

        String base64 = Base64.getEncoder().encodeToString("com.wuage8888888".getBytes("UTF-8"));
        byte[] original = Base64.getDecoder().decode(base64);

        System.out.println(base64);
        System.out.println(new String(original));
    }

    @org.junit.Test
    public void test(){

         int i = 1;
         i = i++;
        int j = i++;
        System.out.println(i);
        System.out.println(j);


        ByteSource bytesalt = new Md5Hash("");
        SimpleHash simpleHash = new SimpleHash("md5", "123456", bytesalt, 2);
        System.out.println(simpleHash.toHex());
//        List<String> list = new ArrayList<String>();
//        list.add("aa");
//        list.add("bb");
//        list.add("cccc");
//        list.add("dd");
//
//        list.remove("c");
//        list.remove("dd");
//        list.forEach(System.out::println);

//        List<Menu> list2 = new ArrayList<Menu>();
//        list2.add(new Menu().setMenuId(1));
//        list2.add(new Menu().setMenuId(2));
//        list2.add(new Menu().setMenuId(3));
//        list2.add(new Menu().setMenuId(4));
//        list2.add(new Menu().setMenuId(5));
//
//        Menu menu = list2.get(0);
//
//        menu.setCreater("aaa");
//
//        System.out.println(list2.get(0));

//        Iterator<String> iterator = list.iterator();
//        Iterator<String> iterator2 = list.iterator();
////        System.out.println(list.size());
//        while(iterator.hasNext()){
//            String temp = iterator.next();
//
//            if(temp.equals("cccc")){
//                iterator.remove();
//               iterator.forEachRemaining(System.out::println);
//            }
//        }


//        list.forEach(System.out::println);
//        System.out.println(list.size());

    }


}
