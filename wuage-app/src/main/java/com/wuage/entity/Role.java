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
 * 系统角色
 * </p>
 *
 * @author binblink
 * @since 2020-07-09
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_role")
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 角色id
     */
    @TableId(value = "ROLE_ID", type = IdType.AUTO)
    private Integer roleId;

    /**
     * 角色名称
     */
    @TableField("ROLE_NAME")
    private String roleName;

    /**
     * 创建者
     */
    @TableField("CREATER")
    private String creater;

    /**
     * 更新者
     */
    @TableField("UPDATE_BY")
    private String updateBy;

    /**
     * 备注
     */
    @TableField("REMARK")
    private String remark;

    /**
     * 角色状态
     */
    @TableField("STATUS")
    private Integer status;

    /**
     * 角色代码
     */
    @TableField("ROLE_CODE")
    private String roleCode;

    /**
     * 角色数据范围
     */
    @TableField("DATA_RANGE")
    private Integer dataRange;

    /**
     * 角色类型
     */
    @TableField("ROLE_TYPE")
    private Integer roleType;

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


    /**
     * 角色绑定的菜单id
     */
    @TableField(exist = false)
    private Integer[] menuIds;


}
