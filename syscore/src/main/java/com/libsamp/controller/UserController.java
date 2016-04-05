package com.libsamp.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.libsamp.dto.PreviewConfig;
import com.libsamp.dto.StatusDTO;
import com.libsamp.entity.Attachment;
import com.libsamp.entity.User;
import com.libsamp.service.AttachmentService;
import com.libsamp.service.UserService;
import com.libsamp.util.Constants;
import com.libsamp.util.DicUtil;
import com.libsamp.util.Page;
import com.libsamp.util.SystemUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by hlib on 2015/8/6 0006.
 */
@Controller
@RequestMapping(value = "/common/user/")
public class UserController {
    private final String DIR = "/common/";

    private Logger logger = Logger.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private AttachmentService attachService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String showList(){
        return DIR+"userList";
    }

    @RequestMapping(value = "listData",method = RequestMethod.POST) @ResponseBody
    public Page<User> list(Integer page,Integer rows,User user) throws Exception{
        Page<User> userPage = userService.getListByPage(user,page,rows);
        return userPage;
    }

    @RequestMapping(value = "edit",method = RequestMethod.GET)
    public String showEdit(@RequestParam(value = "id",required = false)Integer id,Model model) throws JsonProcessingException {
        if(null != id){
            User user = userService.getById(id);
            model.addAttribute("user",user);

            List<Integer> sourceIds = new ArrayList<>();
            sourceIds.add(id);
            Attachment param = new Attachment(User.class.getName(),sourceIds);
            List<Attachment> attachments = attachService.getList(param);
            if (attachments.size() > 0) {
                ObjectMapper om = new ObjectMapper();
                List<String> icon = null;
                List<PreviewConfig> config_icon = null;
                PreviewConfig pconfig;
                String preview;
                for(Attachment attach : attachments){
                    preview = "<img src='"+ Constants.UPLOAD_URI + attach.getUri()+"' onerror='noFind(this);' class='file-preview-image' alt='"+attach.getName()+"' title='"+attach.getName()+"'>";

                    pconfig = new PreviewConfig();
                    pconfig.setUrl("/common/attach/del/"+attach.getId());
                    pconfig.setCaption(attach.getName());
                    pconfig.setKey(attach.getId().toString());

                    switch (attach.getSourceType()){
                        case "icon":
                            if(null == icon) icon = new ArrayList<>();
                            icon.add(preview);
                            //configs
                            if(null == config_icon) config_icon = new ArrayList<>();
                            config_icon.add(pconfig);
                            break;
                    }
                }
                model.addAttribute("icon", om.writeValueAsString(icon == null ? new ArrayList<>() : icon));
                model.addAttribute("config_icon",om.writeValueAsString(config_icon == null ? new ArrayList<>() : config_icon));
            }
        }
        model.addAttribute("ustatus", DicUtil.getDicByKey("USER_STATUS"));

        return DIR+"userEdit";
    }

    @RequestMapping(value = "save",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveOrUpdate(User user){
        try {
            if (null == user.getId()) {
                user.setPassword(new Md5Hash(user.getPassword()).toBase64());
            }
            user.setUserType(1);
            userService.save(user);
        }catch (Exception e){
            e.printStackTrace();
            logger.error("保存用户信息失败",e);
        }
        return new StatusDTO(Boolean.FALSE);
    }

    @RequestMapping(value = "disable/{isEnable}/{id}",method = RequestMethod.POST) @ResponseBody
    public StatusDTO disableUser(@PathVariable("isEnable")Integer isEnable,@PathVariable("id")Integer id){
        try {
            userService.disableUser(id, isEnable);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
            return new StatusDTO(Boolean.FALSE);
        }
    }

    @RequestMapping(value = "changePwd",method = RequestMethod.POST) @ResponseBody
    public StatusDTO changePwd(User user){
        try {
            User cuser = userService.getOneByExample(new User(SystemUtil.currentUser().getName()));
            if (cuser.getPassword().equals(new Md5Hash(user.getPassword()).toBase64())) {
                cuser.setPassword(new Md5Hash(user.getNewPwd()).toBase64());
                userService.save(cuser);
                return new StatusDTO(Boolean.TRUE);
            } else {
                StatusDTO dto = new StatusDTO(Boolean.FALSE);
                dto.setMsg("原始密码错误");
                return dto;
            }
        }catch (Exception e){
            logger.error("服务器内部错误",e);
        }
        return new StatusDTO(Boolean.FALSE);
    }

    @RequestMapping(value = "del/{id}",method = RequestMethod.GET) @ResponseBody
    public StatusDTO del(@PathVariable("id")Integer id){
        try{
            userService.removeById(id);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
        }
        return new StatusDTO(Boolean.FALSE);
    }
}
