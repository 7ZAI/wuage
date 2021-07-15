package com.wuage.controller;

import com.wuage.constant.Result.ApiResult;
import com.wuage.framework.annotation.LogInfo;
import com.wuage.framework.annotation.RepeatSubmit;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.entity.User;
import com.wuage.service.UserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
        return userService.add(user);
    }


    @LogInfo(title = "删除用户")
    @RequiresPermissions("system:user:delete")
    @DeleteMapping("/user/{id}")
    public ApiResult deleteUsers(@NotNull @PathVariable Integer id) throws Exception {
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
        return userService.deleteUserBatch(userIds);
    }

    @RepeatSubmit
    @LogInfo(title = "更新用户")
    @RequiresPermissions("system:user:update")
    @PutMapping("/user")
    public ApiResult updateUser(@Validated User user) throws Exception {
        return userService.updateUser(user);
    }


    @LogInfo(title = "锁定用户")
    @RequiresPermissions("system:user:lock")
    @PutMapping("/user/locked")
    public ApiResult updateUserLocked(@NotNull Integer userId,
                                      @NotNull Integer lockedStatus) throws Exception {
        return userService.updateUserLocked(userId,lockedStatus);
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
