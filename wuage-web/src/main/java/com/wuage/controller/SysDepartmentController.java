package com.wuage.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wuage.Result.ApiResult;
import com.wuage.Result.ResultCode;
import com.wuage.annotation.LogInfo;
import com.wuage.annotation.RepeatSubmit;
import com.wuage.entity.Dept;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.service.DeptService;
import com.wuage.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Objects;

@RestController
@Validated
@RequestMapping("/system")
public class SysDepartmentController extends BaseController {

    @Autowired
    private DeptService deptService;

    @Autowired
    private UserService userService;

    @Autowired
    private EhCacheManager ehCacheManager;

//    @Autowired
//    private SuperAdmins superAdmins;

    @RequiresPermissions("system:dept:view")
    @GetMapping("/departments")
    public ApiResult getDepartments(@ModelAttribute PageInfo pageInfo) throws Exception{


        User loginuser = (User) SecurityUtils.getSubject().getPrincipal();

//        if(superAdmins.isSuperAdmin(loginuser.getUserId())){

        List<Dept> departments = deptService.getAllDepartments(pageInfo);

        return new ApiResult(ResultCode.SUCCESS,departments);
//        }

//        return ApiResult.success();

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


        Dept dept = deptService.getById(id);

        if(Objects.isNull(dept)){
            return  new ApiResult(ResultCode.ILLEGAL_PARAMETER);
        }

        if(deptService.hasChildren(id)>0){
            return  ApiResult.fail("该部门存在子部门，无法删除!");
        }
         List<User> users = userService.list(new QueryWrapper<User>()
                 .lambda().eq(User::getDeptId, dept.getDeptId()));

        if(!users.isEmpty()){

            return ApiResult.fail("仍有用户属于该部门，无法删除！");
        }

        return deptService.deleteDept(id);
    }

}
