package com.wuage.controller;

import com.wuage.constant.Result.ApiResult;
import com.wuage.framework.annotation.LogInfo;
import com.wuage.framework.annotation.RepeatSubmit;
import com.wuage.entity.Menu;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.service.MenuService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@Validated
@RequestMapping("/system")
public class SysMenuController extends BaseController {

    @Autowired
    private MenuService menuService;


    @RequiresPermissions("system:menu:view")
    @GetMapping("/user/menus")
    public ApiResult searchMenus(@ModelAttribute PageInfo pageInfo) throws Exception {
        return  menuService.getMenuByRole(pageInfo);
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
