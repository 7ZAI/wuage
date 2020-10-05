package com.wuage.component;


import com.wuage.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;

import java.util.List;
import java.util.Objects;


/**
 * 超级管理员List 避免每次用户的改、查都去查询数据库，
 * （因为需求为 不能删除、改变超级管理员权限等）；
 * 而是用这个组件来判断，该组件和系统参数一样，在系统启动后加载
 */
@Component
public class SuperAdmins {

    @Autowired
    private UserMapper userMapper;

    private List<Integer> superAdminList;

    @PostConstruct
    private void init() throws Exception {
        superAdminList = userMapper.getSuperAdminIds();
    }

    public boolean isSuperAdmin(Integer id) throws Exception {

        return superAdminList.contains(Objects.requireNonNull(id));
    }

    public synchronized void  refresh() throws Exception {

        superAdminList = userMapper.getSuperAdminIds();
    }
}
