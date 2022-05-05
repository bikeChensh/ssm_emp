package com.chensh.ssm.emp.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Department implements Serializable {

    private static final long serialVersionUID = -68497907233367710L;
    private Integer deptId;

    private String deptName;

    private Integer deptState;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

    public Integer getDeptState() {
        return deptState;
    }

    public void setDeptState(Integer deptState) {
        this.deptState = deptState;
    }


}