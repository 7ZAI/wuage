package com.wuage.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 系统参数表
 * </p>
 *
 * @author binblink
 * @since 2021-07-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_config")
public class Config implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 参数id
     */
    @TableId(value = "CONF_ID", type = IdType.AUTO)
    private Integer confId;

    /**
     * 参数代码
     */
    @TableField("CONF_CODE")
    private String confCode;

    /**
     * 参数名称
     */
    @TableField("CONF_NAME")
    private String confName;

    /**
     * 参数值
     */
    @TableField("CONF_VALUE")
    private Integer confValue;

    /**
     * 修改时间
     */
    @TableField("MODIFY_TIME")
    private LocalDateTime modifyTime;

    /**
     * 时间戳
     */
    @TableField("TS")
    private LocalDateTime ts;


}
