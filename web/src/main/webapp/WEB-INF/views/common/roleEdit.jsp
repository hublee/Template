<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="${ctx}/js/bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap-fileinput-master/css/fileinput.min.css">
    <script type="text/javascript" src="${ctx}/js/bootstrap-fileinput-master/js/fileinput.js"></script>

    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/demo/demo.css">

    <style type="text/css">
    </style>
</head>
<body>
<p>当前位置：技术管理&gt;&gt;<a href="javascript:history.go(-1);">角色管理</a>&gt;&gt;${empty obj.id ? '添加' : '修改'}角色</p>
<div style="margin:20px 0;"></div>
<div class="easyui-panel" title="${empty user or empty user.id ? '添加角色' : '修改角色'}" style="width:800px">
    <div style="padding:10px 60px 20px 60px">
        <form id="ff" class="easyui-form" method="post" data-options="novalidate:true">
            <table cellpadding="5">
                <tr>
                    <td>头像:</td>
                    <td>
                        <input class="file-loading" type="file" multiple  id="icon" style="margin-bottom:300px;" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td>用户状态:</td>
                    <td>
                        <select class="easyui-combobox" name="isEnable" style="width:360px;height:36px">

                            <c:forEach items="${ustatus}" var="statues">
                                <option value="${statues.dicKey}" ${statues.dicKey==user.isEnable ? 'selected=selected' : ''}>${statues.dicValue}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="id" value="${user.id}">
                    </td>
                </tr>
                <tr>
                    <td>用户名:</td>
                    <td><input class="easyui-textbox" type="text" name="name" value="${user.name}" data-options="required:true" style="width:360px;height:36px"/></td>
                </tr>
                <c:if test="${empty user || empty user.id}">
                    <tr>
                        <td>登陆密码:</td>
                        <td><input class="easyui-textbox" type="password" id="pwd"  name="password" value="${user.password}" data-options="required:true" style="width:360px;height:36px"/></td>
                    </tr>
                    <tr>
                        <td>确认密码:</td>
                        <td><input class="easyui-textbox" type="password" required="required" validType="equals['#pwd']"  style="width:360px;height:36px"/></td>
                    </tr>
                </c:if>
                <tr>
                    <td>邮箱</td>
                    <td>
                        <input class="easyui-textbox" type="text" name="email" data-options="validType:'email'" value="${user.email}" style="width:360px;height:36px"/>
                    </td>
                </tr>
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px;height:30px" onclick="ajaxSubmit()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px;height:30px" onclick="history.go(-1);">取消</a>
        </div>
    </div>
</div>
</body>
<script>

    $(function(){
        initFileInput();

        // extend the 'equals' rule
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '两次密码输入不一致'
            }
        });

        $('#ff').form({
            url:'/common/user/save',
            onSubmit: function(){
                return $(this).form('enableValidation').form('validate');
            },
            success:function(data){
                var data = eval("("+data+")");
                if(data.status == 200){
                    history.go(-1);
                }else{
                    alert("操作失败，请联系管理员");
                }
            }
        });
    })

    function ajaxSubmit(){
        $("#ff").submit();
    }

    function initFileInput(){
        //用户头像
        $("#icon").fileinput({
            uploadUrl: "", // server upload action
            uploadAsync: true,
            dropZoneEnabled:false,
            uploadExtraData:{type:'icon',sourceId:'${obj.id}'},
            overwriteInitial:false,
            initialPreview:${empty icon ? '[]':icon},
            initialPreviewConfig:${empty config_icon ? '[]' : config_icon},
            allowedFileTypes:['image']
        }).on('fileerror',function(event, data, previewId, index){
            console.log("错误信息: " + JSON.stringify(data));
        }).on('filepredelete', function(event, key) {
            console.log('Key = ' + key);
        });
    }

    //加载图片失败 设置默认图片
    function noFind(e){
        $(e).attr("src","/images/default.jpg");
        $(e).attr("onerror",null);
    }


</script>
</html>