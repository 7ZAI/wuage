package com.wuage.shiro.token;

import org.apache.shiro.authc.UsernamePasswordToken;

public class UsernamePasswordCaptchaToken extends UsernamePasswordToken {

    // 序列化ID
    private static final long serialVersionUID = -2804050723838289739L;

    // 验证码
    private String captchaCode;

    /**
     * 构造函数
     * 用户名和密码是登录必须的,因此构造函数中包含两个字段
     */
    public UsernamePasswordCaptchaToken(String username, String password, String captchaCode) {
        // 父类UsernamePasswordToken的构造函数,后两个参数暂不需要, 不设置
        super(username, password, false, "");
        this.captchaCode = captchaCode;
    }

    /**
     * 获取验证码
     */
    public String getCaptchaCode() {
        return captchaCode;
    }
}
