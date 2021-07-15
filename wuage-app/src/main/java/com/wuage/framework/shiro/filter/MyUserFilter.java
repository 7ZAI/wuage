package com.wuage.framework.shiro.filter;

import com.alibaba.fastjson.JSON;
import com.wuage.constant.Result.ApiResult;
import com.wuage.constant.Result.ResultCode;
import org.apache.shiro.web.filter.authc.UserFilter;


import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;


/**
 * 因为前后分离所以
 * 自定义的user 过滤器 返回json 数据
 * 而不用shiro 默认的重定向
 */
public class MyUserFilter extends UserFilter {


    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {

        return  super.isAccessAllowed(request,response,mappedValue);
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {

        HttpServletResponse res = (HttpServletResponse)response;
        res.setHeader("Access-Control-Allow-Origin", "*");
        res.setStatus(HttpServletResponse.SC_OK);
        res.setCharacterEncoding("UTF-8");
        PrintWriter writer = res.getWriter();

        ApiResult apiResult = new ApiResult(ResultCode.NOT_LOGIN);

        writer.write(JSON.toJSONString(apiResult));
        writer.close();
        return false;
    }


}
