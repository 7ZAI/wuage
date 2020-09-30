package com.wuage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 基本的Controller
 */
public class BaseController {

    protected final Logger logger = LoggerFactory.getLogger(BaseController.class);

    /**
     * 将前台传递过来的日期格式的字符串，自动转化为LocalDateTime类型
     */
//    @InitBinder
//    public void initBinder(WebDataBinder binder)
//    {
//        // LocalDateTime 类型转换
//        binder.registerCustomEditor(LocalDateTime.class, new PropertyEditorSupport()
//        {
//            @Override
//            public void setAsText(String text)
//            {
//                setValue(DateUtils.parseLocalDateTime(text));
//            }
//        });
//    }


    /**得到request对象
     * @return
     */
    public HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request;
    }

    /**
     * 获取response
     */
    public HttpServletResponse getResponse()
    {
        ServletRequestAttributes attributes = (ServletRequestAttributes)getRequest();
        return attributes.getResponse();
    }

    /**
     * 获取session
     */
    public HttpSession getSession()
    {
        return getRequest().getSession();
    }





}
