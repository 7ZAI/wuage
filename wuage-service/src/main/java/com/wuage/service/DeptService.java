package com.wuage.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wuage.Result.ApiResult;
import com.wuage.entity.Dept;
import com.wuage.entity.Vo.PageInfo;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * <p>
 * 部门 服务类
 * </p>
 *
 * @author binblink
 * @since 2020-06-15
 */
public interface DeptService extends IService<Dept> {

    List<Dept> getAllDepartments(PageInfo pageInfo) throws Exception;

    List<Dept> getDeptFathers(Integer deptId) throws Exception;

    List<Dept> handlerDeptsToTree(List<Dept> depts) throws Exception;

    ApiResult addDept(Dept dept) throws Exception;

    ApiResult updateDept(Dept dept) throws Exception;

    ApiResult deleteDept(Integer id) throws Exception;

    ApiResult getDepartments(PageInfo pageInfo) throws Exception;
}
