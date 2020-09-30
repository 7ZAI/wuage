package com.wuage.mapper;

import com.wuage.entity.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wuage.entity.Vo.PageInfo;
import org.apache.ibatis.annotations.Param;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * <p>
 * 系统角色 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2020-07-09
 */
public interface RoleMapper extends BaseMapper<Role> {

    List<Role> getRolesByUserId(Integer userId) throws Exception;

    List<Role> getRolesByConidition(@Param("pageInfo") PageInfo pageInfo) throws Exception;

    Integer getTotal(@Param("pageInfo") PageInfo pageInfo) throws Exception;

    Integer roleNameIsExit(String roleName) throws Exception;

    Integer deleteRoleMenuRelation(Integer roleId) throws Exception;

    Integer deletAllDepRelationByRoleId(Integer roleId) throws Exception;

    Integer saveRoleMenuRelation(@Param("roleId") Integer roleId, @Param("menuIds") Integer[] menuIds) throws Exception;

    Integer saveRoleDeptRelation(@Param("depts") List<Integer> depts, @Param("roleId") Integer roleId) throws Exception;

    List<Integer> getMenusRelation(Integer roleId) throws Exception;

    List<String> getPermissionByRoleId(Integer roleId) throws Exception;

    Integer deleteRoleMenuRelationBatch(@Param("roleIds") List<Integer> roleIds) throws Exception;

    List<Integer> getDeptRelationByRoleId(@NotNull Integer roleId) throws Exception;

    List<Role> getRolesOfUser(Integer userId) throws Exception;

    Integer deletRoleUserRelation(Integer roleId) throws Exception;

    Integer deletRoleUserRelationBatch(@Param("roleIds")List<Integer> roleIds)throws Exception;
}
