package com.wuage.controller;

import com.alibaba.fastjson.JSONObject;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.entity.Log;
import com.wuage.service.LogService;
import com.wuage.entity.Vo.PageInfo;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

import org.springframework.web.bind.annotation.RestController;


/**
 * <p>
 * 系统日志 前端控制器
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
@RestController
@RequestMapping("/log")
public class LogController extends BaseController {

    private LogService logSerivce;

    @Autowired
    public LogController(LogService logSerivce) {
        this.logSerivce = logSerivce;


    }


    /**
     * 列表查询
     *
     * @param pageInfo
     * @return
     * @throws Exception
     */
    @RequiresPermissions("system:log:view")
    @GetMapping("/log")
    public ApiResult getLogs(PageInfo pageInfo) throws Exception {


        List<Log> Logs = logSerivce.getLogs(pageInfo);
        JSONObject json = new JSONObject();
        json.put(" Log", Logs);


        return new ApiResult(ResultCode.SUCCESS, json);

    }

    /**
     * 添加系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
    @RepeatSubmit
    @PostMapping("/log")
    @RequiresPermissions("system:log:add")
    public ApiResult add(@Validated Log log) throws Exception {


        return logSerivce.addLog(log);

    }

    /**
     * 删除系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
    @DeleteMapping("/log/logId}")
    @RequiresPermissions("system:log:delete")
    public ApiResult delete(@PathVariable @NotNull Integer logId) throws Exception {

        return logSerivce.deleteLog(logId);

    }

    /**
     * 更新系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
    @RepeatSubmit
    @PutMapping("/log/")
    @RequiresPermissions("system:log:update")
    public ApiResult update(Log log) throws Exception {

        return logSerivce.updateLog(log);
    }


}












