package com.wuage.component;

import com.wuage.entity.Config;
import com.wuage.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 系统参数map
 */
@Component
public class SysConfigMap {

    @Autowired
    private ConfigService configService;

    private HashMap<String, Integer> map;

//    private ReentrantReadWriteLock readWriteLock = new ReentrantReadWriteLock();


    @PostConstruct
    private void init() {
        List<Config> list = configService.list();
        this.map = (HashMap<String, Integer>) list.stream().collect(Collectors.toMap(Config::getConfigCode, Config::getConfigValue));
    }


    public Integer get(String keyCode) {
//        readWriteLock.readLock();
        Objects.requireNonNull(keyCode);
        Integer value = map.get(keyCode);
        return value;
    }

    public Map getAllConfig() {
        return this.map;
    }

    public void refrash() {
        init();
    }
}
