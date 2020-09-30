package com.wuage.mapper;

import com.wuage.entity.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wuage.entity.Vo.PageInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统菜单 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2019-12-16
 */
@Mapper
public interface MenuMapper extends BaseMapper<Menu> {

    List<Menu> getMenusByUserId(Integer userId) throws Exception;

    List<Menu> getMenuList(@Param("userId") Integer userId,@Param("menuId") Integer menuId) throws Exception;

    Integer hasChildren(Integer menuId) throws Exception;

    List<Menu> getMenusByUserIdParentId(Integer parentId )throws Exception;

    List<Menu> getAllMenus(@Param("pageInfo") PageInfo pageInfo)throws Exception;

    List<Menu> getMenuByRole(@Param("userId") Integer userId,@Param("pageInfo") PageInfo pageInfo)throws Exception;

    List<String> getPermissionsByIds(@Param("menuIds") List<Integer> menuIds) throws Exception;

}
