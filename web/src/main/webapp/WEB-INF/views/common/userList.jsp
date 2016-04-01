<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
    <p>当前位置：技术管理&gt;&gt;用户管理</p>
    <div style="margin:10px 0;" id="search-bar">
        <label>账号：</label>
        <input class="easyui-textbox" id="userName" data-options="prompt:'用户账号'" style="width:200px;height:36px"/>
        <a href="#" class="easyui-linkbutton search-btn" data-options="iconCls:'icon-search'" style="width:80px;height:36px" onclick="javascript:reloadGrid();">搜索</a>
    </div>
    <table id="dataTable" style="height:600px;"></table>
    <div id="dd">
        <input type="hidden" id="userId">

        <table id="roleTable"></table>

    </div>
</body>
<script type="text/javascript">

    $(function(){

        $("#search-bar").bind("keyup",function(e){
            if(e.keyCode == 13){
                $(".search-btn").click();
            }
        });

        $('#dataTable').datagrid({
            toolbar:[{
                iconCls: 'icon-add',
                text:'添加用户',
                handler:function(){
                    window.location.href = "${ctx}/common/user/edit";
                }
            }],
            url:'${ctx}/common/user/listData',
            columns:[[
                {field:'name',title:'账号',width:'30%'},
                {field:'createTime',title:'创建时间',width:'30%',formatter:function(value,row,index){
                    return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                }},
                {field:'_operate',title:'操作',width:'40%',formatter:function(value,row,index){
                    var htm = "<a class='easyui-linkbutton' href='${ctx}/common/user/edit?id="+row.id+"'>编辑</a>";
                    htm += "&nbsp;&nbsp;&nbsp;<a class='easyui-linkbutton' href='javascript:del("+row.id+")'>删除</a>";
                    htm += "&nbsp;&nbsp;&nbsp;<a class='easyui-linkbutton' href='javascript:editRole("+row.id+")'>设置角色</a>";
                    htm += "&nbsp;&nbsp;&nbsp;<a class='easyui-linkbutton' href='javascript:resetPwd();'>重置密码</a>";
                    return htm;
                }}
            ]],
            singleSelect:true,
            rownumbers:true,
            pagination:true
        });

        $('#dd').dialog({
            title: '设置角色',
            width: 600,
            height: 400,
            closed: true,
            cache: false,
            modal: true,
            buttons:[
                {
                    text:"保存",
                    handler:function(){
                        saveRole();
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

        $('#roleTable').datagrid({
            url:'${ctx}/common/role/list',
            columns:[[
                {field:'_checkbox',title:'',width:'25%',checkbox:true},
                {field:'name',title:'角色名',width:'25%'},
                {field:'code',title:'角色代码',width:'25%'},
                {field:'descr',title:'角色描述',width:'25%'}
            ]],
            rownumbers:true,
            pageSize:50,
            pagination:true
        });


    })

    function editRole(userId){
        $('#dd').dialog("open");
        $("#userId").val(userId);

        /**加载用户角色*/
        $.ajax({
            type:'post',
            url:'${ctx}/common/role/getRoles/'+userId,
            dataType:'json',
            success:function(data){
                var rows = $('#roleTable').datagrid("getRows");
                var slkdIds = [];
                for(var j in data) slkdIds.push(data[j]['id']);

                for(var i=0; i<rows.length;i++){
                    var rowIndex = $('#roleTable').datagrid("getRowIndex",rows[i]);
                    if(slkdIds.indexOf(rows[i]['id']) > -1){
                        $('#roleTable').datagrid("checkRow",rowIndex);
                    }else{
                        $('#roleTable').datagrid("uncheckRow",rowIndex);
                    }
                }
            }
        });

    }

    function saveRole(){
        var chks = $('#roleTable').datagrid("getChecked");
        var roleIdArr = [];
        for(var i=0; i<chks.length;i++){
            roleIdArr.push(chks[i]['id']);
        }
        $.ajax({
            type:'post',
            url:'/common/role/saveRole',
            dataType:'json',
            data:{roleIds:roleIdArr.join(','),userId:$("#userId").val()},
            success:function(data){
                alert("操作成功");
            },
            error:function(err){
                alert("操作失败");
            }
        });
    }

    function reloadGrid(){
        $('#dataTable').datagrid("load",{
            name:$("#userName").val()
        });
    }

    function del(id){
        if(!confirm("确认删除吗")) return;
        $.ajax({
            type:'get',
            url:'${ctx}/common/user/del/'+id,
            dataType:'json',
            success:function(data){
                alert(data.msg);
                $('#dataTable').datagrid("reload");
            },
            error:function(err){
                alert("服务器内部错误");
            }
        });
    }

</script>
</html>