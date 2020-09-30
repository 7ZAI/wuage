package com.wuage.shiro.filter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import org.apache.shiro.session.SessionException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.LogoutFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * 退出登录 过滤器 使用这种方式不需要再写controller
 * 只需配置即可
 */
public class SysUserLogoutFilter extends LogoutFilter {

    private static final Logger log = LoggerFactory.getLogger(SysUserLogoutFilter.class);


    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {

        Subject subject = super.getSubject(request,response);

        try {

            subject.logout();
        } catch (SessionException ise) {
            log.debug("Encountered session exception during logout.  This can generally safely be ignored.", ise);
        }

        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter writer = response.getWriter();

        ApiResult apiResult = new ApiResult(ResultCode.SUCCESS);
        apiResult.setMsg("成功退出登录!");
        writer.write(JSON.toJSONString(apiResult));

        return false;
    }


}
