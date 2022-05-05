package com.chensh.ssm.emp.test;

import com.chensh.ssm.emp.pojo.Employee;
import com.chensh.ssm.emp.service.EmployeeService;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/4/30 14:44
 *  测试dao层的工作
 *  * @author lfy
 *  *推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *  *1、导入SpringTest模块
 *  *2、@ContextConfiguration指定Spring配置文件的位置
 *  *3、直接autowired要使用的组件即可
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class EmpTest {

    @Autowired
    private EmployeeService employeeService;

    @Test
    public void queryEmp(){
        PageInfo<Employee> empList = employeeService.getEmpList(1);
        empList.getList().forEach(System.out::println);
    }

}
