package com.wuage.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import javax.annotation.Resource;
import java.net.UnknownHostException;

/**
 * @Description
 * @Author binblink
 * @Date 2021/5/28 10:14
 */
public class RedisConfig {
    @Resource
    private LettuceConnectionFactory lettuceConnectionFactory;

    @Bean(name="myredisTemplate")
    public RedisTemplate<Object, Object> redisTemplate(LettuceConnectionFactory lettuceConnectionFactory)
            throws UnknownHostException {

        RedisTemplate<Object, Object> template = new RedisTemplate<>();

        lettuceConnectionFactory.setShareNativeConnection(false);
        lettuceConnectionFactory.setValidateConnection(false);

        template.setConnectionFactory(lettuceConnectionFactory);

        //string 序列化
        StringRedisSerializer stringRedisSerializer = new StringRedisSerializer();
        //json序列化
        Jackson2JsonRedisSerializer jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer(Object.class);

        ObjectMapper om = new ObjectMapper();
        om.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        om.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        jackson2JsonRedisSerializer.setObjectMapper(om);

        template.setKeySerializer(stringRedisSerializer);
        template.setHashKeySerializer(stringRedisSerializer);

        template.setValueSerializer(jackson2JsonRedisSerializer);
        template.setHashValueSerializer(jackson2JsonRedisSerializer);
        template.afterPropertiesSet();

        return template;
    }
}
