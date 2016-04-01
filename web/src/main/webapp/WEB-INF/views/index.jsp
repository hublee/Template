<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>TOP9后台管理系统</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui-1.4.3/demo/demo.css">
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.easyui.min.js"></script> <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
</head>
<body style="padding:5px;">
<div  id="la" class="easyui-layout" style="width:100%;height:100%;">
<div data-options="region:'north',title:'&nbsp;',split:false,collapsible:false,border:false" style="height:70px;overflow:hidden;">
    <p style="float:left;margin-left:20px;">TOP9后台管理系统</p>
    <p style="float:right;margin-right:20px;">
        <span>当前用户：<shiro:principal property="name"/></span>&nbsp;&nbsp;
        <a href="javascript:void(0);" class="easyui-linkbutton l-btn" onclick="changePwd();">修改密码</a>
        <a href="/logout" class="easyui-linkbutton l-btn">退出登录</a>
    </p>
</div>
<div data-options="region:'west',title:'系统菜单',split:false" style="width:200px;">
    <div id="p" class="easyui-panel" title="" style="width:200px;height:100%;" data-options="fit:true,border:false">
        <div class="easyui-accordion" style="width:200px;height:100%;" data-options="fit:true,border:false">
            <c:forEach items="${resList}" var="res">
                <div title="${res.name}" style="text-align:center;">
                    <ul class="easyui-datalist" title="" lines="true" style="height:100%;">
                        <c:forEach items="${res.children}" var="child">
                            <li style="text-align:center;cursor:pointer;" value="${child.uri}">${child.name}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<div data-options="region:'center',border:false" style="background:#eee;">
    <div id="tab_wrapper" class="easyui-panel" style="height:100%;">
        <div title="首页" style="padding:20px;">
            <h2 style="margin-bottom:800px;">欢迎登陆TOP9后台管理系统</h2>
        </div>
    </div>
</div>
<div id="mm">
    <div data-options="iconCls:'icon-reload'" onclick="f_refreshTab();">刷新</div>
    <div data-options="iconCls:'icon-clear'" onclick="f_removeTab();">关闭当前</div>
    <div data-options="iconCls:'icon-clear'" onclick="f_closeOther();">关闭其他</div>
    <div data-options="iconCls:'icon-clear'" onclick="f_closeAll();">关闭所有</div>
</div>
<div id="dd" style="padding:20px;display:none;">
    <form id="ff" method="post">
        <table>
            <tr>
                <td>用户名:</td>
                <td><input name="name" class="f1 easyui-textbox" value="<shiro:principal property="name"/>" disabled/></td>
            </tr>
            <tr>
                <td>原始密码:</td>
                <td><input name="password" class="f1 easyui-textbox" data-options="required:true" type="password" /></td>
            </tr>
            <tr>
                <td>新密码:</td>
                <td><input name="newPwd" class="f1 easyui-textbox" data-options="required:true" type="password" id="new_password" validType="length[6,16]"/></td>
            </tr>
            <tr>
                <td>确认新密码:</td>
                <td><input name="commitPwd" class="f1 easyui-textbox" data-options="required:true" type="password" required="required" validType="equals['#new_password']" validType="length[6,16]"/></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="保存"/></td>
            </tr>
        </table>
    </form>
</div>
</div>
</body>
<script type="text/javascript">

    $(window).resize(function () {
        setWidthAndHeight();
    })

    //调整面板宽度
    function setWidthAndHeight(){
        var c = $('#la');
        var p = c.layout('panel','center');    // get the center panel
        var oldWidth = p.panel('panel').outerWidth();
        p.panel('resize', {width:'auto'});
        var newWidth = p.panel('panel').outerWidth();

        var oldHeight = p.panel('panel').outerHeight();
        p.panel('resize',{height:'auto'});
        var newHeight = p.panel('panel').outerHeight();

        c.layout('resize',{
            width: (c.width() + newWidth - oldWidth),
            height:(c.height() + newHeight - oldHeight)
        });
    }

    $(function(){
        $(".easyui-datalist").datalist({
            onClickRow:function(index,row){
                f_addTab(row);
            }
        });

        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '两次密码输入不一致'
            }
        });

        $('#ff').form({
            url:'/common/user/changePwd',
            onSubmit: function(){
                return $(this).form('enableValidation').form('validate');
            },
            success:function(data){
                var data = eval("("+data+")");
                if(data.status == 200){
                    $('#dd').dialog('close');
                }else{
                    if(data.msg == "原始密码错误"){
                        alert("原始密码错误！");
                    }else{
                        alert("操作失败，请联系管理员");
                    }
                }
            }
        });

        $('#tab_wrapper').tabs({
            onUnselect:function(title,index){
                var tp = $("#tab_wrapper").tabs("getTab",index);
                var tmb = tp.panel('options').tab.find('a.tabs-inner');
                if(index != 0) tmb.menubutton("disable");
            },
            onClose:function(title,index){
                var tabs = $('#tab_wrapper').tabs('tabs');
                var tp2 = $("#tab_wrapper").tabs("getTab",tabs.length-1);
                var tmb2 = tp2.panel('options').tab.find('a.tabs-inner');
                if(tabs.length != 1) tmb2.menubutton("enable");
            }
        });
    })

    function f_addTab(menu){
        var title = menu['text'];
        var url = '${ctx}'+menu['value'];

        var isExist = $('#tab_wrapper').tabs("exists",title);
        if(isExist) {
            $('#tab_wrapper').tabs("select",title);
            var p0 = $("#tab_wrapper").tabs("getTab",title);
            var mb0 = p0.panel('options').tab.find('a.tabs-inner');
            mb0.menubutton("enable");
            return;
        }
        $('#tab_wrapper').tabs('add',{
            width:$("#tab_wrapper").parent().width(),
            height:"auto",
            title: title,
            content:'<iframe name='+url+' src="'+url+'" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>'
        });

        var p = $("#tab_wrapper").tabs("getTab",title);
        var mb = p.panel('options').tab.find('a.tabs-inner');

        mb.menubutton({
            menu:'#mm'
        }).click(function(){
            $('#tab_wrapper').tabs('select',title);
            mb.menubutton("enable");
        });
    }

    function f_addTab2(title,url){
        var menu = {};
        menu['text'] = title;
        menu['value'] = url;
        f_addTab(menu);
    }

    function f_removeTab(){
        var tab = $('#tab_wrapper').tabs('getSelected');
        if (tab){
            var index = $('#tab_wrapper').tabs('getTabIndex', tab);
            $('#tab_wrapper').tabs('close', index);
        }
    }

    function f_refreshTab(){
        var tab = $('#tab_wrapper').tabs('getSelected');
        if (tab){
            var ifm = $('#tab_wrapper .panel:visible iframe').attr("name");
            window.parent.frames[ifm].location.reload();
        }
    }

    function f_closeOther(){
        var slkTitle = $('#tab_wrapper .tabs .tabs-selected').text();
        $('#tab_wrapper .tabs li').each(function(index,obj){
            var tabTitle = $(".tabs-title",this).text();
            if(tabTitle != slkTitle && tabTitle != "首页"){
                $('#tab_wrapper').tabs('close',tabTitle);
            }
        });
    }

    function f_closeAll(){
        $('#tab_wrapper .tabs li').each(function(index,obj){
            var tabTitle = $(".tabs-title",this).text();
            if(tabTitle != "首页"){
                $('#tab_wrapper').tabs('close',tabTitle);
            }
        });
    }

    function changePwd(){
        $('#dd').css("display","block");
        $('#dd').dialog({
            title: '修改密码',
            width: 300,
            height: 260,
            cache: false,
            modal: true
        });
    }



</script>
</html>