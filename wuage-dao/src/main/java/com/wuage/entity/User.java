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
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

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
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    /**
     * 登录名
     */
    @NotBlank(message = "登录名不能为空！")
    @Length(min=1, max=30,message = "登录名长度应在1~30个字符之间！")
    private String loginName;

    /**
     * 密码
     */

//    @Pattern(regexp = "(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#$%^&*()]{6,20}$",message = "密码格式不正确！")
    private String password;

    /**
     * 昵称
     */
    @NotBlank(message = "登录名不能为空！")
    @Length(min=1, max=30,message = "登录名长度应在1~30个字符之间！")
    private String username;

    /**
     * 头像
     */

    private String avatar;

    /**
     * 性别 1男 2女 3不确定
     */
    private Integer sex;

//    /**
//     * 邮箱
//     */
//    @Email(message = "邮箱格式不正确！")
//    @Length(max = 50,message = "邮箱长度不能超过50个字符")
//    private String email;


    /**
     * 电话
     */
    private String phone;

    /**
     * 创建时间
     */
    private LocalDateTime ctime;

    /**
     * 上次登录时间
     */
    private LocalDateTime lastLoginTime;

    /**
     * 锁定状态 0 未锁定 1 管理员锁定 2 输错密码锁定
     */
    private Integer locked;

    /**
     * 加密盐值
     */
    private String salt;

    /**
     * 部门id
     */
    private Integer deptId;


    @TableField(exist=false)
    private String deptName;

    /**
     * 创建者
     */
    private String creater;

    /**
     * 更新者
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 备注
     */
    private String remark;

    /**
     * 锁定时间
     */
    private LocalDateTime lockTime;

    @TableField(exist = false)
    private List<Integer> roles;

}
