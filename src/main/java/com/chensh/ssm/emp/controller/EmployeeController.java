package com.chensh.ssm.emp.controller;

import com.chensh.ssm.emp.pojo.Employee;
import com.chensh.ssm.emp.service.EmployeeService;
import com.chensh.ssm.emp.utils.ViewResult;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/4/30 15:29
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;


    @RequestMapping(value = "/emp",method = RequestMethod.GET)
    @ResponseBody
    public ViewResult queryEmp(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageInfo<Employee> empPageInfo = employeeService.getEmpList(pn);
        return ViewResult.success("处理成功").addData("empPageInfo",empPageInfo);
    }


    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public ViewResult deleteEmp(@PathVariable("id") Integer id){
        if (employeeService.deleteEmpById(id)) {
            return ViewResult.success("处理成功");
        }
        return ViewResult.fail("处理失败");
    }

    @PostMapping("/emp")
    @ResponseBody
    public ViewResult insertEmp(Employee emp){
        if (employeeService.insertEmp(emp)) {
            return ViewResult.success("添加成功");
        }
        return ViewResult.fail("添加失败！");
    }

    @PutMapping("/emp")
    @ResponseBody
    public ViewResult updateEmp(Employee emp){
        if (employeeService.modifyEmpById(emp)) {
            return ViewResult.success("修改成功");
        }
        return ViewResult.fail("修改失败！");
    }

}
