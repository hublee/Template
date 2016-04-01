package com.libsamp.controller;

import com.libsamp.entity.ActionLog;
import com.libsamp.service.ActionLogService;
import com.libsamp.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by hlib on 2015/8/20 0020.
 */
@Controller
@RequestMapping(value = "/common/actionLog/")
public class ActionLogController {

    private String DIR = "/common/";

    @Autowired
    private ActionLogService logService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(){

        return DIR + "actionLogList";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST) @ResponseBody
    public Page<ActionLog> listData(ActionLog actionLog,Integer page,Integer rows){
        return logService.getListByPage(actionLog,page,rows);
    }

}
