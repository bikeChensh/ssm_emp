package com.chensh.ssm.emp.service;

import com.chensh.ssm.emp.mapper.EmployeeMapper;
import com.chensh.ssm.emp.pojo.Employee;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/4/30 14:19
 */
@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 分页查询
     * @param pageCurrent
     * @return
     */
    public PageInfo<Employee> getEmpList(Integer pageCurrent){
        PageHelper.startPage(pageCurrent,5);
        List<Employee> empList = employeeMapper.selectEmpWithDept(null);
        PageInfo<Employee> empPageInfo = new PageInfo<>(empList,5);
        return empPageInfo;
    }

    /**
     * 根据编号查询employee
     * @param id
     * @return
     */
    public Employee getEmpById(Integer id){
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 添加一条employee记录
     * @param emp
     * @return
     */
    public boolean insertEmp(Employee emp){
        return employeeMapper.insertSelective(emp)>0;
    }

    /**
     * 根据id 修改一条记录
     * @param emp
     * @return
     */
    public boolean modifyEmpById(Employee emp){
        return employeeMapper.updateByPrimaryKeySelective(emp)>0;
    }

    /**
     * 根据编号删除一条记录
     * @param id
     * @return
     */
    public boolean deleteEmpById(Integer id){
        return employeeMapper.deleteByPrimaryKey(id)>0;
    }



}
