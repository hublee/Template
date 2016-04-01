<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>客户端管理</title>
    <script>
        function ajaxSubmit(e){
            $('#ff').data("bootstrapValidator").validate();
            if(!$('#ff').data("bootstrapValidator").isValid()) return;
            $(e).button('loading');
            $.ajax({
                type:'post',
                url:'${ctx}/common/client/save',
                data:$('#ff').serializeArray(),
                dataType:'json',
                success:function(data){
                    if(data.status == "200"){
                        showInfo(data.msg);
                        location.href = document.referrer;
                    }else{
                        showErr("服务器内部错误，请联系管理员");
                        $(e).button('reset');
                    }
                },
                error:function(err){
                    showErr("操作失败！");
                    $(e).button('reset');
                }
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
                <li class="">
                    <a class="fa" href="javascript:location.href=document.referrer">客户端管理</a>
                </li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        ${empty obj or empty obj.id ? '添加客户端' : '修改客户端'}
                    </h3>
                </div>
                <div class="panel-body">
                    <form id="ff" class="form-horizontal" method="post"  role="form"
                          data-bv-message="This value is not valid"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <input type="hidden" name="id" id="objId" value="${obj.id}">
                        <div class="form-group">
                            <label for="clientName" class="col-sm-2 control-label">应用名称</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="clientName" name="clientName" data-bv-notempty="true" placeholder="应用名称" value="${obj.clientName}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="clientId" class="col-sm-2 control-label">APPID</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="clientId" name="clientId" readonly placeholder="APPID" value="${obj.clientId}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="clientSecret" class="col-sm-2 control-label">APPSECRET</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="clientSecret" name="clientSecret" readonly placeholder="APPSECRET" value="${obj.clientSecret}">
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