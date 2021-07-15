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
    @TableId(value = "DEPT_ID", type = IdType.AUTO)
    private Integer deptId;

    /**
     * 部门名称
     */
    @TableField("DEPT_NAME")
    private String deptName;

    /**
     * 父部门id
     */
    @TableField("DEPT_PARENT_ID")
    private Integer deptParentId;

    /**
     * 部门领导
     */
    @TableField("LEADER")
    private String leader;

    /**
     * 部门电话
     */
    @TableField("PHONE")
    private String phone;

    /**
     * 创建者
     */
    @TableField("CREATER")
    private String creater;

    /**
     * 更新人
     */
    @TableField("UPDATE_BY")
    private String updateBy;

    /**
     * 备注
     */
    @TableField("REMARK")
    private String remark;

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
