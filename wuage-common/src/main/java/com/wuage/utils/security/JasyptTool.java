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

//        se.setPassword("");
//
//        String postgres = se.encrypt("");
//
//        System.out.println(postgres);
//
//        System.out.println(se.decrypt("c2e61e36f19e1b10284e77afb885df4d"));
    }

}
