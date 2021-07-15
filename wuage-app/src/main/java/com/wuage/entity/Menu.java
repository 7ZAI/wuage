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
    @TableId(value = "MENU_ID", type = IdType.AUTO)
    private Integer menuId;

    /**
     * 菜单名称
     */
    @TableField("MENU_NAME")
    private String menuName;

    /**
     * 菜单类型
     */
    @TableField("TYPE")
    private Integer type;

    /**
     * 菜单图标
     */
    @TableField("ICON")
    private String icon;

    /**
     * 菜单地址
     */
    @TableField("URL")
    private String url;

    /**
     * 排序序号
     */
    @TableField("ORDER_NUMBER")
    private Integer orderNumber;

    /**
     * 状态
     */
    @TableField("STATUS")
    private Integer status;

    /**
     * 父菜单id
     */
    @TableField("PARENT_ID")
    private Integer parentId;

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
     * 权限字符串
     */
    @TableField("PERMISSION")
    private String permission;

    /**
     * 组件路径
     */
    @TableField("COMPONENT_PATH")
    private String componentPath;

    /**
     * 是否有子菜单（按钮不算）
     */
    @TableField("HASCHILDREN")
    private Boolean haschildren;

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

    public Boolean getHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(Boolean hasChildren) {
        this.hasChildren = hasChildren;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public boolean isTraversalOrNot() {
        return traversalOrNot;
    }

    public void setTraversalOrNot(boolean traversalOrNot) {
        this.traversalOrNot = traversalOrNot;
    }
}
