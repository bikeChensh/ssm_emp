
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


<div class="container">
    <div class="row">
        <div>
            <h2>部门管理</h2>
        </div>
    </div>
    <%--内容显示--%>
    <div class="row">
        <div class="col-md-6">
            <table class="table table-hover" id="dept_table">
                <tr>
                    <th column_name="deptId">#</th>
                    <th column_name="deptName">部门名称</th>
                    <th column_name="deptState">部门状态</th>
                    <th>删除</th>
                </tr>
            </table>
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
            url:"${APP_PATH}/dept",
            type:"GET",
            data:{pn:pn},
            dataType:"JSON",
            success:function(result){
                table_view(result);
            }
        });
    }

    //处理数据页面显示
    function table_view(list){
        var $empTable = $("#dept_table");
        $.each(list,function(index,item){
            var $tr = $("<tr>");
            $empTable.find("th[column_name]").each(function(i,name){
                var columnName = $(name).attr("column_name");
                var $td = $("<td>");
                $td.text(item[columnName]);
                $tr.append($td);
            });
            var  $delBtn = $("<button><span class='glyphicon glyphicon-trash' aria-hidden='true'></span> 删除</button>");
            $delBtn.addClass("btn btn-primary btn-sm");
            $delBtn.attr("dept_id",item.deptId);
            $delBtn.click(function(){
                const deptId = $(this).attr("dept_id");
                console.log(deptId);
                if (!confirm("确定要删除么？")){
                    return false;
                }
                var target = $(this);
                $.ajax({
                    url:"${APP_PATH}/dept/"+deptId,
                    type: "delete",
                    dataType: "JSON",
                    success: function(result){
                        if (result.status) {
                            alert(result.message);
                            target.parents("tr").remove();
                        }else{
                            alert(result.message);
                        }
                    },
                    error:function(){
                        alert("服务器异常！")
                    }
                });
            });
            var dtd = $("<td>");
            dtd.append($delBtn);
            $tr.append(dtd);
            $empTable.append($tr);
        });
    }

</script>
</html>
