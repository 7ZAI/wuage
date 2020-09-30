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

import javax.validation.constraints.NotNull;

/**
 * <p>
 * 部门
 * </p>
 *
 * @author binblink
 * @since 2020-06-15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_dept")
public class Dept  implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 部门id
     */
    @TableId(value = "dept_id", type = IdType.AUTO)
    private Integer deptId;

    /**
     * 部门名称
     */
    @NotNull
    @Length(min=1, max=20,message = "菜单名称长度应在1~20个字符之间！")
    private String deptName;

    /**
     * 父部门id
     */
    private Integer deptParentId;

    /**
     * 部门领导
     */
    @NotNull
    private String leader;

    /**
     * 部门电话
     */
    @NotNull
    private String phone;

    /**
     * 创建时间
     */
    private LocalDateTime ctime;

    /**
     * 创建者
     */
    private String creater;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 备注
     */
    private String remark;


    @TableField(exist =  false)
    private List<Dept> children;

    @TableField(exist = false)
    private String parentName;

    /**
     * 在处理树形数据时作为 遍历过的标记位 默认未遍历
     */
    @TableField(exist = false)
    private boolean traversalOrNot ;


}
