package com.wuage.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.component.SuperAdmins;
import com.wuage.entity.Menu;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.mapper.MenuMapper;
import com.wuage.service.MenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wuage.utils.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 系统菜单 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2019-12-16
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private SuperAdmins superAdmins;

    @Override
    public List<Menu> getMenusByUserId(Integer userId) throws Exception {

        List<Menu> list = menuMapper.getMenusByUserId(userId);
        return list;
    }

    @Override
    public List<Menu> getAllMenus(PageInfo pageInfo) throws Exception {

        List<Menu> menus = menuMapper.getAllMenus(pageInfo);
        handlerMenuTree(menus);

        return menus;
    }

    @Override
    public ApiResult getMenuByRole( PageInfo pageInfo) throws Exception {

        User loginuser = (User) SecurityUtils.getSubject().getPrincipal();

        if (superAdmins.isSuperAdmin(loginuser.getUserId())) {
            List<Menu> menus = this.getAllMenus(pageInfo);
            return new ApiResult(ResultCode.SUCCESS, menus);
        }

        List<Menu> menus = menuMapper.getMenuByRole(loginuser.getUserId(), pageInfo);
        handlerMenuTree(menus);

        return new ApiResult(ResultCode.SUCCESS, menus);
    }

    /**
     * 添加菜单
     *
     * @param menu
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult addMenu(Menu menu) throws Exception {

        User user = (User) SecurityUtils.getSubject().getPrincipal();
        menu.setCtime(DateUtils.getNowDate());
        menu.setCreater(user.getUsername());

        if (menuMapper.insert(menu) > 0) {
            //需要维护hasChildren 的正确性
            if (!menu.getParentId().equals(0)) {
                Menu parentMenu = menuMapper.selectOne(new QueryWrapper<Menu>().lambda().eq(Menu::getMenuId, menu.getParentId()));
                if (!Objects.isNull(parentMenu)) {
                    if (!parentMenu.getHasChildren()) {
                        parentMenu.setHasChildren(true);
                        menuMapper.updateById(parentMenu);
                    }
                }
            }
            return ApiResult.success();
        }
        return ApiResult.fail("新增失败!");

    }

    /**
     * 删除菜单
     *
     * @param id
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteMenu(Integer id) throws Exception {

        Menu menu = menuMapper.selectById(id);

        if (Objects.isNull(menu)) {
            return ApiResult.fail("删除失败!");
        }

        if (menu.getHasChildren()) {
            return ApiResult.fail("该菜单存在子菜单，无法删除!");
        }

        if (menuMapper.deleteById(menu.getMenuId()) > 0) {

            //需要维护hasChildren 的正确性
            Integer parentId = menu.getParentId();
            if (parentId.equals(0)) {
                return ApiResult.success();
            }
            int number = this.count(new QueryWrapper<Menu>().lambda().eq(Menu::getParentId, parentId));
            if (number <= 0) {
                this.update(new UpdateWrapper<Menu>().lambda().set(Menu::getHasChildren, false).eq(Menu::getMenuId, parentId));
            }
            return ApiResult.success();
        }

        return ApiResult.fail("删除失败！");
    }

    /**
     * 更新菜单
     * @param menu
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateMenu(Menu menu) throws Exception {
        User user = (User) SecurityUtils.getSubject().getPrincipal();

        menu.setUpdateBy(user.getUsername());
        menu.setUpdateTime(DateUtils.getNowDate());

        if (menuMapper.updateById(menu)>0) {
            return ApiResult.success();
        }
        return ApiResult.fail("更新失败");

    }

    private void handlerMenuTree(List<Menu> allMenus) {

        if (!allMenus.isEmpty()) {
            Menu start = null;
            for (int i = 0; i < allMenus.size(); i++) {
                Menu menu = allMenus.get(i);
                if (!menu.isTraversalOrNot()) {
                    start = menu;
                    break;
                }
                if (i == allMenus.size() && Objects.isNull(start)) {
                    return;
                }
            }

            if (!Objects.isNull(start)) {

                List<Menu> reustlList = handlerMenuTreeData(start, allMenus);

                handlerMenuTree(reustlList);
            }
        }
    }

    /**
     * 递归处理形成树形结构,
     * 配置mybatis 映射也可以直接得到树形结构的bean 但是会递归多次查询，不如放到内存中处理
     */
    private List<Menu> handlerMenuTreeData(Menu start, List<Menu> allMenus) {

        List<Menu> childrensList = new ArrayList<>();
        start.setTraversalOrNot(true);
        for (int i = 0; i < allMenus.size(); i++) {
            Menu menu = allMenus.get(i);
            if (menu.getParentId().equals(start.getMenuId())) {
                childrensList.add(menu);
            }
        }

        if (!childrensList.isEmpty()) {
            for (Menu removeObj : childrensList) {
                allMenus.remove(removeObj);
            }

            for (Menu newstart : childrensList) {
                handlerMenuTreeData(newstart, allMenus);
            }
            start.setChildren(childrensList);

        }

        return allMenus;

    }

}
