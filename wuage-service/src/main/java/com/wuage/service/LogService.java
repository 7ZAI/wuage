package com.wuage.service;


import com.wuage.Result.ApiResult;

import java.util.List;

import com.wuage.entity.Log;
import com.wuage.entity.Vo.PageInfo;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
public interface LogService extends IService<Log> {

    List<Log> getLogs(PageInfo pageInfo) throws Exception;

    Integer getLogsTotal(PageInfo pageInfo) throws Exception;

    ApiResult addLog(Log log) throws Exception;

    ApiResult updateLog(Log log) throws Exception;

    ApiResult deleteLog(Integer id) throws Exception;
}
