package com.wuage.controller;

import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.annotation.LogInfo;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.component.SysConfigMap;

import com.wuage.constant.SysConfigConstant;
import com.wuage.entity.User;
import com.wuage.service.ConfigService;
import component.SuperAdmins;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/system")
public class SysConfigController extends BaseController {


    @Autowired
    private SysConfigMap configMap;

    @Autowired
    private ConfigService configService;

    @Autowired
    private SuperAdmins superAdmins;

    @GetMapping("/config")
    @RequiresPermissions("system:config:view")
    public ApiResult getSystemConfig() throws Exception {

        return ApiResult.success().setData(configMap.getAllConfig());
    }

    @LogInfo(title = "更改系统参数")
    @RepeatSubmit
    @PostMapping("/config")
    @RequiresPermissions("system:config:update")
    public ApiResult updateSystemConfig( @RequestBody Map<String, Integer> map) throws Exception {

        Integer sysMode =  configMap.get(SysConfigConstant.SYSTEM_MODE);
        User currentUser = (User) SecurityUtils.getSubject().getPrincipal();
        if(SysConfigConstant.MODE_SHOW.equals(sysMode) && !superAdmins.isSuperAdmin(currentUser.getUserId())){

            return new ApiResult(ResultCode.SHOW_MODE_FORBIDDEN);
        }
        //缓存更新
        map.forEach((k, v) -> {

            logger.info("更新参数到缓存---------key:P"+k+"--- value:"+ String.valueOf(v));
            configMap.update(k,v);
//            configService.update(new UpdateWrapper<Config>().lambda().set(Config::getConfigValue, v).eq(Config::getConfigCode, k));
        });
        //异步更新到数据库
        configService.asynUpdate(map);
//        configMap.refrash();
        return ApiResult.success();
    }


    @GetMapping("/loginConfig")
    public ApiResult getLoginConfig() throws Exception{

        Map<String,Integer> loginConfig = new HashMap<>(3);
        loginConfig.put(SysConfigConstant.LOGIN_SWITCH,configMap.get(SysConfigConstant.LOGIN_SWITCH));
        loginConfig.put(SysConfigConstant.CAPTCHA_SWITCH,configMap.get(SysConfigConstant.CAPTCHA_SWITCH));
        loginConfig.put(SysConfigConstant.SYSTEM_MODE,configMap.get(SysConfigConstant.SYSTEM_MODE));

        return ApiResult.success().setData(loginConfig);
    }
}
