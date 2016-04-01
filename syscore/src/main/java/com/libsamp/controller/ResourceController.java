package com.libsamp.controller;

import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.ResourceTree;
import com.libsamp.dto.ShiroUser;
import com.libsamp.dto.StatusDTO;
import com.libsamp.entity.Resource;
import com.libsamp.entity.User;
import com.libsamp.service.ResourceService;
import com.libsamp.service.RoleService;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by hlib on 2015/8/4 0004.
 */
@Controller
@RequestMapping(value = "/common/res/")
public class ResourceController {

    private String DIR = "/common/";
    private Logger log = Logger.getLogger(ResourceController.class);

    @Autowired
    private ResourceService resService;

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String showList(){

        return DIR+"resList";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST) @ResponseBody
    public List<EasyuiTree> list(Resource resource){
        List<EasyuiTree> trees = resService.getEasyuiTree(resource);
        return trees;
    }


    @RequestMapping(value = "saveOrUpdate",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveOrUpdate(Resource resource){
        try{
            resService.save(resource);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            log.error("保存资源菜单失败",e);
            e.printStackTrace();
            return new StatusDTO(Boolean.FALSE);
        }
    }

    @RequestMapping(value = "load",method = RequestMethod.POST) @ResponseBody
    public List<ResourceTree> load(){
        Subject subject = SecurityUtils.getSubject();
        ShiroUser shiroUser = (ShiroUser) subject.getPrincipal();
        List<ResourceTree> resourceTreeList = roleService.loadResourceTreeByUser(new User(shiroUser));
        return resourceTreeList;
    }

    @RequestMapping(value = "del/{id}",method = RequestMethod.GET) @ResponseBody
    public StatusDTO del(@PathVariable("id")Integer id){
        try{
            resService.deleteById(id);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
        }
        return new StatusDTO(Boolean.FALSE);
    }

}
