package com.wuage.service;

import com.wuage.Result.ApiResult;
import com.wuage.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;
import com.wuage.entity.Vo.PageInfo;


import java.util.List;

/**
 * <p>
 * 系统菜单 服务类
 * </p>
 *
 * @author binblink
 * @since 2019-12-16
 */
public interface MenuService extends IService<Menu> {

    List<Menu> getMenusByUserId(Integer userId) throws Exception;

    List<Menu> getAllMenus(PageInfo pageInfo) throws Exception;

    List<Menu> getMenuByRole(Integer userId,PageInfo pageInfo) throws Exception;

    ApiResult addMenu(Menu menu) throws Exception;

    ApiResult deleteMenu(Integer id) throws Exception;

    ApiResult updateMenu(Menu menu) throws Exception;
}
