<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>游戏管理</title>
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
    <p>当前位置：技术管理&gt;&gt;操作日志</p>

    <div style="margin:10px 0;" id="search-bar">
        <label>行为：</label>
        <input class="easyui-textbox" id="actionDescr" data-options="prompt:'行为'" style="width:200px;height:36px"/>
        <label>账号：</label>
        <input class="easyui-textbox" id="userName" data-options="prompt:'用户账号'" style="width:200px;height:36px"/>
        <a href="#" class="easyui-linkbutton search-btn" data-options="iconCls:'icon-search'" style="width:80px;height:36px" onclick="javascript:reloadGrid();">搜索</a>
    </div>

    <table id="dataTable" style="height:600px;"></table>
</body>
<script type="text/javascript">
    $(function(){

        $("#search-bar").bind("keyup",function(e){
            if(e.keyCode == 13){
                $(".search-btn").click();
            }
        });

        $('#dataTable').datagrid({
            url:'${ctx}/common/actionLog/list',
            columns:[[
                {field:'busName',title:'业务模块',width:'15%'},
                {field:'actionDescr',title:'行为',width:'25%'},
                {field:'userName',title:'账号',width:'10%'},
                {field:'createTime',title:'时间',width:'25%',formatter:function(value,row,index){
                    return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                }},
                {field:'_operate',title:'操作',width:'25%',formatter:function(value,row,index){
                    var htm = "";
                    if(row.isEnable == 1){
                        htm = "<a class='easyui-linkbutton' href='javascript:disableUser("+row.userId+",0)'>禁止登陆</a>";
                    }else{
                        htm = "<a class='easyui-linkbutton' href='javascript:disableUser("+row.userId+",1)'>解除禁止</a>";
                    }
                    return htm;
                }}
            ]],
            singleSelect:true,
            rownumbers:true,
            pagination:true
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
                alert(data.msg);
                $('#dataTable').datagrid("reload");
            },
            error:function(err){
                alert("服务器内部出错");
            }
        });
    }

    function reloadGrid(){
        $('#dataTable').datagrid("load",{
            actionDescr:$("#actionDescr").val(),
            userName:$("#userName").val()
        });
    }

</script>
</html>