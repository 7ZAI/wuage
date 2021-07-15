package com.wuage.constant;


public class RoleConstatnt {

    public static final String SUPER_ADMIN = "SUPER_ADMIN";

    /**
     * 角色类型 1为超级管理员 0为普通管理员 默认为0
     */
    public static final Integer SUPER_ADMIN_INT = 1;

    public static final Integer NORMAL_ADMIN_INT = 0;

    public static final Integer SUPER_ADMIN_ID = 1;

    /**
     * 角色状态 启用1
     */
    public static final Integer ROLE_STATUS_ACTIVE = 1;

    /**
     * 角色状态 禁用0
     */
    public static final Integer ROLE_STATUS_FORBIDDEN = 0;


    /**
     * 角色数据范围类型
     *  仅本人数据 值0
        仅本部门范围 值1,
        部门所属单位及以下数据 值2,
        自定义 值3,
        全部数据 值4,
     */
    public static final Integer ROLE_DATARANGE_PERSONAL = 0;

    public static final Integer ROLE_DATARANGE_DEPARTMENT_ONLY = 1;

    public static final Integer ROLE_DATARANGE_DEPARTMENT_ALL = 2;

    public static final Integer ROLE_DATARANGE_CUSTOM = 3;

    public static final Integer ROLE_DATARANGE_ALL = 4;



}
