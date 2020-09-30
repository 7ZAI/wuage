package com.wuage.config;

import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author:binblink
 * @Description
 * @Date: Create on  2020/1/26 17:37
 * @Modified By:
 * @Version:1.0.0
 **/
@Configuration
public class LocalDateTimeSerializerConfig {

        @Value("${spring.jackson.date-format:yyyy-MM-dd HH:mm:ss}")
        private String pattern;

        @Bean
        public LocalDateTimeSerializer localDateTimeDeserializer() {
            return new LocalDateTimeSerializer(DateTimeFormatter.ofPattern(pattern));
        }

        @Bean
        public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
            return builder -> builder.serializerByType(LocalDateTime.class, localDateTimeDeserializer());
        }

}
