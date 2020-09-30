package com.wuage.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.wuage.constant.RoleConstatnt;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
    @TableId(value = "role_id", type = IdType.AUTO)
    private Integer roleId;

    /**
     * 角色名称
     */
    @NotBlank
    private String roleName;

    /**
     * 创建者
     */
    private String creater;

    /**
     * 创建时间
     */
    private LocalDateTime ctime;

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
     * 角色状态
     */
    private Integer status;

    /**
     * 角色代码
     */
    private String roleCode;

    /**
     * 角色数据范围
     */
//    @Range(max = 4,min = 0,message = "角色数据权限参数非法！")
    private Integer dataRange;

    /**
     * 角色类型
     */
    private Integer roleType;

    /**
     * 角色绑定的菜单id
     */
    @TableField(exist = false)
    private Integer[] menuIds;


}
