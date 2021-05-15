package com.wuage.component;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.wuage.entity.Config;
import com.wuage.mapper.ConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * 系统参数map
 */
@Component
public class SysConfigMap {

    @Autowired
    private ConfigMapper configMapper;

    private ConcurrentHashMap<String, Integer> map;

//    private ReentrantReadWriteLock readWriteLock = new ReentrantReadWriteLock();


    @PostConstruct
    private void init() {
        //
        List<Config> list = configMapper.selectList(Wrappers.emptyWrapper());
        Map resultMap  =  list.stream().collect(Collectors.toMap(Config::getConfigCode, Config::getConfigValue));
        this.map = new ConcurrentHashMap<>(resultMap);
    }


    public Integer get(String keyCode) {
//        readWriteLock.readLock();
        Objects.requireNonNull(keyCode);
        Integer value = map.get(keyCode);
        return value;
    }


    public void update(String keyCode,Integer value) {

        Objects.requireNonNull(keyCode);
        Objects.requireNonNull(value);

        map.replace(keyCode,value);

    }

    public Map getAllConfig() {
        return this.map;
    }

    public void refrash() {
        init();
    }
}
