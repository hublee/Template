<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="../public/taglib.jsp"%>
<!-- BEGIN HEADER -->
<ul class="nav navbar-right top-nav">
    <%--<li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
        <ul class="dropdown-menu message-dropdown">
            <li class="message-preview">
                <a href="#">
                    <div class="media">
                                    <span class="pull-left">
                                        <img class="media-object" src="http://placehold.it/50x50" alt="">
                                    </span>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>John Smith</strong>
                            </h5>
                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                        </div>
                    </div>
                </a>
            </li>
            <li class="message-footer">
                <a href="#">Read All New Messages</a>
            </li>
        </ul>
    </li>--%>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-user"></i>
            <span class="username"><shiro:principal property="name"/></span>
            <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
            <li>
                <a href="javascript:showModifyPwd();"><i class="fa fa-fw fa-user"></i>修改密码</a>
            </li>
           <%-- <li>
                <a href="#"><i class="fa fa-fw fa-gear disabled"></i>设置</a>
            </li>--%>
            <li class="divider"></li>
            <li>
                <a href="${ctx}/logout"><i class="fa fa-fw fa-power-off"></i>退出系统</a>
            </li>
        </ul>
    </li>
</ul>
<!-- END HEADER -->