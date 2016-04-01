<!DOCTYPE html>
<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>TOP9后台管理系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${ctx}/css/sb-admin.css" rel="stylesheet">
    <!-- Morris Charts CSS -->
    <link href="${ctx}/css/plugins/morris.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="${ctx}/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="shortcut icon" href="${ctx}/media/image/introduce_logo.png" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

    <![endif]-->
    <!-- jQuery -->
    <script type="text/javascript" src="${ctx}/js/jquery-easyui-1.4.3/jquery.min.js"></script>
    <%--<script src="${ctx}/js/jquery.js"></script>--%>
    <!-- Bootstrap Core JavaScript -->
    <script src="${ctx}/js/bootstrap.min.js"></script>


    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap-fileinput-master/css/fileinput.min.css">
    <script type="text/javascript" src="${ctx}/js/bootstrap-fileinput-master/js/fileinput.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="${ctx}/js/bootstrap-table-master/dist/bootstrap-table.min.css">
    <!-- Latest compiled and minified JavaScript -->
    <script src="${ctx}/js/bootstrap-table-master/dist/bootstrap-table.min.js"></script>
    <!-- Latest compiled and minified Locales -->
    <script src="${ctx}/js/bootstrap-table-master/dist/locale/bootstrap-table-zh-CN.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/common.js"></script>
    <script type="text/javascript" src="${ctx}/js/util/confirm.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <script src="${ctx}/js/bootstrap-datetimepicker-master/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/js/bootstrap-datetimepicker-master/locales/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap-datepicker-master/css/bootstrap-datepicker.min.css">
    <script src="${ctx}/js/bootstrap-datepicker-master/js/bootstrap-datepicker.min.js"></script>
    <script src="${ctx}/js/bootstrap-datepicker-master/locales/bootstrap-datepicker.zh-CN.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrapvalidator-master/css/bootstrapValidator.min.css">
    <script src="${ctx}/js/bootstrapvalidator-master/js/bootstrapValidator.min.js"></script>
    <script src="${ctx}/js/bootstrapvalidator-master/js/language/zh_CN.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/js/bootstrap-treeview-master/dist/bootstrap-treeview.min.css">
    <script src="${ctx}/js/bootstrap-treeview-master/dist/bootstrap-treeview.min.js"></script>

    <style type="text/css">
        ul,ol,li{list-style-type:none;}
    </style>
    <script type="text/javascript">

        $(function(){
            $.fn.datepicker.defaults.format = "yyyy-mm-dd";
            Confirm.init('sm');
            $("[data-toggle='tooltip']").tooltip();
//            $('#ff').bootstrapValidator();

            $('#ff').bootstrapValidator({
                fields: {
                    password: {
                        validators: {
                            identical: {
                                field: 'confirmPwd',
                                message: '两次密码输入不一致'
                            },
                            stringLength: {
                                min: 6,
                                message: '密码不能少于6位'
                            }
                        }
                    },
                    confirmPwd: {
                        validators: {
                            identical: {
                                field: 'password',
                                message: '两次密码输入不一致'
                            }
                        }
                    }
                }
            });

            $('#pwdForm').bootstrapValidator({
                fields: {
                    newPwd: {
                        validators: {
                            identical: {
                                field: 'confirmPwd',
                                message: '两次密码输入不一致'
                            },
                            stringLength: {
                                min: 6,
                                message: '密码不能少于6位'
                            }
                        }
                    },
                    confirmPwd: {
                        validators: {
                            identical: {
                                field: 'newPwd',
                                message: '两次密码输入不一致'
                            }
                        }
                    }
                }
            });
            setActiveMenu();
        });

        function showErr(msg){
            $(".breadcrumb").siblings(".alert").remove();
            $("<div class='alert alert-danger'><a href='#' class='close' data-dismiss='alert'>&times;</a>"+msg+"</div>").insertAfter($(".breadcrumb").eq(0));
            window.scrollTo(0,0);
        }
        function showInfo(msg){
            $(".breadcrumb").siblings(".alert").remove();
            $("<div class='alert alert-success'><a href='#' class='close' data-dismiss='alert'>&times;</a>"+msg+"</div>").insertAfter($(".breadcrumb").eq(0));
        }

        window.alert = function(msg){
            $("#myModal .modal-body").html(msg);
            $("#myModal").modal("show");
        }

        function showConfirm(title,content,callback){
            Confirm.show(title, content , {
                '确定': {
                    'primary': true,
                    'callback':function(){
                        callback();
                        Confirm.hide();
                    }
                }
            });
        }
        function dlgNoBtn(title,content){
            if(title) {
                $("#myModalLabel").html(title);
            }
            $("#myModal .modal-body").html(content);
            $("#myModal .modal-footer").css("display","none");
            $("#myModal").modal("show");
        }

        function dlgWithBtn(title,content,callback){
            if(title) {
                $("#myModalLabel").html(title);
            }
            $("#myModal .modal-body").html("");
            $("#myModal .modal-body").append(content);

            $("#btn-save").unbind();
            $("#btn-save").bind("click",function(e){
                e.preventDefault();
                callback();
            });
            $("#myModal .modal-footer").css("display","block");
            $("#myModal").modal("show");
        }

        function closeDlg(){
            $("#myModal").modal("hide");
        }

        function saveCurMenu(id,pid){
            localStorage.setItem("menuId",id);
            localStorage.setItem("menuPid",pid);
        }

        //设置当前选中菜单
        function setActiveMenu(){
            var ckdPid = localStorage.getItem("menuPid");
            $(".side-nav .menu-parent").each(function(){
                if($(this).attr("mid") == ckdPid){
                    $(this).removeClass("collapse");
                }
            });

            var ckdCid = localStorage.getItem("menuId");
            $(".menu-parent .menu-child").each(function(){
//                if($(this).hasClass("collapse")) return false;
                if($(this).attr("cid") == ckdCid){
                    $(this).css("color","red");
                    $(this).css("background-color","#000");
                }

            });
        }

        function showModifyPwd(){
            $('#pwdForm').data("bootstrapValidator").resetForm(true);
            $('#pwdModal').modal('show');
        }

        function modifyPwd(){
            $('#pwdForm').data("bootstrapValidator").resetForm();
            $('#pwdForm').data("bootstrapValidator").validate();
            if(!$('#pwdForm').data("bootstrapValidator").isValid()) return;
            $.ajax({
                type:'post',
                url:'${ctx}/common/user/changePwd',
                data: $('#pwdForm').serializeArray(),
                dataType:'json',
                success:function(data){
                    if(data.status == "200"){
                        showInfo(data.msg);
                    }else{
                        showErr(data.msg);
                    }
                    $("#pwdModal").modal("hide");
                },
                error:function(err){
                    showErr("服务器内部错误，请联系管理员");
                    $("#pwdModal").modal("hide");
                }
            });
        }

    </script>

    <sitemesh:head/>
</head>

<body>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">TOP9后台管理系统</a>
        </div>
        <!-- Top Menu Items -->
        <%@ include file="/WEB-INF/views2/layout/header.jsp" %>
        <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
        <%@ include file="/WEB-INF/views2/layout/sidebar.jsp" %>
    </nav>

    <div id="page-wrapper" style="min-height:890px !important;">
        <!-- /.container-fluid -->
        <sitemesh:body/>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
<%--<%@ include file="/WEB-INF/views/layout/footer.jsp" %>--%>

<!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        提示信息
                    </h4>
                </div>
                <div class="modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="button" id="btn-save" class="btn btn-primary">
                        确定
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div>
<!-- /.modal -->

    <!--modify pwd modal start-->
    <div class="modal fade" id="pwdModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" >
                        修改密码
                    </h4>
                </div>
                <div class="modal-body">
                    <form id="pwdForm" class="form-horizontal" method="post"  role="form"
                          data-bv-message="This value is not valid"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">原始密码</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control" name="password" data-bv-notempty="true" placeholder="原始密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">新密码</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control" name="newPwd" data-bv-notempty="true" placeholder="新密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认新密码</label>
                            <div class="col-sm-8">
                                <input type="password" class="form-control" name="confirmPwd" data-bv-notempty="true" placeholder="确认新密码">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="javascript:modifyPwd();">确定</button>
                </div>
            </div>
        </div>
    </div>
<!--modify pwd modal end-->


</body>

</html>
