package com.wuage.framework.aspectj;

import com.alibaba.fastjson.JSON;
import com.wuage.constant.GlobalConstants;

import com.wuage.constant.enums.OperateType;
import com.wuage.entity.Log;
import com.wuage.entity.User;
import com.wuage.framework.annotation.LogInfo;
import com.wuage.mapper.LogMapper;
import com.wuage.utils.DateUtils;
import com.wuage.utils.IpUtils;
import com.wuage.utils.ServletUtils;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.Objects;

/**
 * 日志切面
 */
@Aspect
@Component
public class LogAspectj {

    //记录方法运行时间
    private static final ThreadLocal<Long> TIME_THREADLOCAL = new ThreadLocal<Long>();

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private LogMapper logMapper;

    //织入点
    @Pointcut("@annotation(LogInfo)")
    public void logPointCut() {

    }

    @Before("logPointCut()")
    public void doBefore(JoinPoint joinPoint) {
        TIME_THREADLOCAL.set(System.currentTimeMillis());
        HttpServletRequest request = ServletUtils.getRequest();
        logger.debug("请求url: " + request.getRequestURI());
        logger.debug("请求参数:" + JSON.toJSONString(request.getParameterMap()));
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        logger.debug("请求方法：" + methodSignature.getMethod().getName());

    }

    @AfterReturning(pointcut = "logPointCut()", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, Object jsonResult) {
        handleLog(joinPoint, null, jsonResult);
    }


    @AfterThrowing(value = "logPointCut()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Exception e) {
        handleLog(joinPoint, e, null);
    }


    private void handleLog(final JoinPoint joinPoint, final Exception e, Object jsonResult) {

        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method method = methodSignature.getMethod();
        HttpServletRequest request = ServletUtils.getRequest();

        LogInfo logAnnotation = method.getAnnotation(LogInfo.class);

        //日志记录
        Log log = new Log();

        log.setResultType(GlobalConstants.SUCCESS);
//        log.setLogType(logAnnotation.logType().getTypeValue());
        log.setOperatorType(logAnnotation.operateType().getTypeValue());
        log.setLogTitle(logAnnotation.title());

        log.setIp(IpUtils.ipToLong(ServletUtils.getRequest().getRemoteAddr()));
        log.setUrl(ServletUtils.getRequest().getRequestURI());

        Map<String, String[]> map = ServletUtils.getRequest().getParameterMap();
        String param = JSON.toJSONString(map);
        log.setParam(param);

        if (log.getOperatorType().equals(OperateType.NORMAL.getTypeValue())) {
            User user = (User) SecurityUtils.getSubject().getPrincipal();
            log.setOperatorName(user.getLoginName());
            log.setOperatorId(user.getUserId());
        }else{
            Map<String,String[]> mapParame =  request.getParameterMap();
            String[] name = mapParame.get("loginName");
            if( Objects.nonNull(name) && name.length>0){
                log.setOperatorName(name[0]);
            }
        }

        //预留 前台的user log
//        if (log.getLogType().equals(LogType.APP_LOG.getTypeValue())) {
//
//        }

        if (!Objects.isNull(e)) {
            log.setResultType(GlobalConstants.FAIL);
            log.setErrorMsg(e.toString());
        }

        //待 异步处理 目前先这样吧
        log.setResult(JSON.toJSONString(jsonResult));

        Long costtime = System.currentTimeMillis() - TIME_THREADLOCAL.get();
        String ctime = DateUtils.millToSecond(costtime);
        log.setCostTime(ctime);
        logMapper.insert(log);

        logger.info( "方法："+methodSignature.getMethod().getName()+"  耗时："+ ctime);
        TIME_THREADLOCAL.remove();
    }
}
