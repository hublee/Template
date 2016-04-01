<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <script type="text/javascript">
        $(function(){
            $('#dataTable').bootstrapTable({
                method:'post',
                url:'${ctx}/common/role/list',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'name',title:'角色名',width:'25%'},
                    {field:'code',title:'角色代码',width:'25%'},
                    {field:'descr',title:'角色描述',width:'25%'},
                    {field:'_operate',title:'操作',width:'25%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-default btn-sm disabled' href='/common/role/edit?id="+row.id+"'>编辑</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-primary btn-sm' href='javascript:showUsers("+row.id+");'>查看用户</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-warning btn-sm' href='javascript:showRestree("+row.id+");'>设置权限</a>";
                        return htm;
                    }}
                ]],
                singleSelect:true,
                rownumbers:true,
                pagination:true,
                queryParamsType:'ps',
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    return params;
                },
                showPaginationSwitch:true,
                showColumns:true,
                showRefresh:true,
                showToggle:true,
                toolbar:$("#toolbar"),
                onLoadError:function(){
                    showErr("加载失败");
                }
            });

        })

        function getTreeData(roleId){
            var treeData;
            $.ajax({
                async:false,
                type:'post',
                url:'${ctx}/common/role/resTree/'+roleId,
                dataType:'json',
                success:function(data){
                    treeData = data;
                    //转换easyui tree 为 bootstrap tree view
                    for(var i in treeData){
                        treeData[i]['nodes'] = treeData[i]['children'];
                        treeData[i]['children'] = null;
                        for(var j in  treeData[i]['nodes']){
                            treeData[i]['nodes'][j]['nodes'] = treeData[i]['nodes'][j]['children'];
                            treeData[i]['nodes'][j]['children'] = null;
                            treeData[i]['nodes'][j]['state'] = {};
                            if(treeData[i]['nodes'][j]['checked']){
                                treeData[i]['nodes'][j]['state']['checked'] = true;
                                treeData[i]['nodes'][j]['state']['selected'] = true;
                            }

                            for(var k in treeData[i]['nodes'][j]['nodes']){
                                treeData[i]['nodes'][j]['nodes'][k]['nodes'] = treeData[i]['nodes'][j]['nodes'][k]['children'];
                                treeData[i]['nodes'][j]['nodes'][k]['children'] = null;
                                console.log("节点状态--" + treeData[i]['nodes'][j]['nodes'][k]['checked']);
                                treeData[i]['nodes'][j]['nodes'][k]['state'] = {};
                                if(treeData[i]['nodes'][j]['nodes'][k]['checked']){
                                    treeData[i]['nodes'][j]['nodes'][k]['state']['checked'] = true;
                                    treeData[i]['nodes'][j]['nodes'][k]['state']['selected'] = true;
                                }
                            }
                            if(treeData[i]['nodes'][j]['checked']){
                                treeData[i]['nodes'][j]['state']['checked'] = true;
                                treeData[i]['nodes'][j]['state']['selected'] = true;
                            }

                        }
                        treeData[i]['state'] = {};
                        if(treeData[i]['checked']){
                            treeData[i]['state']['checked'] = true;
                            treeData[i]['state']['selected'] = true;
                        }
                    }
                },
                error:function(err){
                    showErr("加载失败");
                }
            });
            return treeData;
        }

        function showRestree(roleId){
            $("#roleId").val(roleId);
            var tdata = getTreeData(roleId);
            dlgWithBtn("设置角色权限",'<div id="resTree"></div>',function(){
                saveRoleResource();
            });
            $('#resTree').treeview({
                data:tdata,
//                levels: 5, //默认展开的层级数
                showCheckbox:true
            });
        }

        function saveRoleResource(){
            var nodes = $('#resTree').treeview("getChecked");
            var resIdArr = [];
            for(var i=0; i<nodes.length; i++){
                resIdArr.push(nodes[i]['id']);
                resIdArr.push(nodes[i]['pid']);
            }
            console.log(resIdArr);
            $.ajax({
                type:'post',
                url:'/common/role/saveRes',
                dataType:'json',
                data:{resIds:resIdArr.join(","),roleId:$("#roleId").val()},
                success:function(data){
                    showInfo(data.msg);
                    closeDlg();
                },
                error:function(){
                    showErr("服务器内部错误，请联系管理员");
                    closeDlg();
                }
            });
        }

        function showUsers(roleId){
            dlgNoBtn("查看角色用户",'<table id="userTable"></table>');
            $('#userTable').bootstrapTable({
                method:'get',
                url:'${ctx}/common/role/getUsers/'+roleId,
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {field:'name',title:'用户名',width:'25%'},
                    {field:'nickName',title:'昵称',width:'25%'},
                    {field:'_operate',title:'操作',width:'10%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-danger btn-sm'  href='javascript:removeRole("+roleId+","+row.id+")'>移除</a>";
                        return htm;
                    }}
                ]],
                rownumbers:true,
                singleSelect:true,
                pageSize:20,
                pagination:true,
                queryParamsType:'ps',
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    return params;
                }
            });
        }

        function removeRole(roleId,userId){
            showConfirm("确认提示","确认从该权限组移除该用户吗？",function(){
                $.ajax({
                    type:'post',
                    url:'${ctx}/common/role/removeUserRole/'+userId+"/"+roleId,
                    dataType:'json',
                    success:function(data){
                        $('#userTable').bootstrapTable("refresh");
                        showInfo(data.msg);
                    },
                    error:function(err){
                        $('#userTable').bootstrapTable("refresh");
                        showErr("操作失败");
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
                            角色管理
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <a href="javascript:void(0);" class="btn btn-success disabled" style="margin-right:160px;"><span class="glyphicon glyphicon-plus"></span>添加</a>
                        </div>
                        <table id="dataTable"></table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div id="dd">
                <input type="hidden" id="roleId">
            </div>
        </div>

    </div>


</body>
</html>