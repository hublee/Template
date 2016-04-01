<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>消息管理</title>
    <script>

        function ajaxSubmit(e){
            $('#ff').data("bootstrapValidator").validate();
            if(!$('#ff').data("bootstrapValidator").isValid()) return;
            $(e).button('loading');
            $.ajax({
                type:'post',
                url:'${ctx}/common/msg/send2All',
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
                    <a class="fa" href="javascript:location.href=document.referrer">系统消息</a>
                </li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        ${empty obj or empty obj.id ? '添加消息' : '修改消息'}
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
                            <label for="busType"  class="col-sm-2 control-label">业务类型</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="busType" name="busType" data-bv-notempty="true">
                                    <option value="1">版本更新</option>
                                    <option value="2">评论奖励</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="showType"  class="col-sm-2 control-label">消息类型</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="showType" name="showType" data-bv-notempty="true">
                                    <option value="1">通知</option>
                                    <option value="2">透传消息</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="title" class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="title" name="title" data-bv-notempty="true" placeholder="标题" value="${obj.title}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="content" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-9">
                                <textarea type="text" class="form-control" id="content" name="content" data-bv-notempty="true" placeholder="内容">${obj.content}</textarea>
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