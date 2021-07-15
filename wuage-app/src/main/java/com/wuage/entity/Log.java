package com.wuage.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
    @TableId(value = "LOG_ID", type = IdType.AUTO)
    private Integer logId;

    /**
     * 操作来类型 1登录日志 2 操作日志
     */
    @TableField("OPERATOR_TYPE")
    private Integer operatorType;

    /**
     * 操作结果 json 数据
     */
    @TableField("RESULT")
    private String result;

    /**
     * ip
     */
    @TableField("IP")
    private Long ip;

    /**
     * 请求url
     */
    @TableField("URL")
    private String url;

    /**
     * 操作描述
     */
    @TableField("DESCRIPTION")
    private String description;

    /**
     * 请求参数
     */
    @TableField("PARAM")
    private String param;

    /**
     * 操作人
     */
    @TableField("OPERATOR_NAME")
    private String operatorName;

    /**
     * 错误信息
     */
    @TableField("ERROR_MSG")
    private String errorMsg;

    /**
     * 日志标题
     */
    @TableField("LOG_TITLE")
    private String logTitle;

    /**
     * 操作人id
     */
    @TableField("OPERATOR_ID")
    private Integer operatorId;

    /**
     * 结果类型 0 成功 1 失败
     */
    @TableField("RESULT_TYPE")
    private Integer resultType;

    /**
     * 花费时间
     */
    @TableField("COST_TIME")
    private String costTime;

    /**
     * 更新时间
     */
    @TableField("MODIFY_TIME")
    private LocalDateTime modifyTime;

    /**
     * 时间戳
     */
    @TableField("TS")
    private LocalDateTime ts;
}
