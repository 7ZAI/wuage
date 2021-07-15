package com.wuage.controller;


import com.alibaba.fastjson.JSONObject;

import com.wuage.constant.Result.ApiResult;
import com.wuage.framework.annotation.LogInfo;
import com.wuage.framework.annotation.RepeatSubmit;
import com.wuage.framework.component.RolePermissionCacheManager;

import com.wuage.entity.Role;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.service.DeptService;
import com.wuage.service.RoleService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.*;

@RestController
@Validated
@RequestMapping("/system")
public class SysRoleController extends BaseController {

    private RoleService roleService;

    private DeptService deptService;

    private RolePermissionCacheManager rolePermissionCacheManager;

    @Autowired
    public SysRoleController(RoleService roleService,
                              DeptService deptService, RolePermissionCacheManager rolePermissionCacheManager) {

        this.roleService = roleService;
        this.deptService = deptService;
        this.rolePermissionCacheManager = rolePermissionCacheManager;
    }

    /**
     * 角色列表
     *
     * @param pageInfo
     * @return
     * @throws Exception
     */
    @RequiresPermissions("system:role:view")
    @GetMapping("/role")
    public ApiResult getRoles(PageInfo pageInfo) throws Exception {
        return roleService.getRoles(pageInfo);
    }

    /**
     * 获取 权限树
     *
     * @return
     * @throws Exception
     */
    @GetMapping("/role/menus")
    @RequiresPermissions({"system:role:add", "system:role:update"})
    public ApiResult getMenuPermissions() throws Exception {
        return roleService.getMenuPermissions();
    }

    /**
     * 已有权限 回显勾选
     *
     * @param roleId
     * @return
     * @throws Exception
     */
    @GetMapping("/role/menusSelected")
    @RequiresPermissions({"system:role:update"})
    public ApiResult getMenuSelected(@NotNull Integer roleId) throws Exception {
        return roleService.getMenusRelation(roleId);
    }

    /**
     * 数据权限为自定义时的 部门树
     *
     * @return
     * @throws Exception
     */
    @GetMapping("/role/deptTree")
    @RequiresPermissions({"system:role:view"})
    public ApiResult getDepartmentTree() throws Exception {
        return roleService.getDepartmentTree();
    }

    /**
     * 已选的部门 回显
     *
     * @param roleId
     * @return
     * @throws Exception
     */
    @GetMapping("/role/selectedDeptTree")
    @RequiresPermissions({"system:role:update"})
    public ApiResult getSelectedDepts(@NotNull Integer roleId) throws Exception {
        return roleService.getSelectedDepts(roleId);
    }

    /**
     * 添加角色
     *
     * @param role
     * @return
     * @throws Exception
     */
    @LogInfo(title = "添加角色")
    @RepeatSubmit
    @PostMapping("/role")
    @RequiresPermissions("system:role:add")
    public ApiResult add(@Validated Role role) throws Exception {
        return roleService.addRole(role);
    }

    /**
     * 删除角色
     *
     * @param roleId
     * @return
     * @throws Exception
     */
    @LogInfo(title = "删除角色")
    @DeleteMapping("/role/{roleId}")
    @RequiresPermissions("system:role:delete")
    public ApiResult delete(@PathVariable @NotNull Integer roleId) throws Exception {
        return roleService.deleteRole(roleId);
    }

    /**
     * 批量删除
     *
     * @return
     * @throws Exception
     */
    @LogInfo(title = "批量删除角色")
    @DeleteMapping("/role/delete/batch")
    @RequiresPermissions("system:role:delete")
    public ApiResult deleteBatch(@RequestParam("roleIds") List<Integer> roleIds) throws Exception {

        return roleService.deleteRoleBatch(roleIds);
    }


    @LogInfo(title = "更新角色")
    @RepeatSubmit
    @PutMapping("/role")
    @RequiresPermissions("system:role:update")
    public ApiResult update(Role role) throws Exception {

        ApiResult result = roleService.updateRole(role);

        if (ApiResult.success().getCode().equals(result.getCode())){
            rolePermissionCacheManager.synchronizedPermission(role, (List<String>) result.getData());
        }

        return result;
    }


    @LogInfo(title = "更新角色状态")
    @PutMapping("/role/status")
    @RequiresPermissions("system:role:update")
    public ApiResult updateStatus(Role role) throws Exception {
        return roleService.updateRoleStatus(role);
    }

    @RepeatSubmit
    @PutMapping("/role/dataRange")
    @RequiresPermissions("system:role:update")
    public ApiResult updateDataRange(@RequestBody JSONObject json) throws Exception {
        return roleService.updateDataRange(json);
    }


}
