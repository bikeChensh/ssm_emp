
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
<%--员工信息模块框--%>
<div class="modal fade" id="emp_info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_form">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="员工姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empDuty" class="col-sm-2 control-label">员工职务:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empDuty" name="empDuty" placeholder="员工职务">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性别:</label>
                        <div class="col-sm-10">
                            <label class="male">
                                <input type="radio" name="empSex" checked id="male" value="男"> 男
                            </label>
                            <label class="female">
                                <input type="radio" name="empSex" id="female" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept"  class="col-sm-2 control-label">员工部门:</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dept">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div>
            <h2>员工管理</h2>
        </div>
    </div>
    <%--操作--%>
    <div class="row">
        <div class="text-right">
            <button class="btn btn-success" id="add_emp_modal" method="add">添加</button>
            <p> </p>
        </div>
    </div>
    <%--内容显示--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                    <tr>
                        <th column_name="empId">#</th>
                        <th column_name="dept">所在部门</th>
                        <th column_name="empName">员工姓名</th>
                        <th column_name="empSex">员工性别</th>
                        <th column_name="empDuty">员工职务</th>
                        <th>修改</th>
                        <th>删除</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <div class="col-md-6" >
            <p id="page_info"></p>
        </div>
        <div class="col-md-6 text-right">
            <nav aria-label="Page navigation">
                <ul class="pagination" id="page_num">
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>

<script>

    $(function(){
        empPageInfo(1);
    });
    function empPageInfo(pn){
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"GET",
            data:{pn:pn},
            dataType:"JSON",
            success:function(result){
                table_view(result.data.empPageInfo.list);
                pageInfo(result.data.empPageInfo);
            }
        });
    }
    /*分页信息*/
    function pageInfo(pageInfo){
        $("#page_info").empty().append("当前"+pageInfo.pageNum+"页，总"+pageInfo.pages+"页，总记录"+pageInfo.total+"条");
        var pageNav = $("#page_num");
        pageNav.empty();
        if (pageInfo.hasPreviousPage){
            $("<li>").append("<span>首页<span>")
                .click(function (){empPageInfo(1);})
                .appendTo(pageNav);
            $("<li>").append("<span aria-hidden='true'>&laquo;</span>")
                .click(function(){empPageInfo(pageInfo.pageNum-1);})
                .appendTo(pageNav);
        }
        $.each(pageInfo.navigatepageNums,function (index,item){
            $("<li>").append($("<span>"+item+"<span>"))
                .addClass(pageInfo.pageNum==item ? "active":"")
                .click(function (){empPageInfo(item);})
                .appendTo(pageNav);
        });
        if (pageInfo.hasNextPage){
            $("<li>").append("<span>末页<span>")
                .click(function (){empPageInfo(pageInfo.pages);})
                .appendTo(pageNav);
            $("<li>").append("<span aria-hidden='true'>&raquo;</span>")
                .click(function(){empPageInfo(pageInfo.pageNum+1);})
                .appendTo(pageNav);
        }
    }

    //处理数据页面显示
    function table_view(list){
        var $empTable = $("#emp_table tbody");
        $empTable.children().remove();
        $.each(list,function(index,item){
            var $tr = $("<tr>");
            $("#emp_table").find("th[column_name]").each(function(i,name){
                var columnName = $(name).attr("column_name");
                var $td = $("<td>");
                if (columnName=="dept"){
                    $td.text(item.dept.deptName);
                }else{
                    $td.text(item[columnName]);
                }
                $tr.append($td);
            });
            var  $modifyBtn = $("<button><span class='glyphicon glyphicon-pencil' aria-hidden='true'></span> 修改</button>");
            $modifyBtn.addClass("btn btn-success btn-sm");
            $modifyBtn.attr("emp_id",item.empId);
            $modifyBtn.click(function(){
                var empId = $(this).attr("emp_id");
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type: "GET",
                    dataType: "JSON",
                    success: function(result){
                        console.log(result);
                    }
                });
            });
            var  $delBtn = $("<button><span class='glyphicon glyphicon-trash' aria-hidden='true'></span> 删除</button>");
            $delBtn.addClass("btn btn-primary btn-sm");
            $delBtn.attr("emp_id",item.empId);
            $delBtn.click(function(){
                var empId = $(this).attr("emp_id");
                if (!confirm("确定要删除么？")){
                    return false;
                }
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type: "delete",
                    dataType: "JSON",
                    success: function(result){
                        if (result.status) {
                            alert("删除成功！");
                            $(this).parents("tr").remove();
                        }else{
                            alert("删除失败！");
                        }
                    },
                    error:function(){
                        alert("服务器异常！")
                    }
                });
            });
            var mtd = $("<td>");
            mtd.append($modifyBtn);
            var dtd = $("<td>");
            dtd.append($delBtn);
            $tr.append(mtd).append(dtd);
            $empTable.append($tr);
        });
    }

    /*新增*/
    $("#add_emp_modal").click(function(){

        $("#emp_info").modal({
            backdrop : "static"
        });
        document.getElementById("emp_form").reset();
        getDept();
        $("#save_emp").attr("method","POST");
    });

    function getDept(){
        $.ajax({
            url:"${APP_PATH}/dept",
            type:"GET",
            dataType:"JSON",
            success:function(result){
                var dept = $("#dept");
                dept.children().remove();
                $.each(result,function(i,e){
                    dept.append("<option value='"+e.deptId+"'>"+e.deptName+"</option>")
                });
            }
        });
    }

    //新增employee信息
    $("#save_emp").click(function(){

        saveEmp($(this).attr("method"));
    });
    function saveEmp(method){
        var emp_info = $("#emp_form").serialize();
        console.log(emp_info);
        $.ajax({
            url :"${APP_PATH}/emp",
            type : method,
            data: emp_info,
            dataType : "JSON",
            success :function(result){
                if (result.status){
                    $("#emp_info").modal('hide');
                }else{
                    alert(result.message);
                }
            },
            error : function(){
                alert("服务器异常!");
            }
        });
    }

</script>
</html>
