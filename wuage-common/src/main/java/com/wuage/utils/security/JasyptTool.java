package com.wuage.utils.security;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

/**
 * 配置文件加密工具
 *
 * 获取加密后的密码 加到配置文件中
 * 再用vm 参数   -Djasypt.encryptor.password=xxx 指定解密秘钥
 */
public class JasyptTool {

    public static void main(String[] args) {

        StandardPBEStringEncryptor se = new StandardPBEStringEncryptor();

        se.setPassword("123456");

        System.out.println(se.encrypt("123456"));
    }

}
