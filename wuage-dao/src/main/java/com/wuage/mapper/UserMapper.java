package com.wuage.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wuage.entity.Dept;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wuage.entity.Vo.PageInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 系统用户 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2019-12-12
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    List<Role> getRolesById(Integer userId) throws Exception;

    List<String> getPermissionString(Integer userId)  throws Exception;

    void insertUserRole(@Param("userId")Integer userId, @Param("roles") List<Integer> roles)  throws Exception;

    IPage<User> getUserList(Page page , @Param("pageInfo") PageInfo pageInfo,
                            @Param("depts") List<Integer> depts) throws Exception;

    void deleteUserRoleRelations(Integer userId) throws Exception;

    List<Integer> getSuperAdminIds() throws Exception;

    List<Dept> getDeptsByUserId(Integer userId) throws Exception;

    Integer deleteUserRoleRelationBatch(@Param("userIds") List<Integer> userIds) throws Exception;
}
