package com.wuage.utils.security;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import java.security.Key;
import java.security.SecureRandom;

public class AESUtils {

    // optional value AES/DES/DESede
    public static String DES = "AES";
    // optional value AES/DES/DESede
    public static String CIPHER_ALGORITHM = "AES";

    public static Key getKey(String strKey) {
        try {
            if (strKey == null) {
                strKey = "";
            }
            KeyGenerator generator = KeyGenerator.getInstance("AES");
            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
            secureRandom.setSeed(strKey.getBytes());
            generator.init(128, secureRandom);
            return generator.generateKey();
        } catch (Exception e) {
            throw new RuntimeException(" 密钥出现异常 ");
        }
    }

    public static String encrypt(String data, String key) throws Exception {
        SecureRandom sr = new SecureRandom();
        Key secureKey = getKey(key);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secureKey, sr);
        byte[] bt = cipher.doFinal(data.getBytes());
        String strS = new BASE64Encoder().encode(bt);
        return strS;
    }


    public static String decrypt(String message, String key) throws Exception {
        SecureRandom sr = new SecureRandom();
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        Key secureKey = getKey(key);
        cipher.init(Cipher.DECRYPT_MODE, secureKey, sr);
        byte[] res = new BASE64Decoder().decodeBuffer(message);
        res = cipher.doFinal(res);
        return new String(res);
    }

    public static void main(String[] args) {
        String msg = "asdasd";
        System.out.println(getKey(msg).getFormat());
    }
}
