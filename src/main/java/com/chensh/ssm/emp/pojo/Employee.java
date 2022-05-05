package com.chensh.ssm.emp.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Employee implements Serializable {
    private static final long serialVersionUID = -6849790754667710L;

    private Integer empId;

    private Integer deptId;

    private String empName;

    private String empSex;

    private String empDuty;

    private Department dept;


    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpSex() {
        return empSex;
    }

    public void setEmpSex(String empSex) {
        this.empSex = empSex == null ? null : empSex.trim();
    }

    public String getEmpDuty() {
        return empDuty;
    }

    public void setEmpDuty(String empDuty) {
        this.empDuty = empDuty == null ? null : empDuty.trim();
    }
}