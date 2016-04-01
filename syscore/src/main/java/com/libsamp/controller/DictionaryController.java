package com.libsamp.controller;

import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.StatusDTO;
import com.libsamp.entity.Dictionary;
import com.libsamp.service.DictionaryService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by hlib on 2015/8/8 0008.
 */
@Controller
@RequestMapping(value = "/common/dic/")
public class DictionaryController {
    private final String DIR = "/common/";

    private Logger log = Logger.getLogger(DictionaryController.class);

    @Autowired
    private DictionaryService dictionaryService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String showList(){
        return DIR+"dicList";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST) @ResponseBody
    public List<EasyuiTree> list(Dictionary dictionary){
        return dictionaryService.getEasyuiTree(null);
    }

    @RequestMapping(value = "saveOrUpdate",method = RequestMethod.POST) @ResponseBody
    public StatusDTO saveOrUpdate(Dictionary dic){
        try{
            dictionaryService.save(dic);
            dictionaryService.initDicMap();
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
            log.error("数据字典保存失败",e);
            return new StatusDTO(Boolean.FALSE);
        }
    }

    /**
     * 刷新字典缓存 手动方式
     * @return
     */
    @RequestMapping(value = "refresh",method = RequestMethod.GET) @ResponseBody
    public StatusDTO refresh(){
        try{
            dictionaryService.initDicMap();
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
        }
        return new StatusDTO(Boolean.FALSE);
    }


    @RequestMapping(value = "del/{id}",method = RequestMethod.GET) @ResponseBody
    public StatusDTO del(@PathVariable("id")Integer id){
        try{
            dictionaryService.deleteById(id);
            return new StatusDTO(Boolean.TRUE);
        }catch (Exception e){
            e.printStackTrace();
        }
        return new StatusDTO(Boolean.FALSE);
    }
}
