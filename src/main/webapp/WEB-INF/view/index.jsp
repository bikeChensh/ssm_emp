
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>首页</title>
    <script  src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
    <body>

        <div align="center" style="margin-top:  300px;">
            <a href="${APP_PATH}/empList" class="btn btn-primary" role="button">员工管理</a>
            <a href="${APP_PATH}/deptList" class="btn btn-success" role="button">部门管理</a>
        </div>
    </body>
</html>
