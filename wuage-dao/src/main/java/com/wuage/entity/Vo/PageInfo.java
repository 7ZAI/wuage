package com.wuage.entity.Vo;

import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 映射前端查询的实体类
 */
@Data
public class PageInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    //查询条数
    private Integer limit;

    //当前页
    private Integer page;

    //升序字段
    private String[] ascKeys;

    //降序字段
    private String[] descKeys;

    //关键字
    private String keywords;
    //状态
    private Integer status;
    //类型
    private Integer type;
    //起始时间
    private LocalDateTime startTime;
    //结束时间
    private LocalDateTime endTime;


}
