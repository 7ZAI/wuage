package com.wuage.controller;


import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.annotation.LogInfo;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.component.SuperAdmins;
import com.wuage.entity.Menu;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.service.MenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
@Validated
@RequestMapping("/system")
public class SysMenuController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private SuperAdmins superAdmins;

    @RequiresPermissions("system:menu:view")
    @GetMapping("/user/menus")
    public ApiResult searchMenus(@ModelAttribute PageInfo pageInfo) throws Exception {

        User loginuser = (User) SecurityUtils.getSubject().getPrincipal();


        if (superAdmins.isSuperAdmin(loginuser.getUserId())) {

            List<Menu> menus = menuService.getAllMenus(pageInfo);
            return new ApiResult(ResultCode.SUCCESS, menus);
        }

        List<Menu> menuList = menuService.getMenuByRole(loginuser.getUserId(), pageInfo);

        return new ApiResult(ResultCode.SUCCESS, menuList);
    }

    @RepeatSubmit
    @RequiresPermissions("system:menu:add")
    @LogInfo(title = "添加菜单")
    @PostMapping(value = "/menu")
    public ApiResult add(@Validated Menu menu) throws Exception {
        return menuService.addMenu(menu);
    }

    /**
     * @param id
     * @return
     */
    @RequiresPermissions("system:menu:delete")
    @LogInfo(title = "删除菜单")
    @DeleteMapping("/menu/{id}")
    public ApiResult delete(@PathVariable @NotNull Integer id) throws Exception {
        return menuService.deleteMenu(id);
    }

    @RepeatSubmit
    @LogInfo(title = "更新菜单")
    @RequiresPermissions("system:menu:update")
    @PutMapping("/menu")
    public ApiResult update(@Validated Menu menu) throws Exception {

        return menuService.updateMenu(menu);
    }


}
