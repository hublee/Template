<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <script type="text/javascript">
        $(function(){
            $('#dataTable').bootstrapTable({
                method:'post',
                url:'${ctx}/common/user/listData',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'name',title:'账号',width:'20%'},
                    {field:'nickName',title:'昵称',width:'20%'},
                    {field:'createTime',title:'创建时间',width:'10%',formatter:function(value,row,index){
                        return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                    }},
                    {field:'_operate',title:'操作',width:'20%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-default btn-sm' href='${ctx}/common/user/edit?id="+row.id+"'><span class='glyphicon glyphicon-edit'></span>编辑</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-danger btn-sm' href='javascript:del("+row.id+")'><span class='glyphicon glyphicon-remove'></span>删除</a>";
                        htm += "&nbsp;&nbsp;&nbsp;<a class='btn btn-primary btn-sm' href='javascript:editRole("+row.id+")'>设置角色</a>";
                        htm += "&nbsp;&nbsp;&nbsp;<a class='btn btn-warning btn-sm' href='javascript:resetPwd("+row.id+");'>重置密码</a>";
                        return htm;
                    }}
                ]],
                singleSelect:true,
                rownumbers:true,
                pagination:true,
                pageSize:10,
                queryParamsType:'ps',
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    if(params.searchText) {
                        params.name = params.searchText;
                    }
                    return params;
                },
                showPaginationSwitch:true,
                showColumns:true,
                showRefresh:true,
                showToggle:true,
                toolbar:$("#toolbar"),
                onLoadError:function(){
                    showErr("加载失败");
                },
                search:true
            });

            var modalContent = '<div id="roleAlert" class="alert alert-danger" style="display:none;">';
            modalContent += '<a href="#" class="close" data-dismiss="alert">&times;</a>';
            modalContent += '<strong>必须选择至少一行！</strong></div><table id="roleTable" class="roleTable"></table>';
            $("#myModal .modal-body").html(modalContent);
            $("#btn-save").bind("click",saveRole);
            initRoleTable();

        })

        function initRoleTable(){
            $("#roleTable").bootstrapTable("destroy");
            $("#roleTable").bootstrapTable({
                method:'post',
                url:'${ctx}/common/role/list',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'_checkbox',title:'',width:'25%',checkbox:true},
                    {field:'name',title:'角色名',width:'25%'},
                    {field:'code',title:'角色代码',width:'25%'},
                    {field:'descr',title:'角色描述',width:'25%'}
                ]],
                rownumbers:true,
                pageSize:50,
//                pagination:true,
                queryParamsType:'ps',
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    return params;
                },
                onLoadError:function(){
                    showErr("加载失败");
                }
            });
        }

        function editRole(userId){
            $("#myModalLabel").html("设置用户角色");
            $("#roleAlert").css("display","none");
            $("#myModal").modal("show");
            $("#roleTable").bootstrapTable("uncheckAll");
            /**加载用户角色*/
            var slkdIds = [];
            $.ajax({
                async:false,
                type:'post',
                url:'${ctx}/common/role/getRoles/'+userId,
                dataType:'json',
                success:function(data){
                    for(var j in data) slkdIds.push(data[j]['id']);
                    $('#roleTable').bootstrapTable("checkBy",{field:"id",values:slkdIds});
                },
                error:function(err){
                    showErr("加载用户角色失败！");
                }
            });
            $("#userId").val(userId);
        }

        function saveRole(){
            var chks = $('#roleTable').bootstrapTable("getSelections");
            console.log(chks.length);
            if(chks.length <= 0){
                $("#roleAlert").css("display","block");
                return;
            }
            var roleIdArr = [];
            for(var i=0; i<chks.length;i++){
                roleIdArr.push(chks[i]['id']);
            }
            console.log(roleIdArr);
            $.ajax({
                type:'post',
                url:'/common/role/saveRole',
                dataType:'json',
                data:{roleIds:roleIdArr.join(','),userId:$("#userId").val()},
                success:function(data){
                    closeDlg();
                    if(data.status == "200"){
                        showInfo(data.msg);
                    }else{
                        showErr("服务器内部错误，请联系管理员");
                    }
                },
                error:function(err){
                    showErr("操作失败！");
                    closeDlg();
                }
            });
        }

        function reloadGrid(){
            $('#dataTable').bootstrapTable("refresh",{
                name:$("#userName").val()
            });
        }

        function del(id){
            showConfirm("确认提示","确认删除吗？",function(){
                $.ajax({
                    type:'get',
                    url:'${ctx}/common/user/del/'+id,
                    dataType:'json',
                    success:function(data){
                        showInfo(data.msg);
                        $('#dataTable').bootstrapTable("refresh");
                    },
                    error:function(err){
                        showErr("服务器内部错误，请联系管理员");
                    }
                });
            });
        }

        function resetPwd(id){
            showConfirm("确认提示","确认重置密码吗？",function(){
                $.ajax({
                    type:'get',
                    url:'${ctx}/common/user/resetPwd/'+id,
                    dataType:'json',
                    success:function(data){
                        showInfo(data.msg);
                    },
                    error:function(err){
                        showErr("服务器内部错误，请联系管理员");
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
                            用户管理
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <a href="${ctx}/common/user/edit" class="btn btn-success" style="margin-right:160px;"><span class="glyphicon glyphicon-plus"></span>添加</a>
                        </div>
                        <table id="dataTable"></table>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="userId">
        <div class="row">
        </div>
    </div>
</body>
</html>