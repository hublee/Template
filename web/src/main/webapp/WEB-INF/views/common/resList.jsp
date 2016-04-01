<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>资源管理</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/demo/demo.css">
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script> <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/common.js"></script>
    <style type="text/css">
    </style>
</head>
<%--<p>当前位置：系统管理&gt;&gt;数据字典管理</p>--%>
<body class="easyui-layout">
    <div data-options="region:'west',title:'West',split:true" style="width:300px;">
        <ul id="dicTree"></ul>
    </div>
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;">
        <div class="easyui-panel" title="编辑字典" data-options="iconCls:'icon-save',tools:'#toolBar'">
            <div style="padding:10px 60px 20px 60px">
                <form id="ff" method="post">
                    <input type="hidden" value="${dic.id}" name="id" id="dic_id">
                    <table cellpadding="5">
                        <tr>
                            <td>资源名称:</td>
                            <td><input class="easyui-textbox" type="text" id="dicValue" name="name" style="width:360px;height:36px" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td>资源代码:</td>
                            <td><input class="easyui-textbox" type="text" id="dicKey" name="code" style="width:360px;height:36px" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td>资源路径:</td>
                            <td><input class="easyui-textbox" type="text" id="resUri" name="uri" style="width:360px;height:36px" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td>资源描述:</td>
                            <td><input class="easyui-textbox" type="text" id="resDescr" name="descr" style="width:360px;height:36px"/></td>
                        </tr>
                        <tr>
                            <td>父节点:</td>
                            <td>
                                <select id="dicPid" name="pid" style="width:360px;height:36px" data-options="required:true">
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
                <div style="text-align:left;padding:5px">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#ff').submit();">保存</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#ff')[0].reset();">重置</a>
                </div>
            </div>
        </div>
        <div id="toolBar">
            <a href="javascript:void(0)" class="icon-add" onclick="javascript:editForm(1)"></a>
            <a href="javascript:void(0)" class="icon-edit" onclick="javascript:editForm(2)"></a>
        </div>

        <div id="mm" class="easyui-menu" style="width:120px;">
            <div onclick="editForm(2)" data-options="iconCls:'icon-edit'">编辑节点</div>
            <div class="menu-sep"></div>
            <div onclick="removeit()" data-options="iconCls:'icon-remove'">删除节点</div>
            <div class="menu-sep"></div>
            <div onclick="editForm(1)" id="newChild" data-options="iconCls:'icon-add'">新增子节点</div>
        </div>

    </div>
</body>
<script type="text/javascript">
    $(function(){
        $('#dicTree').tree({
            url: '${ctx}/common/res/list',
            onLoadSuccess:function(node, data){
                selectParentNode(data);
            },
            onClick:function(node){
                setEditForm(node);
            },
            onContextMenu: function(e, node){
                e.preventDefault();
                // 查找节点
                $('#dicTree').tree('select', node.target);
                console.log(JSON.stringify(node));
                if(node['pid'] == 0){
                    $("#newChild").css("display","block");
                }else{
                    $("#newChild").css("display","none");
                }
                // 显示快捷菜单
                $('#mm').menu('show', {
                    left: e.pageX,
                    top: e.pageY
                });
            }
        });
        $('#ff').form({
            url:'${ctx}/common/res/saveOrUpdate',
            onSubmit: function(){
                return $(this).form('enableValidation').form('validate');
            },
            success:function(data){
                alert('操作成功');
            },
            error:function(err){
                alert("操作失败");
            }
        });

        $(".easyui-textbox").textbox("disable");

    })

    /**填充父节点*/
    function selectParentNode(data){
        var rootNode;
        var dataArr = [];
        for(var i=0;i<data.length;i++){
            rootNode = data[i];
            dataArr.push({
                id:rootNode.id,
                text:rootNode.text
            });
            var parentNode;
            for(var j=0; j<rootNode['children'].length; j++){
                parentNode = rootNode['children'][j];
                dataArr.push({
                    id:parentNode.id,
                    text:parentNode.text
                });
            }
        }
        $('#dicPid').combobox({
            data:dataArr,
            valueField:'id',
            textField:'text'
        });

        $('#dicPid').combobox("setValue",0);
        $('#dicPid').combobox("disable");
    }

    function setEditForm(node){
        $("#dic_id").val(node['id']);
        $("#dicValue").textbox("setValue",node['text']);
        $("#dicKey").textbox("setValue",node['attributes']['code']);
        $('#dicPid').combobox("setValue",node['pid']);
        $("#resDescr").textbox("setValue",node['attributes']['descr']);
        $("#resUri").textbox("setValue",node['attributes']['uri']);
        $(".easyui-textbox").textbox("disable");
        $('#dicPid').combobox("disable");
    }

    function editForm(type){
        $("#ff .easyui-textbox").textbox("enable");
        $("#ff select").combobox("enable");
        if(type == 1){ //新增
            $("#dic_id").val('');
            $("#ff .easyui-textbox").textbox("setValue","");
        }
    }

    function removeit(){
        var node = $('#dicTree').tree('getSelected');
        if(node){
            if(!confirm("确认删除此节点吗？")) return;
        }
        console.log(JSON.stringify(node));
        $.ajax({
            type:'get',
            url:'${ctx}/common/res/del/'+node['id'],
            dataType:'json',
            success:function(data){
                alert(data.msg);
                $('#dicTree').tree('remove', node.target);
            },
            error:function(err){
                alert("操作失败");
            }
        });
    }

</script>
</html>