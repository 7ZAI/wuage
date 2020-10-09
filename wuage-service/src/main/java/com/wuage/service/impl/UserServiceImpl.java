package com.wuage.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.constant.RoleConstatnt;
import com.wuage.constant.SysConfigConstant;
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
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private DeptService deptService;


    @Autowired
    private RoleService roleService;


    @Override
    public List<Role> getRolesByUserId(Integer userId) throws Exception {
        return userMapper.getRolesById(userId);
    }


    @Override
    public List<Integer> getSuperAdminIds() throws Exception {

        return userMapper.getSuperAdminIds();
    }

    /**
     * 添加用户
     *
     * @param user
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult addUser(User currentUser, User user) throws Exception {

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
        jsonObject.put("uid",user.getUserId());
        jsonObject.put("ctime",user.getCtime());

        return ApiResult.success().setData(jsonObject);
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

        userMapper.deleteById(id);
        userMapper.deleteUserRoleRelations(id);
//        int k = 3 / 0;
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

        userMapper.deleteBatchIds(userIds);
        userMapper.deleteUserRoleRelationBatch(userIds);

        return ApiResult.success();
    }

    /**
     * 更新用户
     *
     * @param currentUser
     * @param user
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateUser(User currentUser, User user) throws Exception {

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


        Dept dept = deptMapper.selectById(deptId);
        List<Role> roles = userMapper.getRolesById(userId);

        JSONObject json = new JSONObject();

        json.put("roles", roles);
        json.put("deptName", dept.getDeptName());

        return new ApiResult(ResultCode.SUCCESS, json);
    }

    /**
     * 第一次加载页面 所需数据
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

        if (dataRange == RoleConstatnt.ROLE_DATARANGE_PERSONAL) {

            return depts;

        }

        if (dataRange == RoleConstatnt.ROLE_DATARANGE_DEPARTMENT_ONLY) {

            List<Dept> deptlist =  deptMapper.getDeptFathers(user.getDeptId());
            return deptlist;
        }

        if (dataRange == RoleConstatnt.ROLE_DATARANGE_DEPARTMENT_ALL) {

            List<Dept> fatherlist = deptMapper.getDeptFathers(user.getDeptId());
            List<Dept> sonlist = deptMapper.getDeptSons(user.getDeptId());
            fatherlist.addAll(sonlist);
            return fatherlist;

        }

        if (dataRange == RoleConstatnt.ROLE_DATARANGE_CUSTOM) {
            List<Dept> deptlist = userMapper.getDeptsByUserId(user.getUserId());
            return deptlist;
        }

        if (dataRange == RoleConstatnt.ROLE_DATARANGE_ALL) {

            List<Dept> deptlist = deptService.list();

            return deptlist;
        }
        return depts;
    }

    /**
     * 角色select options 回显
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
