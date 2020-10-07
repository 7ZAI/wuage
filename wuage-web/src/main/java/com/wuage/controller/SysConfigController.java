package com.wuage.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.wuage.Result.ApiResult;
import com.wuage.annotation.LogInfo;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.component.SysConfigMap;

import com.wuage.constant.SysConfigConstant;
import com.wuage.entity.Config;
import com.wuage.service.ConfigService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/system")
public class SysConfigController {


    @Autowired
    private SysConfigMap configMap;

    @Autowired
    private ConfigService configService;

    @GetMapping("/config")
    @RequiresPermissions("system:config:view")
    public ApiResult getSystemConfig() throws Exception {

        return ApiResult.success().setData(configMap.getAllConfig());
    }

    @LogInfo(title = "更改系统参数")
    @RepeatSubmit
    @PostMapping("/config")
    @RequiresPermissions("system:config:update")
    @Transactional(rollbackFor = Exception.class)
    public ApiResult updateSystemConfig(@RequestParam Map<String, String> map) throws Exception {


        map.forEach((k, v) -> {
            configService.update(new UpdateWrapper<Config>().lambda().set(Config::getConfigValue, v).eq(Config::getConfigCode, k));
        });

        configMap.refrash();
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
