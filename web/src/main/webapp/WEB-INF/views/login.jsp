<%@page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYpE html pUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEaD><METa content="IE=11.0000" http-equiv="X-Ua-Compatible">
<html>
<head>
    <meta charset="UTF-8">
    <title>TOP9后台管理系统</title>
    <link rel="stylesheet" href="/css/login.css"/>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.3/jquery.min.js"></script>
</head>
<body>
    <div class="top_div" style="text-align:center;">
        <span style="color:#ffffff;position:relative;top:160px;font-size:20px;font-family:'Microsoft YaHei';font-weight:bold;">TOP9后台管理系统</span>
    </div>
    <div style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 260px; text-align: center;">
        <div style="width: 165px; height: 96px; position: absolute;">
            <div class="tou"></div>
            <div class="initial_left_hand" id="left_hand"></div>
            <div class="initial_right_hand" id="right_hand"></div>
        </div>
        <form action="/login" method="post">
            <p style="padding: 30px 0px 10px; position: relative;"><span class="u_logo"></span>
                <input class="ipt" type="text" name="username" placeholder="请输入用户名" value="">
            </p>
            <p style="position: relative;"><span class="p_logo"></span>
                <input class="ipt" id="password" type="password" name="password" placeholder="请输入密码" value="">
            </p>
           <%-- <p style="position: relative;text-align:left;padding-left:31px;margin-top:10px"><span>验证码：</span>
                    <input type="text" class="ipt" name="jcaptchaCode" style="width:153px;height:20px;padding-left:10px;margin-right:10px">
                    <img  src="/jcaptcha.jpg" title="点击更换验证码"  onclick="this.src='/jcaptcha.jpg?time=new Date();'" width="100px" height="40px" style="position:absolute;float: left;">
            </p>--%>
            <p id="errMsg" style="position: relative;height:20px;margin-top:10px;color:red;">
                <%
                    String error=(String)request.getAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
                    if(error!=null){
                        if(error.contains("DisabledAccountException")){
                            out.print("用户已被屏蔽,请登录其他用户.");
                        }else if(error.contains("UnknownAccountException")){
                            out.print("用户不存在,请检查后重试!");
                        }else if(error.contains("IncorrectCredentialsException")){
                            out.print("密码错误,请检查密码!");
                        }else if(error.contains("jCaptcha.error")){
                            out.print("验证码错误");
                        }else{
                            out.print("登录失败，请重试.");
//                            System.out.println("error-->> " + error);
                        }
                    }
                %>
            </p>
            <div style="height: 50px; line-height: 50px; margin-top: 10px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
                <p style="margin: 0px 35px 20px 45px;">
                   <span style="float: left;"><a style="color: rgb(204, 204, 204);" href="#">忘记密码?</a></span>
                   <span style="float: right;"><a style="color: rgb(204, 204, 204); margin-right: 10px;" href="#">注册</a>
                      <button style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;"
                         type="submit">登录</button>
                   </span>
                </p>
            </div>
        </form>
    </div>
    <div style="text-align:center;color:#ccc;">
        <p>Copyright@2014-2015 libsamp. All Rights Reserved</p>
    </div>
</body>
<script type="text/javascript">
    $(function(){
        //得到焦点
        $("#password").focus(function(){
            $("#left_hand").animate({
                left: "150",
                top: " -38"
            },{step: function(){
                if(parseInt($("#left_hand").css("left"))>140){
                    $("#left_hand").attr("class","left_hand");
                }
            }}, 2000);
            $("#right_hand").animate({
                right: "-64",
                top: "-38px"
            },{step: function(){
                if(parseInt($("#right_hand").css("right"))> -70){
                    $("#right_hand").attr("class","right_hand");
                }
            }}, 2000);
        });
        //失去焦点
        $("#password").blur(function(){
            $("#left_hand").attr("class","initial_left_hand");
            $("#left_hand").attr("style","left:100px;top:-12px;");
            $("#right_hand").attr("class","initial_right_hand");
            $("#right_hand").attr("style","right:-112px;top:-12px");
        });
    });
</script>
</html>