<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/demo/demo.css">
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script> <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/common.js"></script>
    <style type="text/css">
    </style>
</head>
<body>
    <p>当前位置：技术管理&gt;&gt;角色管理</p>
    <table id="dataTable" style="height:600px;"></table>
    <div id="dd">
        <input type="hidden" id="roleId">
        <div id="resTree"></div>
    </div>

    <div id="dlg_edit">
        <form id="ff" class="easyui-form" method="post" data-options="novalidate:true">
            <input type="hidden" id="role_id" name="id">
            <table cellpadding="5">
                <tr>
                    <td>角色名:</td>
                    <td><input class="easyui-textbox" type="text" id="roleName" name="name" value="${obj.name}" data-options="required:true" style="width:200px;height:36px"/></td>
                </tr>
                <tr>
                    <td>角色code:</td>
                    <td><input class="easyui-textbox" type="text" id="roleCode"  name="code" value="${obj.code}" data-options="required:true" style="width:200px;height:36px"/></td>
                </tr>
                <tr>
                    <td>描述:</td>
                    <td><input class="easyui-textbox" type="text" id="roleDescr" name="descr" value="${obj.descr}" style="width:200px;height:36px"/></td>
                </tr>
            </table>
        </form>

    </div>
</body>
<script type="text/javascript">

    $(function(){
        $('#dataTable').datagrid({
            toolbar:[{
                iconCls: 'icon-add',
                text:'添加角色',
                handler:function(){
                    showEditRole();
                }
            }],
            url:'/common/role/list',
            columns:[[
                {field:'name',title:'角色名',width:'25%'},
                {field:'code',title:'角色代码',width:'25%'},
                {field:'descr',title:'角色描述',width:'25%'},
                {field:'_operate',title:'操作',width:'25%',formatter:function(value,row,index){
                    var htm = "<a href='javascript:showEditRole("+row.id+")'>编辑</a>";
                    htm += "&nbsp;&nbsp;&nbsp;<a href='javascript:showRestree("+row.id+");'>设置权限</a>";
                    htm += "&nbsp;&nbsp;&nbsp;<a href='javascript:delRole("+row.id+");'>删除</a>";
                    return htm;
                }}
            ]],
            singleSelect:true,
            rownumbers:true,
            pagination:true
        });

        $('#dd').dialog({
            title: '设置权限',
            width: 400,
            height: 500,
            closed: true,
            cache: false,
            modal: true,
            buttons:[
                {
                    text:"保存",
                    handler:function(){
                        saveRoleResource();
                    }
                },
                {
                    text:"关闭",
                    handler:function(){
                        $('#dd').dialog("close");
                    }
                }
            ]
        });

        $('#dlg_edit').dialog({
            title: '添加角色',
            width: 420,
            height: 260,
            closed: true,
            cache: false,
            modal: true,
            buttons:[
                {
                    text:"保存",
                    handler:function(){
                        $('#ff').form("submit");
                    }
                },
                {
                    text:"关闭",
                    handler:function(){
                        $('#dlg_edit').dialog("close");
                    }
                }
            ]
        });


        $('#ff').form({
            url:'/common/role/saveOrUpdate',
            onSubmit: function(){
                return $(this).form('enableValidation').form('validate');
            },
            success:function(data){
                var data = eval("("+data+")");
                if(data.status == 200){
                    $('#dataTable').datagrid("reload");
                    $('#dlg_edit').dialog("close");
                }else{
                    alert("操作失败，请联系管理员");
                }
            }
        });

    })

    function showRestree(roleId){
        $('#resTree').tree({
            url: '/common/role/resTree/'+roleId,
            checkbox:true,
            onLoadSuccess:function(node, data){
            },
            onClick:function(node){

            }
        });
        $("#roleId").val(roleId);
        $('#dd').dialog("open");
    }

    function saveRoleResource(){
        var nodes = $('#resTree').tree("getChecked");
        var resIdArr = [];
        for(var i=0; i<nodes.length; i++){
            resIdArr.push(nodes[i]['id']);
            resIdArr.push(nodes[i]['pid']);
        }
        $.ajax({
            type:'post',
            url:'/common/role/saveRes',
            dataType:'json',
            data:{resIds:resIdArr.join(","),roleId:$("#roleId").val()},
            success:function(){
                alert("操作成功");
                $('#dd').dialog("close");
            },
            error:function(){
                alert("操作失败");
            }
        });
    }

    function showEditRole(roleId){
        if(roleId){ //修改
            $.ajax({
                type:'get',
                url:'${ctx}/common/role/getById/'+roleId,
                dataType:'json',
                success:function(data){
                    var dt = data.data;
                    if(dt){
                        $("#role_id").val(dt.id);
                        $("#roleName").textbox("setValue",dt.name);
                        $("#roleCode").textbox("setValue",dt.code);
                        $("#roleDescr").textbox("setValue",dt.descr);
                    }
                }
            });
            $('#dlg_edit').dialog("setTitle","修改角色");
        }else{ //新增
            $('#dlg_edit').dialog("setTitle","添加角色");
            $("#role_id").val("");
            $("#roleName").textbox("clear");
            $("#roleCode").textbox("clear");
            $("#roleDescr").textbox("clear");
        }
        $('#dlg_edit').dialog("open");
    }

    function delRole(id){
        if(!confirm("确认删除吗？")) return;
        $.ajax({
            type:'post',
            url:'${ctx}/common/role/del/'+id,
            dataType:'json',
            success:function(data){
                alert(data.msg);
                $('#dataTable').datagrid("reload");
            },
            error:function(err){
                alert("删除失败");
            }

        });

    }
</script>
</html>