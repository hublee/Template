package com.libsamp.controller;

import com.libsamp.dto.StatusDTO;
import com.libsamp.service.AttachmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by hlib on 2015/8/14 0014.
 */
@Controller
@RequestMapping(value = "/common/attach/")
public class AttachmentController {

    @Autowired
    private AttachmentService attachmentService;

    @RequestMapping(value = "del/{id}") @ResponseBody
    public StatusDTO del(@PathVariable("id")Integer id){
        attachmentService.removeById(id);
        return new StatusDTO(Boolean.TRUE);
    }
}
