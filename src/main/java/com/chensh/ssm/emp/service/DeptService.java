package com.chensh.ssm.emp.service;

import com.chensh.ssm.emp.mapper.DepartmentMapper;
import com.chensh.ssm.emp.pojo.Department;
import com.chensh.ssm.emp.pojo.DepartmentExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/5/3 16:38
 */
@Service
public class DeptService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDeptList(){
        DepartmentExample example = new DepartmentExample();
        example.createCriteria().andDeptStateEqualTo(0);
        return departmentMapper.selectByExample(example);
    }


    public boolean delDeptById(Integer id){
        Department department = new Department();
        department.setDeptId(id);
        department.setDeptState(1);
        return departmentMapper.updateByPrimaryKeySelective(department)>0;
    }

}
