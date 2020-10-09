package com.wuage.mapper;

import com.wuage.entity.Config;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 系统参数表 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2020-10-05
 */
public interface ConfigMapper extends BaseMapper<Config> {

   Integer updateByCode(@Param("key") String key,@Param("value") Integer value) throws Exception;
}
