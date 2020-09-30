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
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * <p>
 * 系统菜单
 * </p>
 *
 * @author binblink
 * @since 2019-12-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_menu")
public class Menu  implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 菜单id
     */
    @TableId(value = "menu_id", type = IdType.AUTO)
    private Integer menuId;

    /**
     * 菜单名称
     */
    @NotBlank
    @Length(min=1, max=20,message = "菜单名称长度应在1~20个字符之间！")
    private String menuName;

    /**
     * 菜单类型 目录1 菜单2 按钮3
     */
    @Range(max = 3,min = 1,message = "菜单类型参数非法")
    private Integer type;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * 菜单地址
     */
    private String url;

    /**
     * 排序序号
     */
    @NotNull
    private Integer orderNumber;

    /**
     * 状态 0 禁用 1 启用
     */
    @NotNull
    @Range(max = 1,min = 0,message = "参数非法")
    private Integer status;

    /**
     * 父菜单id
     */
    @NotNull
    private Integer parentId;

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
     * 权限字符串
     */
    private String permission;

    /**
     * 组件路径
     */
    private String componentPath;

    /**
     * 是否有子节点
     */
    @TableField("hasChildren")
    private Boolean hasChildren;

    @TableField(exist = false)
    private String parentName;

    @TableField(exist =  false)
    private List<Menu> children;

    /**
     * 在处理树形数据时作为 遍历过的标记位 默认未遍历
     */
    @TableField(exist = false)
    private boolean traversalOrNot ;


}
