<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="zfn" uri="http://www.zeus.com/zeusFunction" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.alert = function(msg){
//        $.messager.alert('提示消息',msg);
        $.messager.show({
            title:'提示消息',
            msg:msg,
            timeout:1000,
            showType:'fade',
            style:{
                right:'',
                top:document.body.scrollTop+document.documentElement.scrollTop,
                bottom:''
            }
        });
    }
</script>