package com.wuage.utils;


import org.springframework.util.Assert;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoField;
import java.time.temporal.ChronoUnit;


/**
 * 时间工具类
 * 
 */
public class DateUtils extends org.apache.commons.lang3.time.DateUtils
{
    public static String YYYY = "yyyy";

    public static String YYYY_MM = "yyyy-MM";

    public static String YYYY_MM_DD = "yyyy-MM-dd";

    public static String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";

    public static String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    
    private static String[] parsePatterns = {
            "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM", 
            "yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm", "yyyy/MM",
            "yyyy.MM.dd", "yyyy.MM.dd HH:mm:ss", "yyyy.MM.dd HH:mm", "yyyy.MM"};


    /**
     * 获取当前LocalDateTime型日期
     * 
     * @return Date() 当前日期
     */
    public static LocalDateTime getNowDate()
    {
        return LocalDateTime.now();
    }


    /**
     * 字符串转 LocalDateTime 类型
     * @param str
     * @return
     */
    public static LocalDateTime parseLocalDateTime(String str){

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(YYYY_MM_DD_HH_MM_SS) ;
        LocalDateTime localDateTime = LocalDateTime.parse(str,dateTimeFormatter);
        return localDateTime;
    }

    /**
     * 获取当天开始时间
     */
    public static String getTodayStart(){
        LocalDateTime today_start = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);//当天零点
        return today_start.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    /**
     * 获取当天结束时间
     */
    public static String getTodayEnd(){
        LocalDateTime today_start = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);//当天零点

        return today_start.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    /**
     * 获取两个时间的间隔
     * @param lockTime
     * @return
     */
    public static long getDiffOfTime(LocalDateTime lockTime,LocalDateTime now) {
        return  Duration.between(lockTime,now).getSeconds();
    }

    /**
     * 获取小时的秒值
     * @param integer
     * @return
     */
    public static long getLongValue(Integer integer) {
        long time = integer.intValue()*60*60;
        return time;
    }

    /**
     * 将时间差转换为字符串 几天 几小时 几分钟 几秒
     * @param l 时间差的单位为秒
     * @return
     */
    public static String getDiffString(long l) {

        StringBuilder stringBuilder = new StringBuilder();

        Duration duration = Duration.of(l, ChronoUnit.SECONDS);
        long days = duration.toDays();

        if(days>0){
            l = (l-(days*60*60*24));
            duration = Duration.of(l,ChronoUnit.SECONDS);
            stringBuilder.append(days+"天");
        }

        long hours = duration.toHours();

        if(hours>0){
            l = (l-(hours*60*60));
            duration = Duration.of(l,ChronoUnit.SECONDS);
            stringBuilder.append(hours+"小时");
        }

        long mins  = duration.toMinutes();

        if(mins>0){
            l = (l-(mins*60));
            duration = Duration.of(l,ChronoUnit.SECONDS);
            stringBuilder.append(mins+"分钟");
        }

        long seconds = duration.getSeconds();

        if(seconds>0){
            stringBuilder.append(seconds+"秒");
        }
        return stringBuilder.toString();
    }

    /**
     * 毫秒转为秒
     * @param mills 毫秒
     * @return 返回String
     */
    public static String millToSecond(long mills){

        Assert.notNull(mills,"mills is not null!");

        BigDecimal bigDecimal = new BigDecimal(String.valueOf(mills));

        BigDecimal result =  bigDecimal.divide(new BigDecimal("1000"),4,BigDecimal.ROUND_HALF_UP);

        return String.valueOf(result.toString());

    }
}
