package com.wuage.exception.customize;

import org.apache.shiro.authc.AuthenticationException;

public class CaptchaException extends AuthenticationException {

    public CaptchaException(String message) {
        super(message);
    }
}
