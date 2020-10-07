package com.wuage.mapper;

import com.wuage.entity.Log;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wuage.entity.Vo.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统日志 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2020-09-18
 */
public interface LogMapper extends BaseMapper<Log> {

    List<Log> getLogs(@Param("pageInfo") PageInfo pageInfo  ) throws  Exception;

    Integer getLogsTotal(@Param("pageInfo") PageInfo pageInfo)throws  Exception;
}
