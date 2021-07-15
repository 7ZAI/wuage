package com.wuage.controller;

import com.wuage.constant.Result.ApiResult;
import com.wuage.framework.annotation.LogInfo;
import com.wuage.framework.annotation.RepeatSubmit;
import com.wuage.entity.Dept;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.service.DeptService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@Validated
@RequestMapping("/system")
public class SysDepartmentController extends BaseController {

    @Autowired
    private DeptService deptService;

    @RequiresPermissions("system:dept:view")
    @GetMapping("/departments")
    public ApiResult getDepartments(@ModelAttribute PageInfo pageInfo) throws Exception{
        return deptService.getDepartments(pageInfo);
    }


    @RepeatSubmit
    @RequiresPermissions("system:dept:add")
    @LogInfo(title = "添加部门")
    @PostMapping(value = "/departments")
    public ApiResult addDepartments(@Validated Dept dept) throws Exception{

        return deptService.addDept(dept);
    }

    @RepeatSubmit
    @LogInfo(title = "更新部门")
    @RequiresPermissions("system:dept:update")
    @PutMapping("/departments")
    public ApiResult update(@Validated Dept dept) throws Exception {
        return deptService.updateDept(dept);
    }

    /**
     * @param id
     * @return
     */
    @RequiresPermissions("system:dept:delete")
    @LogInfo(title = "删除部门")
    @DeleteMapping("/departments/{id}")
    public ApiResult delete(@PathVariable @NotNull Integer id) throws Exception {
        return deptService.deleteDept(id);
    }

}
