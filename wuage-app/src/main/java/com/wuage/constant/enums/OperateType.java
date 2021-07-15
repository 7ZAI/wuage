package com.wuage.constant.enums;

public enum OperateType {

    /**
     * 登入日志
     */
    LOGIN(1),

    /**
     * 常规日志
     */
    NORMAL(2);

    private int typeValue;

    private OperateType(int value){
        this.typeValue = value;
    }

    public int getTypeValue(){
        return this.typeValue;
    }
}
