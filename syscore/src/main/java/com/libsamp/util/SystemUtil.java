package com.libsamp.util;

import com.libsamp.dto.ShiroUser;
import org.apache.shiro.SecurityUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by hlib on 2015/8/25 0025.
 */
public class SystemUtil {

    /**
     * 获取当前登录用户
     * @return
     */
    public static ShiroUser currentUser(){
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        return user;
    }

    /**
     * request token
     * @return
     */
    public static String getToken(){
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes sra = (ServletRequestAttributes) ra;
        HttpServletRequest request = sra.getRequest();
        String token = request.getHeader("token");
        return token;
    }

}
