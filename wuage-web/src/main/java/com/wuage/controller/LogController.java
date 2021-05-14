package com.wuage.controller;

import com.wuage.Result.ApiResult;
import com.wuage.service.LogService;
import com.wuage.entity.Vo.PageInfo;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;


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
@RequestMapping("/system")
public class LogController extends BaseController {

    @Resource
    private LogService logSerivce;

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
        return logSerivce.getLogs(pageInfo);
    }

    /**
     * 添加系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
//    @RepeatSubmit
//    @PostMapping("/log")
//    @RequiresPermissions("system:log:add")
//    public ApiResult add(@Validated Log log) throws Exception {
//
//
//        return logSerivce.addLog(log);
//
//    }

    /**
     * 删除系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
//    @DeleteMapping("/log/logId}")
//    @RequiresPermissions("system:log:delete")
//    public ApiResult delete(@PathVariable @NotNull Integer logId) throws Exception {
//
//        return logSerivce.deleteLog(logId);
//
//    }

    /**
     * 更新系统日志
     *
     * @param
     * @return
     * @throws Exception
     */
//    @RepeatSubmit
//    @PutMapping("/log/")
//    @RequiresPermissions("system:log:update")
//    public ApiResult update(Log log) throws Exception {
//
//        return logSerivce.updateLog(log);
//    }


}












