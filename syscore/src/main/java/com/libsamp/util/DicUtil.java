package com.libsamp.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.libsamp.entity.Dictionary;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hlib on 2015/8/10 0010.
 */
public class DicUtil {

    private static Map<String,List<Dictionary>> dicMap = new HashMap<>();

    /**
     * 通过父节点获取子节点列表
     * @param key
     * @return
     */
    public static List<Dictionary> getDicByKey(String key){
        return dicMap.get(key);
    }

    public static void initDicMap(List<Dictionary> dictionaryList){
        dicMap.clear();
        for(Dictionary dic : dictionaryList){
            if(!dicMap.containsKey(dic.getDicKey()) && !"ROOT".equals(dic.getDicKey())){
                List<Dictionary> childList = new ArrayList<Dictionary>();
                for(Dictionary child : dictionaryList){
                    if(child.getDicPid() == dic.getId()){
                        childList.add(child);
                    }
                }
                dicMap.put(dic.getDicKey(),childList);
            }
        }
    }

    public static Map<String,Object> getDicMap(String key){
        Map<String,Object> rtMap = new HashMap<>();
        List<Dictionary> dictionaries = getDicByKey(key);
        if(null != dictionaries){
            for(Dictionary dic : dictionaries){
                rtMap.put(dic.getDicKey(),dic.getDicValue());
            }
        }
        return rtMap;
    }

    public static String getDicName(String parent,String child){
        return (String) getDicMap(parent).get(child);
    }

    public static String getDicJsonMap(String key) throws JsonProcessingException {
        Map<String,Object> rtMap = new HashMap<>();
        List<Dictionary> dictionaries = getDicByKey(key);
        if(null != dictionaries){
            for(Dictionary dic : dictionaries){
                rtMap.put(dic.getDicKey(),dic.getDicValue());
            }
        }
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT,Boolean.TRUE);
        return mapper.writeValueAsString(rtMap);
    }

}
