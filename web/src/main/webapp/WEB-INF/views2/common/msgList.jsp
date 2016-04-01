<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>消息管理</title>
    <script type="text/javascript">
        $(function(){
            $('#dataTable').bootstrapTable({
                url:'${ctx}/common/msg/list',
                method:'post',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'busType',title:'业务类型',width:'10%',formatter:function(value,row,index){
                        if(value == 1){
                            return "版本更新";
                        }else if(value == 2){
                            return "评论奖励";
                        }
                    }},
                    {field:'showType',title:'消息类型',width:'10%',formatter:function(value,row,index){
                        if(value == 1){
                            return "通知";
                        }else{
                            return "透传消息";
                        }
                    }},
                    {field:'title',title:'标题',width:'20%'},
                    {field:'content',title:'内容',width:'30%'},
                    {field:'createTime',title:'创建时间',width:'15%',formatter:function(value,row,index){
                        return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                    }},
                    {field:'_operate',title:'操作',width:'15%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-default btn-sm' href='${ctx}/common/msg/edit?id="+row.id+"'>编辑</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-danger btn-sm'  href='javascript:del("+row.id+")'>删除</a>";
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
                    return params;
                },
                onLoadError:function(){
                    showErr("加载失败");
                }
            });
        })

        function reloadGrid(){
            $('#dataTable').bootstrapTable("refresh");
        }

        function del(id){
            showConfirm("确认提示","确认删除吗？",function(){
                $.ajax({
                    type:'get',
                    url:'${ctx}/common/msg/del/'+id,
                    dataType:'json',
                    success:function(data){
                        showInfo(data.msg);
                        reloadGrid();
                    },
                    error:function(err){
                        showErr("服务器内部错误");
                    }
                });
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
                        系统管理
                    </li>
                </ol>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            系统消息
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <a href="${ctx}/common/msg/edit" class="btn btn-success" style="margin-right:160px;"><span class="glyphicon glyphicon-plus"></span>添加</a>
                        </div>
                        <table id="dataTable"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>