package com.wuage.shiro.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.entity.User;
import com.wuage.utils.ServletUtils;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.DefaultSessionKey;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayDeque;
import java.util.Deque;

public class KickoutSessionFilter  extends AccessControlFilter {

    private final static ObjectMapper OBJECTMAPPER = new ObjectMapper();

    /**
     * 同一个用户最大会话数
     **/
    private int maxSession = -1;

    /**
     * 踢出之前登录的/之后登录的用户 默认false踢出之前登录的用户
     **/
    private Boolean kickoutAfter = false;


    private SessionManager sessionManager;
    private Cache<String, Deque<Serializable>> cache;

    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o)
            throws Exception
    {
        return false;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception
    {
        Subject subject = getSubject(request, response);
        if (!subject.isAuthenticated() && !subject.isRemembered() || maxSession == -1)
        {
            // 如果没有登录或用户最大会话数为-1，直接进行之后的流程
            return true;
        }
        try
        {
            Session session = subject.getSession();
            // 当前登录用户
            User user = (User) subject.getPrincipal();
            Serializable sessionId = session.getId();

            // 读取缓存用户 没有就存入
            Deque<Serializable> deque = cache.get(user.getLoginName());
            if (deque == null)
            {
                // 初始化队列
                deque = new ArrayDeque<Serializable>();
            }

            // 如果队列里没有此sessionId，且用户没有被踢出；放入队列
            if (!deque.contains(sessionId) && session.getAttribute("kickout") == null)
            {

                // 将sessionId存入队列
                deque.push(sessionId);
                // 将用户的sessionId队列缓存
                cache.put(user.getLoginName(), deque);
            }

            // 如果队列里的sessionId数超出最大会话数，开始踢人
            while (deque.size() > maxSession)
            {
                Serializable kickoutSessionId = null;
                // 是否踢出后来登录的，默认是false；即后者登录的用户踢出前者登录的用户；
                if (kickoutAfter)
                {
                    // 踢出后者
                    kickoutSessionId = deque.removeFirst();
                }
                else
                {
                    // 踢出前者
                    kickoutSessionId = deque.removeLast();
                }
                // 踢出后再更新下缓存队列
                cache.put(user.getLoginName(), deque);

                try
                {
                    // 获取被踢出的sessionId的session对象
                    Session kickoutSession = sessionManager.getSession(new DefaultSessionKey(kickoutSessionId));
                    if (null != kickoutSession)
                    {
                        // 设置会话的kickout属性表示踢出了
                        kickoutSession.setAttribute("kickout", true);
                    }
                }
                catch (Exception e)
                {
                    // 面对异常，我们选择忽略
                }
            }

            // 如果被踢出了，(前者或后者)直接退出，重定向到踢出后的地址
            if ((Boolean) session.getAttribute("kickout") != null && (Boolean) session.getAttribute("kickout") == true)
            {
                // 退出登录
                subject.logout();
                saveRequest(request);
                return isAjaxResponse(request, response);
            }
            return true;
        }
        catch (Exception e)
        {
            return isAjaxResponse(request, response);
        }
    }

    private boolean isAjaxResponse(ServletRequest request, ServletResponse response) throws IOException
    {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        if (ServletUtils.isAjaxRequest(req))
        {
            ApiResult ajaxResult = new ApiResult(ResultCode.USER_KICKOUT);
            ServletUtils.renderString(res, OBJECTMAPPER.writeValueAsString(ajaxResult));
        }

        return false;
    }

    public void setMaxSession(int maxSession)
    {
        this.maxSession = maxSession;
    }

    public void setKickoutAfter(boolean kickoutAfter)
    {
        this.kickoutAfter = kickoutAfter;
    }

    public void setSessionManager(SessionManager sessionManager)
    {
        this.sessionManager = sessionManager;
    }

    // 设置Cache的key的前缀
    public void setCacheManager(CacheManager cacheManager)
    {

        // 必须和ehcache缓存配置中的缓存name一致
        this.cache = cacheManager.getCache("sys-userCache");
    }
}
