package com.wuage.enums;

public enum LogType {

    /**
     * 后台日志
     */
    SYSTEM_LOG(1),

    /**
     *  APP 前台日志
     */
    APP_LOG(2);

    private int typeValue;

    private LogType(int value){
        this.typeValue = value;
    }

    public int getTypeValue(){
        return this.typeValue;
    }

}
