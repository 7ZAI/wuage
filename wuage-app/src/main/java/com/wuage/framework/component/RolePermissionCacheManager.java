package com.wuage.framework.component;

import com.wuage.entity.Role;
import com.wuage.framework.shiro.Realm.SysUserRealm;
import com.wuage.mapper.MenuMapper;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * ehcache 缓存同步
 *
 */
@Component
public class RolePermissionCacheManager {

    @Autowired
    private SysUserRealm sysUserRealm;

    @Autowired
    private EhCacheManager ehCacheManager;

    @Autowired
    private MenuMapper menuMapper;

    protected final Logger logger = LoggerFactory.getLogger(RolePermissionCacheManager.class);

    /**
     * 修改角色权限时，同步最新角色权限到缓存中
     */
    public void synchronizedPermission(Role role,List<String> oldPermissions) throws Exception {

        String cacheName = sysUserRealm.getAuthorizationCacheName();
        Ehcache ehcache = ehCacheManager.getCacheManager().getEhcache(cacheName);
        Map<Object, Element> map = ehcache.getAll(ehcache.getKeys());

        map.forEach((k, y) -> {

            //shiro 缓存权限数据对象
            SimpleAuthorizationInfo simpleAuthorizationInfo = (SimpleAuthorizationInfo) y.getObjectValue();
            HashSet<String> rolesset = (HashSet<String>) simpleAuthorizationInfo.getRoles();

            if(rolesset.contains(String.valueOf(role.getRoleId()))){

                List<Integer> menuIds = Arrays.asList(role.getMenuIds());
                try {
                    List<String> newPermissions = menuMapper.getPermissionsByIds(menuIds);
                    Set<String> setString = simpleAuthorizationInfo.getStringPermissions();

                    setString.removeAll(oldPermissions);
                    setString.addAll(newPermissions);

                    simpleAuthorizationInfo.setStringPermissions(setString);

                } catch (Exception e) {
                    logger.error("------------更新角色缓存时发生异常 -------------" );
                    e.printStackTrace();

                }

            }

        });


    }
}
