package com.libsamp.controller;

import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.FileInputStatusDTO;
import com.libsamp.dto.StatusDTO;
import com.libsamp.entity.Role;
import com.libsamp.entity.User;
import com.libsamp.service.RoleService;
import com.libsamp.service.UserService;
import com.libsamp.util.Page;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by hlib on 2015/8/11 0011.
 */
@Controller
@RequestMapping(value = "/common/role/")
public class RoleController {
    private Logger log = Logger.getLogger(RoleController.class);
    private String DIR = "/common/";

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String showList(){
        return DIR+"roleList";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST) @ResponseBody
    public Page<Role> list(Role role,Integer page,Integer rows){
        return roleService.getListByPage(role,page,rows);
    }

    @RequestMapping(value = "resTree/{roleId}",method = RequestMethod.POST) @ResponseBody
    public List<EasyuiTree> editResource(@PathVariable("roleId")Integer roleId){
        return roleService.getResourceTreeByRoleId(roleId);
    }

    @RequestMapping(value = "saveRes",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveRes(@RequestParam("resIds")Set<Integer> resIds,Integer roleId){
        roleService.batchInsertRes(resIds,roleId);
        return new StatusDTO(Boolean.TRUE);
    }

    @RequestMapping(value = "saveRole",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveRole(@RequestParam("roleIds")Set<Integer> roleIds,Integer userId){
        roleService.batchInsertRole(roleIds,userId);
        return new StatusDTO(Boolean.TRUE);
    }

    @RequestMapping(value = "getRoles/{userId}",method = RequestMethod.POST) @ResponseBody
    public List<Role> getRoleByUserId(@PathVariable("userId")Integer userId){
        return roleService.getRoleByUserId(userId);
    }

    @RequestMapping(value = "getUsers/{roleId}",method = RequestMethod.GET) @ResponseBody
    public Page getUsers(@PathVariable("roleId")Integer roleId,Integer page,Integer rows){
        try {
            List<Integer> userIds = roleService.getUserIdsByRoleId(roleId);
            if (null == userIds) userIds = new ArrayList<>();
            if (userIds.size() <= 0) userIds.add(-1);
            User user = new User();
            user.setIds(userIds);
            return userService.getListByPage(user, page, rows);
        }catch (Exception e){
            e.printStackTrace();
            log.error("分页获取用户失败",e);
            return new Page(new ArrayList(),0,1,10);
        }
    }

    @RequestMapping(value = "edit",method = RequestMethod.GET)
    public String edit(@RequestParam(value = "id",required = false)Integer id,Model model){
        return DIR + "roleEdit";
    }

    @RequestMapping(value = "saveOrUpdate",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveOrUpdate(Role role){
        try{
            roleService.save(role);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
            return new StatusDTO(Boolean.FALSE);
        }
    }

    @RequestMapping(value = "getById/{id}",method = RequestMethod.GET) @ResponseBody
    public StatusDTO loadRoleById(@PathVariable("id")Integer id){
        try {
            Role role = roleService.getById(id);
            return new FileInputStatusDTO(role,Boolean.TRUE,null);
        }catch (Exception e){
            return new StatusDTO(Boolean.FALSE);
        }
    }

    @RequestMapping(value = "del/{id}",method = RequestMethod.POST) @ResponseBody
    public StatusDTO del(@PathVariable("id")Integer id){
        try{
            roleService.removeById(id);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
            return new StatusDTO(Boolean.FALSE);
        }
    }
}
