package com.wuage.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.wuage.constant.Result.ApiResult;
import com.wuage.entity.Role;
import com.wuage.entity.Vo.PageInfo;


import java.util.List;

/**
 * <p>
 * 系统角色 服务类
 * </p>
 *
 * @author binblink
 * @since 2020-07-09
 */
public interface RoleService extends IService<Role> {

    ApiResult getRoles(PageInfo pageInfo) throws Exception;

    Integer roleNameIsExit(String roleName) throws Exception;

    ApiResult getMenusRelation(Integer roleId) throws Exception;

    ApiResult addRole(Role role) throws Exception;

    ApiResult deleteRole(Integer roleId) throws Exception;

    ApiResult deleteRoleBatch(List<Integer> roleIds) throws Exception;

    ApiResult updateRole(Role role) throws Exception;

    ApiResult updateRoleStatus(Role role) throws Exception;

    ApiResult updateDataRange(JSONObject json) throws Exception;

    ApiResult getMenuPermissions() throws Exception;

    ApiResult getSelectedDepts(Integer roleId) throws Exception;

    ApiResult getDepartmentTree() throws Exception;
}
