package com.wuage.service.impl;

import com.wuage.Result.ApiResult;
import com.wuage.entity.Dept;
import com.wuage.entity.User;
import com.wuage.entity.Vo.PageInfo;
import com.wuage.mapper.DeptMapper;
import com.wuage.service.DeptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wuage.utils.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 部门 服务实现类
 * </p>
 *
 * @author binblink
 * @since 2020-06-15
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Autowired
    private DeptMapper deptMapper;

    @Override
    public Integer hasChildren(Integer deptId) throws Exception {
        return deptMapper.hasChildren(deptId);
    }

    @Override
    public List<Dept> getAllDepartments(PageInfo pageInfo) throws Exception {

        List<Dept> depts = deptMapper.getAllDepartments(pageInfo);

        handlerDeptTree(depts);

        return depts;
    }

    @Override
    public List<Dept> getDeptFathers(Integer deptId) throws Exception {
        return deptMapper.getDeptFathers(deptId);
    }

    @Override
    public List<Dept> handlerDeptsToTree(List<Dept> depts) throws Exception {

        handlerDeptTree(depts);
        return depts;
    }

    /**
     * 添加部门
     *
     * @param dept
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult addDept(Dept dept) throws Exception {
        User user = (User) SecurityUtils.getSubject().getPrincipal();

        dept.setCtime(DateUtils.getNowDate());

        dept.setCreater(user.getUsername());

        deptMapper.insert(dept);

        return ApiResult.success();
    }

    /**
     * 更新部门
     * @param dept
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult updateDept(Dept dept) throws Exception {

        User user = (User) SecurityUtils.getSubject().getPrincipal();

        dept.setUpdateBy(user.getUsername());
        dept.setUpdateTime(DateUtils.getNowDate());

        deptMapper.updateById(dept);
        return ApiResult.success();

    }

    /**\
     * 删除部门
     * @param id
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public ApiResult deleteDept(Integer id) throws Exception {

       deptMapper.deleteById(id);
       return ApiResult.success();
    }

    /**
     * 递归遍历原始集合
     */
    private void handlerDeptTree(List<Dept> allDepts) {

        if (!allDepts.isEmpty()) {
            Dept start = null;
            for (int i = 0; i < allDepts.size(); i++) {
                Dept Dept = allDepts.get(i);
                if (!Dept.isTraversalOrNot()) {
                    start = Dept;
                    break;
                }
                if (i == allDepts.size() && Objects.isNull(start)) {
                    return;
                }
            }

            if (!Objects.isNull(start)) {

                List<Dept> reustlList = handlerDeptTreeData(start, allDepts);

                handlerDeptTree(reustlList);
            }
        }
    }

    /**
     * 递归处理形成树形结构, 递归遍历子节点
     * 配置mybatis 映射也可以直接得到树形结构的bean 但是会递归多次查询，不如放到内存中处理
     */
    private List<Dept> handlerDeptTreeData(Dept start, List<Dept> allDepts) {

        List<Dept> childrensList = new ArrayList<>();
        start.setTraversalOrNot(true);
        for (int i = 0; i < allDepts.size(); i++) {
            Dept dept = allDepts.get(i);
            if (dept.getDeptParentId().equals(start.getDeptId())) {
                childrensList.add(dept);
            }
        }

        if (!childrensList.isEmpty()) {
            for (Dept removeObj : childrensList) {
                allDepts.remove(removeObj);
            }

            for (Dept newstart : childrensList) {
                handlerDeptTreeData(newstart, allDepts);
            }
            start.setChildren(childrensList);
        }
        return allDepts;

    }


}
