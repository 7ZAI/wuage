package com.wuage.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.wuage.constant.Result.ApiResult;
import com.wuage.entity.Log;
import com.wuage.entity.Vo.PageInfo;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
public interface LogService extends IService<Log> {

    ApiResult getLogs(PageInfo pageInfo) throws Exception;

    Integer getLogsTotal(PageInfo pageInfo) throws Exception;

    ApiResult addLog(Log log) throws Exception;

    ApiResult updateLog(Log log) throws Exception;

    ApiResult deleteLog(Integer id) throws Exception;
}
