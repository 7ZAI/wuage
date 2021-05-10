package com.wuage.service.impl;


import com.wuage.entity.Config;
import com.wuage.mapper.ConfigMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wuage.service.ConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;


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

    private final Logger logger = LoggerFactory.getLogger(ConfigServiceImpl.class);

    //以后可以 上消息队列 异步更新到数据库
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void asynUpdate(Map<String, Integer> map) throws Exception {

        new Thread(
                ()->{
                    map.forEach((k, v) -> {
                        try {

                            logger.info("更新参数到数据库---------key:P"+k+"--- value:"+ String.valueOf(v));
                            configMapper.updateByCode(k,v);
                        } catch (Exception e) {

                            e.printStackTrace();
                        }
//                        configMapper.update(new UpdateWrapper<Config>().lambda().set(Config::getConfigValue, v).eq(Config::getConfigCode, k));
                    });
                }
        ).start();


    }
}
