package com.wuage.utils.security;

import java.util.Objects;
import java.util.Random;

/**
 * 生成随机数的类
 */
public class RandomUtils {

    private static final String SAMPLE = "123abcd8efg90hij6kln78mopq7rstuvws5yz4";

    /**
     * 获取相应位数的随机盐值
     *
     * @param num
     * @return
     */
    public static String getSalt(int num) {

        Objects.requireNonNull(num);
        if (num < 0) {
            throw new IllegalArgumentException("num argument not right!");
        }
        StringBuilder stringBuilder = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < num; i++) {

            stringBuilder.append(SAMPLE.charAt(random.nextInt(SAMPLE.length()-1)));
        }
        return stringBuilder.toString();
    }
}
