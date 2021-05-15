package com.wuage.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.annotation.LogInfo;
import com.wuage.component.SuperAdmins;
import com.wuage.component.SysConfigMap;
import com.wuage.constant.SysConfigConstant;
import com.wuage.constant.UserConstant;
import com.wuage.entity.*;
import com.wuage.entity.Vo.SystemUserInfo;
import com.wuage.enums.OperateType;
import com.wuage.exception.customize.CaptchaException;
import com.wuage.service.DeptService;
import com.wuage.service.MenuService;
import com.wuage.service.UserService;
import com.wuage.shiro.token.UsernamePasswordCaptchaToken;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.cache.ehcache.EhCacheManager;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;


/**
 * 后台用户登录
 */
@RestController
@RequestMapping("/systemUser")
public class SysLoginController extends BaseController {

    @Autowired
    private UserService userService;
    @Autowired
    private EhCacheManager ehCacheManager;
    @Autowired
    private SysConfigMap sysConfigMap;
    @Autowired
    private MenuService menuService;
    @Autowired
    private DeptService deptService;
    @Autowired
    private SuperAdmins superAdmins;

    private Ehcache passwordRetryCache;


    @PostConstruct
    public void init() {
        passwordRetryCache = ehCacheManager.getCacheManager().getCache("passwordRetryCache");
    }


    @LogInfo(title = "用户登录", operateType = OperateType.LOGIN)
    @PostMapping(value = "/login")
    public ApiResult login(String loginName, String password, String captcha, boolean rememberMe, HttpServletRequest request) {

        Integer val = sysConfigMap.get(SysConfigConstant.LOGIN_SWITCH);

        if (SysConfigConstant.CLOSE.equals(val) && !UserConstant.SUPER_ADMIN.equals(loginName)) {
            return new ApiResult(ResultCode.FUNCTION_FORBIDDEN);
        }

        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordCaptchaToken token = new UsernamePasswordCaptchaToken(loginName, password, captcha);
        String username = (String) token.getPrincipal();

        Objects.requireNonNull(rememberMe);
        token.setRememberMe(rememberMe);

        try {
            subject.login(token);
        } catch (CaptchaException e) {
            throw e;
        } catch (UnknownAccountException e) {
            throw e;
        } catch (LockedAccountException e) {
            throw e;
        } catch (IncorrectCredentialsException e) {

            Element element = passwordRetryCache.get(username);
            String errorMsg = "";
            if (element == null) {
                element = new Element(username, new AtomicInteger(0));
                passwordRetryCache.put(element);
            }

            AtomicInteger retryCount = (AtomicInteger) element.getObjectValue();

            int times = sysConfigMap.get(SysConfigConstant.MAX_LOGIN_ERROR);
            int currentTimes = retryCount.incrementAndGet();

            if (currentTimes >= times) {

                User user = userService.getOne(new QueryWrapper<User>().lambda().eq(User::getLoginName, username));
                user.setLocked(UserConstant.USER_DISABLE_BY_ERROR_PASSWORD)
                        .setLockTime(LocalDateTime.now());
                userService.updateById(user);
                long hours = sysConfigMap.get(SysConfigConstant.FREEZE_HOUR);
                errorMsg = "输入密码错误次数超过" + times + "次,请在" + hours + "小时后再登录";

                throw new LockedAccountException(errorMsg);
            }

            errorMsg = "密码错误!你还有" + (times - currentTimes) + "次机会，连续输错后账号将被锁定！";

            throw new ExcessiveAttemptsException(errorMsg);

        } catch (AuthenticationException e) {
            throw new AuthenticationException("登录失败!请联系管理人员！");
        }

        passwordRetryCache.remove(username);
        Session session = subject.getSession();
        User user = (User) subject.getPrincipal();

        session.removeAttribute(UserConstant.CAPTCHA_KEY);

        return ApiResult.success();
    }

    /**
     * 判断是否登录 虽然拦截器会判断
     * 但是还是要返回信息给前端 替代部分token的作用
     *
     * @return
     * @throws Exception
     */
    @GetMapping("/isLogin")
    public ApiResult isLogin()  {

        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated() || subject.isRemembered()) {
            return ApiResult.success().setData(true);
        }
        return ApiResult.success().setData(false);
    }

    /**
     * 登入认证后 获取用户信息 菜单信息
     *
     * @return
     * @throws Exception
     */
    @GetMapping("/userInfo")
    public ApiResult getUserInfo() throws Exception {

        User user = (User) SecurityUtils.getSubject().getPrincipal();
        SystemUserInfo systemUserInfo = new SystemUserInfo(user);
        List<Menu> menus = null;
        if (superAdmins.isSuperAdmin(user.getUserId())) {
            menus = menuService.list(new QueryWrapper<Menu>().lambda()
                    .eq(Menu::getStatus, 1).in(Menu::getType, 1, 2)
                    .orderByAsc(Menu::getOrderNumber));
        } else {
            menus = menuService.getMenusByUserId(user.getUserId());
        }

        List<Role> roles = userService.getRolesByUserId(user.getUserId());
        List<Dept> depts = deptService.getDeptFathers(user.getDeptId());
        systemUserInfo.setRoles(roles);
        systemUserInfo.setMenus(menus);

        String fulldept = "";
        for (Dept dept : depts) {
            fulldept = fulldept + dept.getDeptName() + "/";
        }
        fulldept = fulldept.substring(0, fulldept.lastIndexOf("/"));
        systemUserInfo.setFullPathDeptName(fulldept);

        return ApiResult.success().setData(systemUserInfo);
    }


}
