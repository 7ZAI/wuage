package com.wuage.controller;

import com.wuage.Result.ApiResult;
import com.wuage.component.SysConfigMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/system")
public class SysConfigController {


    @Autowired
    private SysConfigMap configMap;


    @GetMapping("/config")
    public ApiResult getSystemConfig() throws Exception{

        return ApiResult.success().setData(configMap.getAllConfig());
    }
}
