package com.wuage.Result;

public class ApiResult {
	/**
     * 结果码
     */
    private String code;

    /**
     * 结果码描述
     */
    private String msg;
    
    
    private Object data;


    public Object getData() {
		return data;
	}

	public ApiResult setData(Object data) {
		this.data = data;
		return this;
	}

	public ApiResult() {

    }
	
	public ApiResult(String code,String msg){
		this.code = code;
		this.msg = msg;
	}

	public static ApiResult success(){
        return new ApiResult("0","success");
    }

    public static ApiResult fail(String msg){
        return new ApiResult("1",msg);
    }

    public static ApiResult error(String msg){
        return new ApiResult("-1",msg);
    }

    public static ApiResult noPermission(String msg){
        return new ApiResult("-2",msg);
    }

    public ApiResult(ResultCode resultCode) {
        this.code = resultCode.getCode();
        this.msg = resultCode.getMsg();
    }
    
    public ApiResult(ResultCode resultCode,Object data) {
        this.code = resultCode.getCode();
        this.msg = resultCode.getMsg();
        this.data = data;
    }

    /**
     * 生成一个ApiResult对象, 并返回
     *
     * @param resultCode
     * @return
     */
    public static ApiResult of(ResultCode resultCode) {
        return new ApiResult(resultCode);
    }

    public String getCode() {
        return code;
    }

    public ApiResult setCode(String code) {
        this.code = code;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public ApiResult setMsg(String msg) {
        this.msg = msg;
        return this;
    }

}
