package com.chensh.ssm.emp.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author cch
 * @version jdk1.8
 * @date 2022/4/30 15:59
 */
public class ViewResult {

    private Boolean status;

    private String message;
    private Map<String,Object> data = new HashMap<>();

    public static ViewResult success(String message){
        return getInstance(true,message);
    }

    public ViewResult addData(String key,Object value){
        this.getData().put(key,value);
        return this;
    }

    private static ViewResult getInstance(Boolean status,String message){
        ViewResult result = new ViewResult();
        result.setStatus(status);
        result.setMessage(message);
        return result;
    }

    public static ViewResult fail(String message){
        return getInstance(false,message);
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
