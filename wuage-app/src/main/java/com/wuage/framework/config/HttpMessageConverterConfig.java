package com.wuage.framework.config;

import com.alibaba.fastjson.serializer.ValueFilter;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Configuration
public class HttpMessageConverterConfig {


    private static final String YYYY_MM_DD = "yyyy-MM-dd";
    private static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";

    /**
     * 自定义类型转换,HTTP请求日期字符串转换日期类型,
     * 相当于以前设置进 ConversionServiceFactoryBean
     *
     * @return Converter<java.lang.String,java.util.Date>
     * @author:
     * @date: 2020/4/14
     */
    @Bean
    public Converter<String, LocalDateTime> localDateTimeConverter() {
        return new Converter<String, LocalDateTime>() {
            @Override
            public LocalDateTime convert(String source) {
                try {
                    return parse(source);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                throw new RuntimeException("日期解析错误");
            }
        };
    }

    @Bean
    public FastJsonHttpMessageConverter fastJsonHttpMessageConverter(){

        FastJsonHttpMessageConverter converter = new FastJsonHttpMessageConverter();
        FastJsonConfig jsonConfig = new FastJsonConfig();
        jsonConfig.setDateFormat(YYYY_MM_DD_HH_MM_SS);
        converter.setFastJsonConfig(jsonConfig);

        ValueFilter valueFilter = (o, s, o1) -> {
            if (null == o1) {
                o1 = "";
            }
            if (o1 instanceof LocalDateTime){
                o1 = ((LocalDateTime) o1).format(DateTimeFormatter.ofPattern(YYYY_MM_DD_HH_MM_SS));
            }
            return o1;
        };
        jsonConfig.setSerializeFilters(valueFilter);
        return converter;
    }

    /**
     * 根据字符串进行解析,将Date转LocalDateTime
     *
     * @param source 日期字符串
     * @return java.time.LocalDateTime
     * @author:
     * @date: 2020/4/14
     */
    public LocalDateTime parse(String source) throws ParseException {
        if (StringUtils.isBlank(source)) {
            return null;
        }
        DateFormat format;
        source = source.trim();
        //判断是否yyyy-MM-dd格式
        if (source.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")) {
            format = new SimpleDateFormat(YYYY_MM_DD);
            Date date = format.parse(source);
            return LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault());
            //判断是否yyyy-MM-dd HH:mm:ss格式
        } else if (source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}:\\d{1,2}$")) {
            format = new SimpleDateFormat(YYYY_MM_DD_HH_MM_SS);
            Date date = format.parse(source);
            return LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault());
        } else {
            throw new IllegalArgumentException("Invalid false value " + source);
        }
    }

}
