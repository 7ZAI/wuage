package com.wuage.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.wuage.Result.ApiResult;

import com.wuage.Result.ResultCode;
import com.wuage.annotation.LogInfo;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.component.SuperAdmins;
import com.wuage.constant.UserConstant;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.entity.User;
import com.wuage.service.UserService;

import com.wuage.shiro.Realm.SysUserRealm;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import org.apache.shiro.SecurityUtils;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.cache.ehcache.EhCacheManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.*;

@RestController
@RequestMapping("/system")
public class SysUserController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private SuperAdmins superAdmins;
    @Autowired
    private EhCacheManager ehCacheManager;


    /**
     * 查询条件 时间 用户名 状态
     *
     * @param pageInfo 封裝了分页和查询条件
     * @return
     * @throws Exception
     */
    @RequiresPermissions("system:user:view")
    @GetMapping(value = "/user")
    public ApiResult getUsers(PageInfo pageInfo, @RequestParam(value = "depts") List<Integer> depts) throws Exception {

        return userService.getUsers(pageInfo,depts);
    }


    @RepeatSubmit
    @LogInfo(title = "添加用户")
    @RequiresPermissions("system:user:add")
    @PostMapping("/user")
    public ApiResult add(@Validated User user) throws Exception {


        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();
        String loginName = user.getLoginName();


        User checkuser = userService.getOne(new QueryWrapper<User>().lambda()
                .eq(User::getLoginName, loginName));

        if (!Objects.isNull(checkuser)) {
            return ApiResult.fail(ResultCode.USERNAME_ALREADY_EXITS.getMsg());
        }

        ApiResult apiResult = userService.addUser(currentUser, user);

        superAdmins.refresh();

        return apiResult;
    }


    @LogInfo(title = "删除用户")
    @RequiresPermissions("system:user:delete")
    @DeleteMapping("/user/{id}")
    public ApiResult deleteUsers(@NotNull @PathVariable Integer id) throws Exception {

        if (superAdmins.isSuperAdmin(id)) {
            return ApiResult.fail("该用户是超级管理员无法删除!");
        }

        return userService.deleteUser(id);
    }

    /**
     * 批量删除
     *
     * @param userIds
     * @return
     * @throws Exception
     */
    @DeleteMapping("/user/delete/batch")
    @LogInfo(title = "批量删除用户")
    @RequiresPermissions("system:user:delete")
    public ApiResult deleteBatch(@RequestParam("userIds") List<Integer> userIds) throws Exception {

        if (!Objects.isNull(userIds) && userIds.size() > 0) {

            for (Integer userid : userIds) {
                if (superAdmins.isSuperAdmin(userid)) {
                    return ApiResult.fail("无法删除超级管理员！");
                }
            }

            return userService.deleteUserBatch(userIds);

        }
        return ApiResult.fail("删除失败！");
    }

    @RepeatSubmit
    @LogInfo(title = "更新用户")
    @RequiresPermissions("system:user:update")
    @PutMapping("/user")
    public ApiResult updateUser(@Validated User user) throws Exception {

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();
        Integer updateUserId = user.getUserId();
        User oldUser = userService.getById(updateUserId);

        if (superAdmins.isSuperAdmin(updateUserId) && !superAdmins.isSuperAdmin(currentUser.getUserId())) {
            return ApiResult.fail("没有操作超级管理员的权限！");
        }

        //locked 有三种状态 但在前端只表现为两种 所以要处理一下
        if (user.getLocked().equals(UserConstant.USER_NORMAL) &&
                oldUser.getLocked().equals(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)) {

            Ehcache passwordRetryCache = ehCacheManager.getCacheManager().getCache("passwordRetryCache");
            passwordRetryCache.remove(user.getLoginName());
        }

        if (user.getLocked().equals(UserConstant.USER_DISABLE_BY_ADMIN) &&
                oldUser.getLocked().equals(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)) {
            user.setLocked(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD);
        }

        ApiResult apiResult = userService.updateUser(currentUser, user);

        superAdmins.refresh();

        return apiResult;

    }


    @LogInfo(title = "锁定用户")
    @RequiresPermissions("system:user:lock")
    @PutMapping("/user/locked")
    public ApiResult updateUserLocked(@NotNull Integer userId,
                                      @NotNull Integer lockedStatus) throws Exception {

        if (lockedStatus < UserConstant.USER_NORMAL || lockedStatus > UserConstant.USER_DISABLE_BY_ERROR_PASSWORD) {
            return ApiResult.fail("非法参数！");
        }

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();

        User oldUser = userService.getById(userId);

        if(superAdmins.isSuperAdmin(userId) && !superAdmins.isSuperAdmin(currentUser.getUserId())){
            return ApiResult.fail("没有锁定超级管理员的权限！");
        }

        if (Objects.isNull(oldUser)) {
            return  new ApiResult(ResultCode.USER_NOT_EXITS);
        }

        if (lockedStatus.equals(UserConstant.USER_NORMAL) &&
                oldUser.getLocked().equals(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)) {

            Ehcache passwordRetryCache = ehCacheManager.getCacheManager().getCache("passwordRetryCache");
            passwordRetryCache.remove(oldUser.getLoginName());
        }

        if (lockedStatus.equals(UserConstant.USER_DISABLE_BY_ADMIN) &&
                oldUser.getLocked().equals(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)) {

            lockedStatus = UserConstant.USER_DISABLE_BY_ERROR_PASSWORD;
        }

        ApiResult apiResult = userService.updateUserLocked(userId,lockedStatus);


        return apiResult;
    }



    /**
     * 获取用户的角色和部门名称（数据权限仅为当前用户时） 用户修改页面回显
     *
     * @param deptId,userId
     * @return
     * @throws Exception
     */
    @RequiresPermissions("system:user:update")
    @GetMapping(value = "/user/roles")
    public ApiResult getUserRelaRoles(@NotNull Integer deptId, @NotNull Integer userId) throws Exception {

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();

        if(superAdmins.isSuperAdmin(userId) && !superAdmins.isSuperAdmin(currentUser.getUserId())){
            return ApiResult.fail("没有操作超级管理员的权限！");
        }

        return  userService.getUserRelaRolesAndDeptName(deptId,userId);
    }

    /**
     * 第一次加载页面 准备数据
     *
     * @return
     * @throws Exception
     */
    @RequiresPermissions("system:user:view")
    @GetMapping(value = "/user/prepareData")
    public ApiResult getPreparedData() throws Exception {

        return userService.getPreparedData();
    }


}
