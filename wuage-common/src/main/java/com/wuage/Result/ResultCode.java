package com.wuage.Result;

public enum ResultCode {
	/**
     * 成功 0
     */
    SUCCESS("0", "success"),

    FAIL("1","fail"),

    /**
     * 未知错误
     */
    UNKNOWN_ERROR("0x10001", "未知错误"),

    /**
     * 用户名错误或不存在
     */
    USERNAME_ERROR("0x10002", "用户名错误或不存在"),
    
    /**
     * 已存在该用户名
     */
    USERNAME_IS_EXITS("0x100011", "已存在该用户名"),
    /**
     * 密码错误
     */
    PASSWORD_ERROR("0x10003", "密码错误"),

    /**
     * 用户名不能为空
     */
    USERNAME_EMPTY("0x10004", "用户名不能为空"),
	
    /**
     * 参数为空
     */
	PARAMETER_EMPTY("0X10005","参数不能为空或缺失必要参数"),

    /**
     * 非法参数
     */
    ILLEGAL_PARAMETER("0X10030","非法参数"),
	/**
	 * 验证码错误
	 */
	CODE_NOT_RIGHT("0X10011","验证码错误！"),
	
	/**
	 * 余额不足
	 */
	MONEY_NO_ENOUGH("0X10007","余额不足"),
	
	/**
	 * 未激活
	 */
	NOT_ACTIVE("0X10006","用户未激活 "),
	
	/**
     * 该用户已被锁定
     */
    USER_LOCKED("0x10021", "该用户已被锁定"),
	
	/**
	 * 登陆拦截
	 */
	NOT_LOGIN("0X10020","登陆过期或者未登陆！ 请重新登陆"),

    /**
     * 同一用户同时登陆被被踢出
     */
    USER_KICKOUT("0X10701","您已在别处登录，请您修改密码或重新登录"),
	
	/**
	 * 功能关闭
	 */
	FUNCTION_FORBIDDEN("0X10015","系统维护中，暂时关闭登录功能！");
	
	
	
    /**
     * 结果码
     */
    private String code;

    /**
     * 结果码描述
     */
    private String msg;


    ResultCode(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

}
