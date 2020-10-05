package com.wuage.service.impl;


import com.wuage.entity.Config;
import com.wuage.mapper.ConfigMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wuage.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * <p>
 * 系统参数表 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2019-12-12
 */
@Service
public class ConfigServiceImpl extends ServiceImpl<ConfigMapper, Config> implements ConfigService {

    @Autowired
    private ConfigMapper configMapper;


}
