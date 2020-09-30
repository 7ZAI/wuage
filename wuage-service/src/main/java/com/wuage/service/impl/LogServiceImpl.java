package com.wuage.service.impl;

import java.util.List;

import com.wuage.Result.ApiResult;
import com.wuage.entity.Vo.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.wuage.entity.Log;
import com.wuage.mapper.LogMapper;
import com.wuage.service.LogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 系统日志 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
@Service
public class LogServiceImpl extends ServiceImpl<LogMapper, Log> implements LogService {

    @Autowired
    private LogMapper logMapper;


    /**
     * 查询系统日志
     *
     * @param pageInfo
     * @return
     * @throws Exception
     */
    @Override
    public List<Log> getLogs(PageInfo pageInfo) throws Exception {

        return null;
    }



    /**
     * 添加系统日志
     *
     * @param log
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult addLog(Log log) throws Exception {

        logMapper.insert(log);

        return ApiResult.success();
    }



    /**
     * 删除系统日志
     *
     * @param id
     * @return
     * @throws Exception
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApiResult deleteLog(Integer id) throws Exception {

        logMapper.deleteById(id);

        return ApiResult.success();
    }



    /**
     * 更新系统日志
     *
     * @param log
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateLog(Log log) throws Exception {

        logMapper.updateById(log);

        return ApiResult.success();
    }


}
