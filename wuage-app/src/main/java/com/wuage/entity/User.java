package com.wuage.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;


/**
 * <p>
 * 系统用户
 * </p>
 *
 * @author binblink
 * @since 2019-12-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId(value = "USER_ID", type = IdType.AUTO)
    private Integer userId;

    /**
     * 登录名
     */
    @TableField("LOGIN_NAME")
    private String loginName;

    /**
     * 密码
     */
    @TableField("PASSWORD")
    private String password;

    /**
     * 昵称
     */
    @TableField("USERNAME")
    private String username;

    /**
     * 头像
     */
    @TableField("AVATAR")
    private String avatar;

    /**
     * 性别 1男 2女 3不确定
     */
    @TableField("SEX")
    private Integer sex;

    /**
     * 电话
     */
    @TableField("PHONE")
    private String phone;

    /**
     * 上次登录时间
     */
    @TableField("LAST_LOGIN_TIME")
    private LocalDateTime lastLoginTime;

    /**
     * 锁定状态 0 未锁定 1 管理员锁定 2 输错密码锁定
     */
    @TableField("LOCKED")
    private Integer locked;

    /**
     * 加密盐值
     */
    @TableField("SALT")
    private String salt;

    /**
     * 部门id
     */
    @TableField("DEPT_ID")
    private Integer deptId;

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
     * 锁定时间
     */
    @TableField("LOCK_TIME")
    private LocalDateTime lockTime;

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

    @TableField(exist = false)
    private List<Integer> roles;

}
