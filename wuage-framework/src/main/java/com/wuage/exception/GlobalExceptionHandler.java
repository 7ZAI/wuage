package com.wuage.exception;

import com.wuage.Result.ApiResult;
import com.wuage.constant.UserConstant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);


    /**
     * 参数校验异常
     */
    @ExceptionHandler(BindException.class)
    public ApiResult validatedBindException(BindException e)
    {
        logger.error(e.getMessage());
        String message = e.getAllErrors().get(0).getDefaultMessage();
        logger.error(message);
        return ApiResult.error("参数异常");
    }



    /**
     * 用户登录认证异常
     * @param e
     * @return
     */
    @ExceptionHandler(AuthenticationException.class)
    public ApiResult authenticationException(AuthenticationException e){

        logger.error(e.getMessage());
        String message = e.getMessage();
        clearSession();
        return ApiResult.error(message);
    }

    /**
     * 无权限异常
     * @param e
     * @return
     */
    @ExceptionHandler(AuthorizationException.class)
    public ApiResult authorizationException(AuthorizationException e){

        logger.error(e.getMessage());
        String message = e.getMessage();

        return ApiResult.noPermission("无权限");
    }

    /**
     * 未知异常 请联系管理员
     */
    @ExceptionHandler(Exception.class)
    public ApiResult unkownException(Exception e)
    {
        logger.error(e.getMessage(), e);
        e.printStackTrace();
        return ApiResult.error("未知异常 请联系管理员");
    }

    /**
     * 登录认证失败时 清除session中的user信息
     */
    private void clearSession(){
        SecurityUtils.getSubject().getSession().removeAttribute(UserConstant.SYSUSER_SESSION_KEY);
    }
}
