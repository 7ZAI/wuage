package com.wuage.annotation;

import com.wuage.enums.LogType;
import com.wuage.enums.OperateType;

import java.lang.annotation.*;

/**
 * 日志注解 用来标记需要进行日志记录的方法
 */

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogInfo {


    String title() default "";

    LogType logType() default LogType.SYSTEM_LOG;

    OperateType operateType() default OperateType.NORMAL;

}
