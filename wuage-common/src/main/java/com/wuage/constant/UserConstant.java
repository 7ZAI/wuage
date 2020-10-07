package com.wuage.constant;

/**
 * 用户状态常数
 */
public class UserConstant {

    /**
     * session 中验证码的key
     */
    public final static String CAPTCHA_KEY = "captcha";

    public final static String SYSUSER_SESSION_KEY = "systemUser";

    public final static String SUPER_ADMIN = "admin";
    /**
     * 用户正常状态
     */
    public final static Integer USER_NORMAL = 0;

    /**
     * 用户被管理员封禁状态
     */
    public final static Integer USER_DISABLE_BY_ADMIN = 1;

    /**
     * 用户输入密码错误被系统封禁
     */
    public final static Integer USER_DISABLE_BY_ERROR_PASSWORD = 2;


    public final static Integer USER_SEX_MAN = 1;

    public final static Integer USER_SEX_women = 0;



}
