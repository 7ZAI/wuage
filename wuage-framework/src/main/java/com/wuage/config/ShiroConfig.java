package com.wuage.config;

import com.wuage.shiro.Realm.SysUserRealm;
import com.wuage.shiro.filter.KickoutSessionFilter;
import com.wuage.shiro.filter.MyUserFilter;
import com.wuage.shiro.filter.SysUserLogoutFilter;
import com.wuage.utils.String.StringUtils;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.config.ConfigurationException;
import org.apache.shiro.io.ResourceUtils;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.session.mgt.eis.MemorySessionDAO;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {


    /**
     * Shiro过滤器配置
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager,SessionManager sessionManager)
    {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        // Shiro的核心安全接口,这个属性是必须的
        shiroFilterFactoryBean.setSecurityManager(securityManager);

        shiroFilterFactoryBean.setLoginUrl("/systemUser/login");

        // 权限认证失败，则跳转到指定页面
//        shiroFilterFactoryBean.setUnauthorizedUrl(unauthorizedUrl);
        // Shiro连接约束配置，即过滤链的定义
        LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap<>();

        // 不需要拦截的访问
        filterChainDefinitionMap.put("/druid/**", "anon");
        filterChainDefinitionMap.put("/captchaImage**", "anon");
        filterChainDefinitionMap.put("/systemUser/login", "anon");
        filterChainDefinitionMap.put("/system/config", "anon");

        // 系统权限列表
        // filterChainDefinitionMap.putAll(SpringUtils.getBean(IMenuService.class).selectPermsAll());

        Map<String, Filter> filters = new LinkedHashMap<String, Filter>();
        //filter
//        filters.put("onlineSession", onlineSessionFilter());
//        filters.put("syncOnlineSession", syncOnlineSessionFilter());
        filters.put("myuser", myUserFilter());
        filters.put("kickout", kickoutSessionFilter(sessionManager));
//        // 注销成功，则跳转到指定页面
        filters.put("logout", logoutFilter());
        shiroFilterFactoryBean.setFilters(filters);

        // 所有请求需要认证
        filterChainDefinitionMap.put("/logout","logout");
        filterChainDefinitionMap.put("/**", "myuser,kickout");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);

        return shiroFilterFactoryBean;
    }

    /**
     * 安全管理器
     */
    @Bean
    public SecurityManager securityManager(SysUserRealm userRealm,
                                           SessionManager sessionManager,EhCacheManager ehCacheManager)
    {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        // 设置realm.
        securityManager.setRealm(userRealm);
        // 记住我
        securityManager.setRememberMeManager(rememberMeManager());
        // 注入缓存管理器;
        securityManager.setCacheManager(ehCacheManager);
        // session管理器
        securityManager.setSessionManager(sessionManager);

        return securityManager;
    }




    /**
     * 会话管理器
     */
    @Bean
    public SessionManager sessionManager(EhCacheManager ehCacheManager)
    {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
//        sessionManager.setSessionDAO();
        sessionManager.setCacheManager(ehCacheManager);
        sessionManager.setDeleteInvalidSessions(true);
        // 设置全局session超时时间
        sessionManager.setGlobalSessionTimeout(30 * 60 * 1000);
        // 去掉 JSESSIONID
        sessionManager.setSessionIdUrlRewritingEnabled(false);
        // 是否定时检查session
        sessionManager.setSessionValidationSchedulerEnabled(true);

        return sessionManager;
    }

    /**
     * 缓存管理器 使用Ehcache实现
     */
    @Bean
    public EhCacheManager getEhCacheManager() {
        net.sf.ehcache.CacheManager cacheManager = net.sf.ehcache.CacheManager.getCacheManager("wuage");
        EhCacheManager em = new EhCacheManager();
        if (StringUtils.isNull(cacheManager)) {
            em.setCacheManager(new net.sf.ehcache.CacheManager(getCacheManagerConfigFileInputStream()));
            return em;
        } else {
            em.setCacheManager(cacheManager);
            return em;
        }
    }

    /**
     * 开启Shiro注解通知器
     */
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(
            @Qualifier("securityManager") SecurityManager securityManager)
    {
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
        return authorizationAttributeSourceAdvisor;
    }


    /**
     * 自定义Realm
     */
    @Bean
    public SysUserRealm sysUserRealm(EhCacheManager cacheManager,@Qualifier("hashedCredentialsMatcher") HashedCredentialsMatcher matcher) {
        SysUserRealm sysUserRealm = new SysUserRealm();
        sysUserRealm.setCacheManager(cacheManager);
        sysUserRealm.setCredentialsMatcher(matcher);

        return sysUserRealm;
    }

    /**
     * 密码验证匹配器
     * @return
     */
    @Bean(name = "hashedCredentialsMatcher")
    public HashedCredentialsMatcher credentialsMatcher() {
        HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
        credentialsMatcher.setHashAlgorithmName("md5");
        credentialsMatcher.setHashIterations(2);
        return credentialsMatcher;
    }


    /**
     * cookie 属性设置
     */
    public SimpleCookie rememberMeCookie()
    {
        SimpleCookie cookie = new SimpleCookie("rememberMe");
        cookie.setDomain("");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(30 * 24 * 60 * 60);
        return cookie;
    }


    /**
     * 记住我
     */
    public CookieRememberMeManager rememberMeManager()
    {
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(rememberMeCookie());
        cookieRememberMeManager.setCipherKey(Base64.decode("Y29tLnd1YWdlODg4ODg4OA=="));

        return cookieRememberMeManager;
    }

    /**
     * 退出过滤器
     */
    public SysUserLogoutFilter logoutFilter()
    {
        SysUserLogoutFilter logoutFilter = new SysUserLogoutFilter();
        return logoutFilter;
    }

    /**
     * 踢出用户过滤器
     */
    public KickoutSessionFilter kickoutSessionFilter(SessionManager sessionManager)
    {
        KickoutSessionFilter kickoutSessionFilter = new KickoutSessionFilter();

        kickoutSessionFilter.setCacheManager(getEhCacheManager());
        kickoutSessionFilter.setSessionManager(sessionManager);
        // 同一个用户最大的会话数，默认-1无限制；比如2的意思是同一个用户允许最多同时两个人登录
        kickoutSessionFilter.setMaxSession(1);
        // 是否踢出后来登录的，默认是false；即后者登录的用户踢出前者登录的用户；踢出顺序
        kickoutSessionFilter.setKickoutAfter(false);
        // 被踢出后重定向到的地址；
        return kickoutSessionFilter;
    }

    /**
     * 未登录过滤器
     * @return
     */
    public MyUserFilter myUserFilter(){

        MyUserFilter myUserFilter = new MyUserFilter();

        return myUserFilter;
    }
    /**
     * 返回配置文件流 避免ehcache配置文件一直被占用，无法完全销毁项目重新部署
     */
    protected InputStream getCacheManagerConfigFileInputStream() {
        String configFile = "classpath:ehcache/ehcache-shiro.xml";
        InputStream inputStream = null;
        try {
            inputStream = ResourceUtils.getInputStreamForPath(configFile);
            byte[] b = IOUtils.toByteArray(inputStream);
            InputStream in = new ByteArrayInputStream(b);
            return in;
        } catch (IOException e) {
            throw new ConfigurationException(
                    "Unable to obtain input stream for cacheManagerConfigFile [" + configFile + "]", e);
        } finally {
            IOUtils.closeQuietly(inputStream);
        }
    }



}
