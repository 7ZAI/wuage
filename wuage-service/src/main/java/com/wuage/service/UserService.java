package com.wuage.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wuage.Result.ApiResult;
import com.wuage.entity.Dept;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.wuage.entity.Vo.PageInfo;


import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 系统用户 服务类
 * </p>
 *
 * @author binblink
 * @since 2019-12-12
 */
public interface UserService extends IService<User> {

    List<Role> getRolesByUserId(Integer userId) throws Exception;

    List<Integer> getSuperAdminIds() throws Exception;

    ApiResult deleteUser( Integer id) throws Exception;

    ApiResult deleteUserBatch(List<Integer> userIds) throws Exception;

    ApiResult updateUser(User user) throws Exception;

    ApiResult updateUserLocked(Integer userId,  Integer lockedStatus) throws Exception;

    ApiResult getUsers(PageInfo pageInfo, List<Integer> depts) throws Exception;

    ApiResult getUserRelaRolesAndDeptName( Integer deptId, Integer userId) throws Exception;

    ApiResult getPreparedData() throws Exception;

    ApiResult add(User user) throws Exception;
}
