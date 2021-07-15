package com.wuage.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.wuage.constant.Result.ApiResult;
import com.wuage.constant.Result.ResultCode;
import com.wuage.framework.component.SuperAdmins;
import com.wuage.constant.RoleConstatnt;
import com.wuage.entity.Dept;
import com.wuage.entity.Menu;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.mapper.MenuMapper;
import com.wuage.mapper.RoleMapper;
import com.wuage.service.DeptService;
import com.wuage.service.RoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 系统角色 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2020-07-09
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Resource
    private RoleMapper roleMapper;
    @Resource
    private SuperAdmins superAdmins;
    @Resource
    private MenuMapper menuMapper;
    @Resource
    private DeptService deptService;

    @Override
    public ApiResult getRoles(PageInfo pageInfo) throws Exception {

        Integer total = roleMapper.getTotal(pageInfo);
        JSONObject json = new JSONObject();
        List<Role> roles = roleMapper.getRolesByConidition(pageInfo);

        json.put("roles", roles);
        json.put("total", total);

        return new ApiResult(ResultCode.SUCCESS, json);
    }


    @Override
    public Integer roleNameIsExit(String roleName) throws Exception {
        return roleMapper.roleNameIsExit(roleName);
    }


    @Override
    public ApiResult getMenusRelation(Integer roleId) throws Exception {
        List<Integer> menuIds = roleMapper.getMenusRelation(roleId);
        return new ApiResult(ResultCode.SUCCESS, menuIds);
    }


    /**
     * 添加角色
     *
     * @param role
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult addRole(Role role) throws Exception {


        String roleName = role.getRoleName().trim();

        role.setRoleName(roleName);

        if (this.roleNameIsExit(roleName) > 0) {

            return ApiResult.fail("已存在该角色名称！");
        }

        if ("".equals(roleName)) {
            return ApiResult.fail("非法参数！");
        }


        User user = (User) SecurityUtils.getSubject().getPrincipal();
        Integer[] menuIds = role.getMenuIds();
        role.setCreater(user.getLoginName());
        int saveRoleResult = roleMapper.insert(role);

        Integer roleid = role.getRoleId();


        if (!Objects.isNull(menuIds) && menuIds.length > 0 && !Objects.isNull(roleid)) {

            int saveRealtionResult = roleMapper.saveRoleMenuRelation(roleid, menuIds);

            if (saveRealtionResult > 0 && saveRoleResult > 0) {
                return ApiResult.success();
            }
        }

        if (Objects.isNull(menuIds) || menuIds.length == 0) {
            if (saveRoleResult > 0) {
                return ApiResult.success();
            }
        }
        return ApiResult.fail("新增失败！");
    }

    /**
     * 删除角色
     *
     * @param roleId
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteRole(Integer roleId) throws Exception {

        Role role = roleMapper.selectById(roleId);

        if (RoleConstatnt.SUPER_ADMIN_ID.equals(role.getRoleType())) {

            return ApiResult.fail("超级管理员角色无法删除！");
        }

        if (roleMapper.deleteById(roleId) > 0) {

            roleMapper.deleteRoleMenuRelation(roleId);
            roleMapper.deletRoleUserRelation(roleId);
            return ApiResult.success();
        }
        return ApiResult.fail("删除失败！");
    }

    /**
     * 批量删除
     *
     * @param roleIds
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteRoleBatch(List<Integer> roleIds) throws Exception {

        if (!Objects.isNull(roleIds) && roleIds.size() > 0) {

            roleMapper.deleteBatchIds(roleIds);
            roleMapper.deleteRoleMenuRelationBatch(roleIds);
            roleMapper.deletRoleUserRelationBatch(roleIds);
            return ApiResult.success();
        }

        return ApiResult.fail("删除失败！");
    }

    /**
     * 更新角色
     *
     * @param role
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateRole(Role role) throws Exception {
        User user = (User) SecurityUtils.getSubject().getPrincipal();

        if (RoleConstatnt.SUPER_ADMIN_ID.equals(role.getRoleType())) {

            return ApiResult.fail("无法操作超级管理员角色！");
        }


        String roleName = role.getRoleName().trim();
        role.setRoleName(roleName);
        role.setUpdateBy(user.getLoginName());

        Role oldValue = roleMapper.selectById(role.getRoleId());

        if (Objects.isNull(oldValue)) {
            return ApiResult.fail("更新失败!");
        }

        if (!oldValue.getRoleName().equals(roleName)) {
            if (roleMapper.roleNameIsExit(roleName) > 0) {
                return ApiResult.fail("更新失败,已存在该角色名称！");
            }
        }

        if (roleMapper.updateById(role) > 0) {

            List<String> oldPermissin = roleMapper.getPermissionByRoleId(role.getRoleId());

            roleMapper.deleteRoleMenuRelation(role.getRoleId());
            if (!Objects.isNull(role.getMenuIds()) && role.getMenuIds().length > 0) {

                roleMapper.saveRoleMenuRelation(role.getRoleId(), role.getMenuIds());
            }

            return ApiResult.success().setData(oldPermissin);
        }

        return ApiResult.fail("更新失败！");


    }

    /**
     * 启用禁用角色
     *
     * @param role
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateRoleStatus(Role role) throws Exception {

        if (RoleConstatnt.SUPER_ADMIN_ID.equals(role.getRoleType())) {

            return ApiResult.fail("无法操作超级管理员角色！");
        }

        User user = (User) SecurityUtils.getSubject().getPrincipal();

        role.setUpdateBy(user.getLoginName());

        boolean result = this.update(new UpdateWrapper<Role>().lambda().eq(Role::getRoleId, role.getRoleId())
                .set(Role::getUpdateBy, role.getUpdateBy())
                .set(Role::getStatus, role.getStatus()));

        if (result) {
            return ApiResult.success();
        }
        return ApiResult.fail("更新失败！");

    }

    /**
     * 更改数据范围权限
     *
     * @param json
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateDataRange(JSONObject json) throws Exception {

        Role role = JSON.toJavaObject((JSON) json.get("role"), Role.class);

        if (Objects.isNull(role)) {
            return ApiResult.error("参数错误！");
        }
        Integer rangeType = role.getDataRange();

        if (rangeType < RoleConstatnt.ROLE_DATARANGE_PERSONAL || rangeType > RoleConstatnt.ROLE_DATARANGE_ALL) {
            return ApiResult.error("非法参数！");
        }

        this.update(new LambdaUpdateWrapper<Role>().eq(Role::getRoleId, role.getRoleId())
                .set(Role::getDataRange, rangeType));

        if (RoleConstatnt.ROLE_DATARANGE_CUSTOM.equals(rangeType) ) {


            List<Integer> depts = JSON.parseArray(json.getString("depts"), Integer.class);

            roleMapper.deletAllDepRelationByRoleId(role.getRoleId());

            if (!Objects.isNull(depts) && depts.size() > 0) {
                roleMapper.saveRoleDeptRelation(depts, role.getRoleId());
            }
        }
        return ApiResult.success();
    }

    @Override
    public ApiResult getMenuPermissions() throws Exception {

        User loginuser = (User) SecurityUtils.getSubject().getPrincipal();
        List<Menu> menus;
        PageInfo pageInfo = new PageInfo();

        if (superAdmins.isSuperAdmin(loginuser.getUserId())) {
            menus = menuMapper.getAllMenus(pageInfo);
            return new ApiResult(ResultCode.SUCCESS, menus);
        }

        menus = menuMapper.getMenuByRole(loginuser.getUserId(), pageInfo);

        return new ApiResult(ResultCode.SUCCESS, menus);
    }

    @Override
    public ApiResult getSelectedDepts(Integer roleId) throws Exception {

        List<Integer> deptSelectedIds = roleMapper.getDeptRelationByRoleId(roleId);
        return new ApiResult(ResultCode.SUCCESS, deptSelectedIds);
    }

    @Override
    public ApiResult getDepartmentTree() throws Exception {
        PageInfo pageInfo = new PageInfo();
        List<Dept> departments = deptService.getAllDepartments(pageInfo);
        return new ApiResult(ResultCode.SUCCESS, departments);
    }
}
