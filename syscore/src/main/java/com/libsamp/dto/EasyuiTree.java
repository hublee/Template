package com.libsamp.dto;

import com.libsamp.entity.Dictionary;
import com.libsamp.entity.Resource;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hlib on 2015/8/10 0010.
 */
public class EasyuiTree {

    private Integer id;

    private String text;

    private String iconCls;

    private String state;

    private List<EasyuiTree> children;

    private Map<String,Object> attributes;

    private Integer pid; //父节点id

    private Boolean checked;

    public EasyuiTree() {
    }

    public EasyuiTree(Dictionary dic) {
        this.id = dic.getId();
        this.pid = dic.getDicPid();
        this.text = dic.getDicValue();
        Map<String,Object> attr = new HashMap<String, Object>();
        attr.put("key",dic.getDicKey());
        this.attributes = attr;
    }

    public EasyuiTree(Resource res){
        this.id = res.getId();
        this.pid = res.getPid();
        this.text = res.getName();
        Map<String,Object> attr = new HashMap<String, Object>();
        attr.put("code",res.getCode());
        attr.put("descr",res.getDescr());
        attr.put("uri",res.getUri());
        this.attributes = attr;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public List<EasyuiTree> getChildren() {
        return children;
    }

    public void setChildren(List<EasyuiTree> children) {
        this.children = children;
    }

    public Map<String, Object> getAttributes() {
        return attributes;
    }

    public void setAttributes(Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }
}
