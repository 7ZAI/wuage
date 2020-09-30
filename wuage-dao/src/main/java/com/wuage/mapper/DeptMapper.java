package com.wuage.mapper;

import com.wuage.entity.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wuage.entity.Menu;
import com.wuage.entity.Vo.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 部门 Mapper 接口
 * </p>
 *
 * @author binblink
 * @since 2020-06-15
 */
public interface DeptMapper extends BaseMapper<Dept> {

    List<Dept> getAllDepartments(@Param("pageInfo") PageInfo pageInfo)throws Exception;

    Integer hasChildren(Integer deptId) throws Exception;

    List<Dept> getDeptFathers(Integer deptId) throws Exception;

    List<Dept> getDeptSons(Integer deptId) throws Exception;

}
