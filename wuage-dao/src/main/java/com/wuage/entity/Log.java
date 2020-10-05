package com.wuage.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.wuage.enums.LogType;
import com.wuage.utils.IpUtils;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 系统日志
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_log")
public class Log implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 日志di
     */
    @TableId(value = "log_id", type = IdType.AUTO)
    private Integer logId;

    /**
     * 操作来类型 1登录日志 2 操作日志
     */
    private Integer operatorType;

    /**
     * 操作结果 json 数据
     */
    private String result;

    /**
     * ip
     */
    private Long ip;

    /**
     * 操作时间
     */
    private LocalDateTime logTime;

    /**
     * 请求url
     */
    private String url;

    /**
     * 操作描述
     */
    private String description;

    /**
     * 请求参数
     */
    private String param;

    /**
     * 操作人
     */
    private String operatorName;



    /**
     * 错误信息
     */
    private String errorMsg;

    /**
     * 日志标题
     */
    private String logTitle;

    /**
     * 操作人id
     */
    private Integer operatorId;

    /**
     * 花费时间
     */
    private String costTime;

    /**
     * 结果类型 0 成功 1 失败
     */
    private Integer resultType;

    public static Log getLoginLog(HttpServletRequest request){
        Log log = new Log();
        log.setOperatorType(1);
        log.setIp(IpUtils.ipToLong(IpUtils.getIpAddr(request)));

        return log;
    }

}
