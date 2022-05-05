package com.chensh.ssm.emp.controller;

import com.chensh.ssm.emp.pojo.Department;
import com.chensh.ssm.emp.service.DeptService;
import com.chensh.ssm.emp.utils.ViewResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/5/3 16:36
 */

@RestController
public class DeptController {

    @Autowired
    private DeptService deptService;

    @GetMapping("/dept")
    public List<Department> queryAllDept(){
        return deptService.getDeptList();
    }

    @DeleteMapping("/dept/{id}")
    public ViewResult deleteDeptById(@PathVariable("id") Integer id){
        if (deptService.delDeptById(id)) {
            return ViewResult.success("删除成功");
        }else{
            return ViewResult.fail("删除失败！");
        }
    }

}
