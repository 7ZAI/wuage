package com.wuage.shiro.Realm;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wuage.component.SuperAdmins;
import com.wuage.component.SysConfigMap;
import com.wuage.constant.SysConfigConstant;
import com.wuage.constant.UserConstant;
import com.wuage.entity.Role;
import com.wuage.entity.User;
import com.wuage.exception.customize.CaptchaException;
import com.wuage.mapper.UserMapper;
import com.wuage.shiro.token.UsernamePasswordCaptchaToken;
import com.wuage.utils.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * 系统用户登录认证 授权
 */
public class SysUserRealm extends AuthorizingRealm {

    private static final Logger logger = LoggerFactory.getLogger(SysUserRealm.class);


    @Autowired
    private UserMapper userMapper;
    @Autowired
    private SysConfigMap sysConfigMap;
    @Autowired
    private SuperAdmins superAdmins;

    /**
     * 授权
     *
     * @param principalCollection
     * @return
     */

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        User user = (User) SecurityUtils.getSubject().getPrincipal();
        logger.info("---------------角色授权-------------------");
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        // 角色
        Set<String> roles = new HashSet<String>();
        // 权限字符串
        Set<String> permissions = new HashSet<String>();
        try {
            if (superAdmins.isSuperAdmin(user.getUserId())) {
                roles.add("1");
                permissions.add("*:*:*");
            } else {

                List<Role> roleList = userMapper.getRolesById(user.getUserId());
                for (Role role : roleList) {
                    roles.add(String.valueOf(role.getRoleId()));
                }

                List<String> permissionList = userMapper.getPermissionString(user.getUserId());
                permissions.addAll(permissionList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        simpleAuthorizationInfo.setRoles(roles);
        simpleAuthorizationInfo.setStringPermissions(permissions);
        return simpleAuthorizationInfo;
    }


    /**
     * 认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordCaptchaToken token = (UsernamePasswordCaptchaToken) authenticationToken;

        String loginName = token.getUsername();
        String password = "";
        String code = token.getCaptchaCode();

        Integer captchaOpen = sysConfigMap.get(SysConfigConstant.CAPTCHA_SWITCH);

        if (captchaOpen.equals(SysConfigConstant.OPEN)) {
            if (code == null || code.trim().equals("")) {
                throw new CaptchaException("验证码不能为空！");
            }
            Session session = SecurityUtils.getSubject().getSession();

            String captcha = (String) session.getAttribute(UserConstant.CAPTCHA_KEY);

            logger.info("验证码校验：session:" + session.getId() + "验证码：" + captcha + "----用户提交验证码：" + code);

            if (!code.equals(captcha)) {
                throw new CaptchaException("验证码不正确！");
            }
        }

        if (token.getPassword() != null) {
            password = new String(token.getPassword());
        }

        User user = userMapper.selectOne(new QueryWrapper<User>().lambda().eq(User::getLoginName, loginName.trim()));

        if (user == null) {
            throw new UnknownAccountException("账号不存在");
        }

        if (user.getLocked().equals(UserConstant.USER_DISABLE_BY_ADMIN)) {
            throw new LockedAccountException("帐号被锁定");
        }

        if (user.getLocked().equals(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)) {

            long diff = DateUtils.getDiffOfTime(user.getLockTime(), DateUtils.getNowDate());
            long configtime = DateUtils.getLongValue(sysConfigMap.get(SysConfigConstant.FREEZE_HOUR));

            int max_login_error = sysConfigMap.get(SysConfigConstant.MAX_LOGIN_ERROR);

            if (diff >= configtime) {
                user.setLocked(UserConstant.USER_NORMAL).setLockTime(null);
                userMapper.updateById(user);
            } else {
                String msg = DateUtils.getDiffString((configtime - diff));
                throw new LockedAccountException("连续输入密码错误次数超过" + max_login_error + "次,请在" + msg + "后再登录");
            }
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, user.getPassword(),
                new Md5Hash(user.getSalt()), getName());

        return info;
    }

    /**
     * 清除角色权限缓存
     */
    public void clearPermissinCache(Subject subject) {

        clearCachedAuthorizationInfo(subject.getPrincipals());
//        clearCachedAuthorizationInfo(subject.getPrincipals());
    }
}
