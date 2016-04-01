package com.libsamp.controller;

import com.libsamp.dto.ResourceTree;
import com.libsamp.dto.ShiroUser;
import com.libsamp.entity.User;
import com.libsamp.service.RoleService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by hlib on 2015/8/5 0005.
 * 打开登录页面(GET请求)和登录出错页面(POST请求)
 * 真正登录的POST请求由Filter完成
 */
@Controller
public class SystemController {

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        Subject subject = SecurityUtils.getSubject();
        return subject.isRemembered() || subject.isAuthenticated() ? "redirect:index" : "login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String fail(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName,Model model){
        model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, userName);
        return "login";
    }

    @RequestMapping(value = "/index")
    public String index(Model model){
        Subject subject = SecurityUtils.getSubject();
        ShiroUser shiroUser = (ShiroUser) subject.getPrincipal();
        List<ResourceTree> resourceTreeList = roleService.loadResourceTreeByUser(new User(shiroUser));
        model.addAttribute("resList",resourceTreeList);
        return "index";
    }
}
