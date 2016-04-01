<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <script>

        $(function(){
            initFileInput();
        })

        function ajaxSubmit(e){
            $('#ff').data("bootstrapValidator").validate();
            if(!$('#ff').data("bootstrapValidator").isValid()) return;
            $(e).button('loading');
            $.ajax({
                type:'post',
                url:'${ctx}/common/user/save',
                data:$('#ff').serializeArray(),
                dataType:'json',
                success:function(data){
                    if(data.status == "200"){
                        showInfo(data.msg);
                        location.href = document.referrer;
                    }else{
                        showErr(data.msg);
                        $(e).button('reset');
                    }
                },
                error:function(err){
                    showErr("操作失败！");
                    $(e).button('reset');
                }
            });
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
</head>
<body>
    <div class="">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li class="active">
                        技术管理
                    </li>
                    <li class="">
                        <a class="fa" href="javascript:location.href=document.referrer">用户管理</a>
                    </li>
                </ol>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            ${empty user or empty user.id ? '添加用户' : '修改用户'}
                        </h3>
                    </div>
                    <div class="panel-body">
                        <form id="ff" class="form-horizontal" method="post"  role="form"
                              data-bv-message="This value is not valid"
                              data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                              data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                              data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                            <input type="hidden" name="id" id="objId" value="${user.id}">
                            <div class="form-group">
                                <label for="icon"  class="col-sm-1 control-label">头像</label>
                                <div class="col-sm-10">
                                    <input class="file-loading" type="file" multiple  id="icon" style="margin-bottom:300px;" disabled="disabled"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="isEnable"  class="col-sm-1 control-label">用户状态</label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="isEnable" name="isEnable" data-bv-notempty="true">
                                        <c:forEach items="${ustatus}" var="statues">
                                            <option value="${statues.dicKey}" ${statues.dicKey==user.isEnable ? 'selected=selected' : ''}>${statues.dicValue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="name" class="col-sm-1 control-label">用户名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="name" name="name" data-bv-notempty="true" placeholder="用户名" value="${user.name}">
                                </div>
                            </div>
                            <c:if test="${empty user || empty user.id}">
                                <div class="form-group">
                                    <label for="password" class="col-sm-1 control-label">登陆密码</label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" id="password" name="password" data-bv-notempty="true" placeholder="登录密码" value="${user.password}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="con_password" class="col-sm-1 control-label">确认密码</label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" id="con_password" name="confirmPwd" data-bv-notempty="true"  placeholder="确认密码">
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label for="email" class="col-sm-1 control-label">邮箱</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="email" name="email" data-bv-emailAddress="true" placeholder="邮箱" value="${user.email}">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="panel-footer" style="text-align:center">
                        <div class="" style="">
                            <a  class="btn btn-primary" data-loading-text="正在提交中..."  onclick="ajaxSubmit(this)">保存</a>
                            <a  class="btn btn-default" onclick="javascript:location.href=document.referrer">返回</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>