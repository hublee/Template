package com.libsamp.controller;

import com.libsamp.entity.ActionLog;
import com.libsamp.entity.User;
import com.libsamp.service.ActionLogService;
import com.libsamp.service.UserService;
import com.libsamp.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by hlib on 2015/8/20 0020.
 */
@Controller
@RequestMapping(value = "/common/actionLog/")
public class ActionLogController {

    private String DIR = "/common/";

    @Autowired
    private ActionLogService logService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(){
        return DIR + "actionLogList";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST) @ResponseBody
    public Page<ActionLog> listData(ActionLog actionLog,Integer page,Integer rows){
        Page rs = logService.getListByPage(actionLog,page,rows);
        setUserInfo(rs.getRows());
        return rs;
    }

    private void setUserInfo(List<ActionLog> logList){
        List<Integer> userIds = new ArrayList<>();
        for(ActionLog log : logList){
            userIds.add(log.getUserId());
        }
        if(userIds.size() <= 0) userIds.add(-1);
        Map<Integer,User> userMap = userService.getUserMapByIds(userIds);
        for(ActionLog log : logList){
            if(null != log.getUserId()
                    && null != userMap.get(log.getUserId())){
                log.setIsEnable(userMap.get(log.getUserId()).getIsEnable());
                log.setUserName(userMap.get(log.getUserId()).getName());
            }
        }
    }
}
