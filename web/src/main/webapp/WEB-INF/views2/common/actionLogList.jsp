<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>游戏管理</title>
    <script type="text/javascript">
        $(function(){
            $('#dataTable').bootstrapTable({
                url:'${ctx}/common/actionLog/list',
                method:'post',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'actionDescr',title:'行为',width:'25%'},
                    {field:'userName',title:'账号',width:'25%'},
                    {field:'createTime',title:'时间',width:'25%',formatter:function(value,row,index){
                        return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                    }},
                    {field:'_operate',title:'操作',width:'25%',formatter:function(value,row,index){
                        var htm = "";
                        if(row.isEnable == 1){
                            htm = "<a class='btn btn-danger btn-sm' href='javascript:disableUser("+row.userId+",0)'>禁止登陆</a>";
                        }else{
                            htm = "<a class='btn btn-success btn-sm' href='javascript:disableUser("+row.userId+",1)'>解除禁止</a>";
                        }
                        return htm;
                    }}
                ]],
                singleSelect:true,
                rownumbers:true,
                pagination:true,
                queryParamsType:'ps',
                showPaginationSwitch:true,
                showColumns:true,
                showRefresh:true,
                showToggle:true,
                toolbar:$("#toolbar"),
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    params.order = " create_time DESC ";
                    params.actionDescr = $("#actionDescr").val();
                    params.userName = $("#userName").val();
                    return params;
                },
                onLoadError:function(){
                    showErr("加载失败");
                }
            });
        })

        function disableUser(userId,isEnable){
            var msg = isEnable == 1 ? "解禁" : "禁用";
            if(!confirm("确定"+msg+"该用户吗？")) return;
            $.ajax({
                type:'post',
                url:'${ctx}/common/user/disable/'+isEnable+'/'+userId,
                dataType:'json',
                success:function(data){
                    showInfo(data.msg);
                    $('#dataTable').bootstrapTable("refresh");
                },
                error:function(err){
                    showErr("服务器内部错误，请联系管理员");
                }
            });
        }
        function reloadGrid(){
            $('#dataTable').bootstrapTable("refresh",{
                actionDescr:$("#actionDescr").val(),
                userName:$("#userName").val()
            });
        }
    </script>
</head>
<body>
    <div class="">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li class="active">
                        技术管理
                    </li>
                </ol>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            操作日志
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <form class="form-inline" role="form" id="searchForm" style="float:right;">
                                <div class="form-group">
                                    <label for="actionDescr">行为</label>
                                    <input type="text" class="form-control" id="actionDescr" placeholder="用户行为" onchange="reloadGrid();">
                                </div>
                                <div class="form-group">
                                    <label for="userName">账号</label>
                                    <input type="text" class="form-control" id="userName" placeholder="用户行为" onchange="reloadGrid();">
                                </div>
                            </form>
                        </div>
                        <table id="dataTable"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>