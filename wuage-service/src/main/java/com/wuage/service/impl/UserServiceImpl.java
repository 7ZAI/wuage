package com.wuage.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.component.SuperAdmins;
import com.wuage.constant.RoleConstatnt;
import com.wuage.constant.SysConfigConstant;
import com.wuage.constant.UserConstant;
import com.wuage.entity.Dept;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.mapper.DeptMapper;
import com.wuage.mapper.UserMapper;
import com.wuage.service.DeptService;
import com.wuage.service.RoleService;
import com.wuage.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wuage.utils.DateUtils;
import com.wuage.utils.security.RandomUtils;
import net.sf.ehcache.Ehcache;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * <p>
 * 系统用户 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2019-12-12
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private UserMapper userMapper;
    @Resource
    private DeptMapper deptMapper;
    @Resource
    private DeptService deptService;
    @Resource
    private SuperAdmins superAdmins;
    @Resource
    private RoleService roleService;
    @Resource
    private EhCacheManager ehCacheManager;


    @Override
    public List<Role> getRolesByUserId(Integer userId) throws Exception {
        return userMapper.getRolesById(userId);
    }


    @Override
    public List<Integer> getSuperAdminIds() throws Exception {

        return userMapper.getSuperAdminIds();
    }


    /**
     * 删除单个用户
     *
     * @param id
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteUser(Integer id) throws Exception {

        if (superAdmins.isSuperAdmin(id)) {
            return ApiResult.fail("该用户是超级管理员无法删除!");
        }


        userMapper.deleteById(id);
        userMapper.deleteUserRoleRelations(id);
        return ApiResult.success();
    }

    /**
     * 批量删除
     *
     * @param userIds
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteUserBatch(List<Integer> userIds) throws Exception {

        if (!Objects.isNull(userIds) && userIds.size() > 0) {

            for (Integer userid : userIds) {
                if (superAdmins.isSuperAdmin(userid)) {
                    return ApiResult.fail("无法删除超级管理员！");
                }
            }
            userMapper.deleteBatchIds(userIds);
            userMapper.deleteUserRoleRelationBatch(userIds);

            return ApiResult.success();
        }


        return ApiResult.fail("删除失败！");
    }

    /**
     * 更新用户
     *
     * @param user
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateUser(User user) throws Exception {

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();
        Integer updateUserId = user.getUserId();
        User oldUser = userMapper.selectById(updateUserId);

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

        user.setUpdateBy(currentUser.getLoginName());
        user.setUpdateTime(DateUtils.getNowDate());
        userMapper.updateById(user);
        List<Integer> roles = user.getRoles();

        if (!Objects.isNull(roles) && !roles.isEmpty()) {

            userMapper.deleteUserRoleRelations(user.getUserId());
            userMapper.insertUserRole(user.getUserId(), roles);
        } else {
            userMapper.deleteUserRoleRelations(user.getUserId());
        }

        superAdmins.refresh();

        return ApiResult.success();
    }

    /**
     * 锁定按钮
     *
     * @param userId
     * @param lockedStatus
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateUserLocked(Integer userId, Integer lockedStatus) throws Exception {


        if (lockedStatus < UserConstant.USER_NORMAL || lockedStatus > UserConstant.USER_DISABLE_BY_ERROR_PASSWORD) {
            return ApiResult.fail("非法参数！");
        }

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();

        User oldUser = userMapper.selectById(userId);

        if (superAdmins.isSuperAdmin(userId) && !superAdmins.isSuperAdmin(currentUser.getUserId())) {
            return ApiResult.fail("没有锁定超级管理员的权限！");
        }

        if (Objects.isNull(oldUser)) {
            return new ApiResult(ResultCode.USER_NOT_EXITS);
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

        this.update(new UpdateWrapper<User>()
                .lambda().eq(User::getUserId, userId).set(User::getLocked, lockedStatus));

        return ApiResult.success();
    }

    /**
     * 多条件和分页查询
     *
     * @param pageInfo
     * @param depts
     * @return
     * @throws Exception
     */
    @Override
    public ApiResult getUsers(PageInfo pageInfo, List<Integer> depts) throws Exception {
        User user = (User) SecurityUtils.getSubject().getPrincipal();

        IPage<User> iPage = new Page<User>(pageInfo.getPage(), pageInfo.getLimit());
        if (!Objects.isNull(depts) && !depts.isEmpty()) {
            iPage = userMapper.getUserList((Page) iPage, pageInfo, depts);
        } else {
            List<User> userlist = new ArrayList();
            userlist.add(user);
            iPage.setRecords(userlist);
            iPage.setTotal(1);
        }

        return new ApiResult(ResultCode.SUCCESS, iPage);
    }

    /**
     * 数据回显
     *
     * @param deptId
     * @param userId
     * @return
     * @throws Exception
     */
    @Override
    public ApiResult getUserRelaRolesAndDeptName(Integer deptId, Integer userId) throws Exception {

        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();

        if (superAdmins.isSuperAdmin(userId) && !superAdmins.isSuperAdmin(currentUser.getUserId())) {
            return ApiResult.fail("没有操作超级管理员的权限！");
        }

        Dept dept = deptMapper.selectById(deptId);
        List<Role> roles = userMapper.getRolesById(userId);

        JSONObject json = new JSONObject();

        json.put("roles", roles);
        json.put("deptName", dept.getDeptName());

        return new ApiResult(ResultCode.SUCCESS, json);
    }

    /**
     * 第一次加载页面 所需数据
     *
     * @return
     * @throws Exception
     */
    @Override
    public ApiResult getPreparedData() throws Exception {

        User user = (User) SecurityUtils.getSubject().getPrincipal();

        List<Role> roles = userMapper.getRolesById(user.getUserId());
        List<Dept> depts = handleRolestoGetDepts(roles, user);

        PageInfo pageInfo = new PageInfo();
        pageInfo.setLimit(SysConfigConstant.DEFAULT_LIMIT);
        pageInfo.setPage(SysConfigConstant.DEFAULT_PAGE);

        IPage<User> iPage = new Page<User>(pageInfo.getPage(), pageInfo.getLimit());

        if (!Objects.isNull(depts) && !depts.isEmpty()) {

            List<Integer> list = new ArrayList<>();

            depts.forEach(ele -> {
                list.add(ele.getDeptId());
            });

            iPage = userMapper.getUserList((Page) iPage, pageInfo, list);
        } else {
            List<User> userlist = new ArrayList();
            userlist.add(user);
            iPage.setRecords(userlist);
            iPage.setTotal(1);
        }

        depts = deptService.handlerDeptsToTree(depts);

        List<Role> listroles = getRolesOptions(user);

        JSONObject json = new JSONObject();
        json.put("depts", depts);
        json.put("userData", iPage);
        json.put("rolesOptions", listroles);

        return new ApiResult(ResultCode.SUCCESS, json);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult add(User user) throws Exception {
        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();
        String loginName = user.getLoginName();

        User checkuser = userMapper.selectOne(new QueryWrapper<User>().lambda()
                .eq(User::getLoginName, loginName));

        if (!Objects.isNull(checkuser)) {
            return ApiResult.fail(ResultCode.USERNAME_ALREADY_EXITS.getMsg());
        }

        user.setCtime(DateUtils.getNowDate());

        String salt = RandomUtils.getSalt(8);
        user.setPassword(SysConfigConstant.USER_DEFAULT_PASSWORD);
        user.setSalt(salt);
        user.setCreater(currentUser.getUsername());

        ByteSource bytesalt = new Md5Hash(salt);
        SimpleHash simpleHash = new SimpleHash("md5", user.getPassword(), bytesalt, 2);

        user.setPassword(simpleHash.toHex());
        userMapper.insert(user);
        List<Integer> roleList = user.getRoles();

        if (!Objects.isNull(roleList) && !roleList.isEmpty()) {
            try {
                userMapper.insertUserRole(user.getUserId(), roleList);
            } catch (Exception e) {
                throw new Exception("插入角色用户关系数据异常！");
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("uid", user.getUserId());
        jsonObject.put("ctime", user.getCtime());

        superAdmins.refresh();

        return new ApiResult(ResultCode.SUCCESS, jsonObject);
    }

    /**
     * 根据角色获取部门数据范围
     *
     * @param roles
     * @param user
     * @return
     * @throws Exception
     */
    private List<Dept> handleRolestoGetDepts(List<Role> roles, User user) throws Exception {

        Set<Dept> deptsSet = new HashSet<>();

        for (int i = 0; i < roles.size(); i++) {

            Role role = roles.get(i);

            Integer dataRange = role.getDataRange();

            List<Dept> list = handlerDataRange(dataRange, user);
            deptsSet.addAll(list);
        }
        List<Dept> listResult = new ArrayList<>(deptsSet);

        return listResult;
    }

    /**
     * 判断部门数据范围
     *
     * @param dataRange
     * @param user
     * @return
     * @throws Exception
     */
    private List<Dept> handlerDataRange(Integer dataRange, User user) throws Exception {

        List<Dept> depts = new ArrayList<>();

        if (RoleConstatnt.ROLE_DATARANGE_PERSONAL.equals(dataRange)) {

            return depts;

        }

        if (RoleConstatnt.ROLE_DATARANGE_DEPARTMENT_ONLY.equals(dataRange)) {

            List<Dept> deptlist = deptMapper.getDeptFathers(user.getDeptId());
            return deptlist;
        }

        if (RoleConstatnt.ROLE_DATARANGE_DEPARTMENT_ALL.equals(dataRange)) {

            List<Dept> fatherlist = deptMapper.getDeptFathers(user.getDeptId());
            List<Dept> sonlist = deptMapper.getDeptSons(user.getDeptId());
            fatherlist.addAll(sonlist);
            return fatherlist;

        }

        if (RoleConstatnt.ROLE_DATARANGE_CUSTOM.equals(dataRange)) {
            List<Dept> deptlist = userMapper.getDeptsByUserId(user.getUserId());
            return deptlist;
        }

        if (RoleConstatnt.ROLE_DATARANGE_ALL.equals(dataRange) ) {

            List<Dept> deptlist = deptService.list();

            return deptlist;
        }
        return depts;
    }

    /**
     * 角色select options 回显
     *
     * @param user
     * @return
     * @throws Exception
     */
    private List<Role> getRolesOptions(User user) throws Exception {
        List<Role> roles;
        LambdaQueryWrapper<Role> queryWrapper = new QueryWrapper<Role>().lambda()
                .eq(Role::getStatus, RoleConstatnt.ROLE_STATUS_ACTIVE);
        if (getSuperAdminIds().contains(user.getUserId())) {
            roles = roleService.list(queryWrapper);
        } else {
            roles = roleService.list(queryWrapper.ne(Role::getRoleCode, RoleConstatnt.SUPER_ADMIN));
        }

        return roles;
    }
}
