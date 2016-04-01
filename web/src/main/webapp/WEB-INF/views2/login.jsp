<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/28 0028
  Time: 上午 10:46:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="public/taglib.jsp"%>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

  <meta charset="utf-8" />

  <title>TOP9后台管理系统</title>

  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <meta content="" name="description" />

  <meta content="" name="author" />

  <!-- BEGIN GLOBAL MANDATORY STYLES -->

  <link href="${ctx}/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/style.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

  <link href="${ctx}/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

  <link href="${ctx}/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

  <!-- END GLOBAL MANDATORY STYLES -->

  <!-- BEGIN PAGE LEVEL STYLES -->

  <link href="${ctx}/media/css/login-soft.css" rel="stylesheet" type="text/css"/>

  <!-- END PAGE LEVEL STYLES -->

  <link rel="shortcut icon" href="${ctx}/media/image/introduce_logo.png" />

</head>
<body class="login">

<!-- BEGIN LOGO -->

<div class="logo">

  <img src="${ctx}/media/image/introduce_logo.png" alt="" height="70%" width="70%"/>

</div>

<!-- END LOGO -->

<!-- BEGIN LOGIN -->

<div class="content">

  <!-- BEGIN LOGIN FORM -->

  <form class="form-vertical login-form" method="post" action="login">

    <h3 class="form-title" style="text-align:center;">后台管理系统</h3>

    <div class="alert alert-error hide">

      <button class="close" data-dismiss="alert"></button>

      <span>请输入用户名和密码</span>

    </div>
        <%
          String error=(String)request.getAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
          if(error!=null){
            if(error.contains("DisabledAccountException")){
              %>
            <div class="alert alert-error">
              <button class="close" data-dismiss="alert"></button>
                 <span>
                   <%out.print("用户已被屏蔽,请登录其他用户.");%>
                 </span>
            </div>
        <%
            }else if(error.contains("UnknownAccountException")){

        %>
          <div class="alert alert-error">
            <button class="close" data-dismiss="alert"></button>
               <span>
                 <%out.print("用户不存在,请检查后重试!");%>
               </span>
          </div>
        <%
            }else if(error.contains("IncorrectCredentialsException")){
        %>
          <div class="alert alert-error">
            <button class="close" data-dismiss="alert"></button>
               <span>
                 <% out.print("密码错误,请检查密码!");%>
               </span>
          </div>
        <%
            }else if(error.contains("jCaptcha.error")){
        %>
          <div class="alert alert-error">
            <button class="close" data-dismiss="alert"></button>
               <span>
                 <% out.print("验证码错误");%>
               </span>
          </div>
        <%
            }else if(error.contains("CredentialsException")){

        %>
          <div class="alert alert-error">
            <button class="close" data-dismiss="alert"></button>
               <span>
                 <%out.print("用户名或密码不能为空");%>
               </span>
          </div>
          <%
              }else{
          %>
          <div class="alert alert-error">
            <button class="close" data-dismiss="alert"></button>
               <span>
                 <% out.print("登录失败，请重试.");%>
               </span>
          </div>
        <%
            }
          }
        %>

    <div class="control-group">

      <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

      <label class="control-label visible-ie8 visible-ie9">用户名</label>

      <div class="controls">

        <div class="input-icon left">

          <i class="icon-user"></i>

          <input class="m-wrap placeholder-no-fix" type="text" placeholder="用户名" name="username"/>

        </div>

      </div>

    </div>

    <div class="control-group">

      <label class="control-label visible-ie8 visible-ie9">密码</label>

      <div class="controls">

        <div class="input-icon left">

          <i class="icon-lock"></i>

          <input class="m-wrap placeholder-no-fix" type="password" placeholder="密码" name="password"/>

        </div>

      </div>

    </div>

    <div class="form-actions">

      <label class="checkbox">

        <input type="checkbox" name="remember" value="1"/> 记住我

      </label>

      <button  class="btn blue pull-right">

        登录 <i class="m-icon-swapright m-icon-white"></i>

      </button>

    </div>

  <%--  <div class="forget-password">
      <h4>忘记密码？</h4>
      <p>
        no worries, click <a href="javascript:;" class="" id="forget-password">here</a>
        to reset your password.
      </p>
    </div>--%>
    <%--<div class="create-account">
      <p>
        Don't have an account yet ?&nbsp;
        <a href="javascript:;" id="register-btn" class="">Create an account</a>
      </p>
    </div>--%>
  </form>
  <!-- END LOGIN FORM -->
</div>

<!-- END LOGIN -->

<!-- BEGIN COPYRIGHT -->
<div class="copyright">
  2016 &copy; 深圳市宙斯掌趣科技

</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

<!-- BEGIN CORE PLUGINS -->

<script src="${ctx}/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

<script src="${ctx}/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/bootstrap.min.js" type="text/javascript"></script>

<!--[if lt IE 9]>

<script src="${ctx}/media/js/excanvas.min.js"></script>

<script src="${ctx}/media/js/respond.min.js"></script>

<![endif]-->

<script src="${ctx}/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/jquery.blockui.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/jquery.cookie.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->

<script src="${ctx}/media/js/jquery.validate.min.js" type="text/javascript"></script>

<script src="${ctx}/media/js/jquery.backstretch.min.js" type="text/javascript"></script>

<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->

<script src="${ctx}/media/js/app.js" type="text/javascript"></script>

<script src="${ctx}/media/js/login-soft.js" type="text/javascript"></script>

<!-- END PAGE LEVEL SCRIPTS -->


<!-- END JAVASCRIPTS -->

</body>

<script type="text/javascript">
  jQuery(document).ready(function() {
    App.init();
    Login.init();
  });
</script>
</html>
