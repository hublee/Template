package com.libsamp.entity;


import javax.persistence.Table;

/**
 * Created by hlib on 2015/8/10 0010.
 */
@Table(name = "t_resource")
public class Resource extends BaseEntity{
    private String name;
    private String code;
    private String uri;
    private Integer pid;
    private String descr;

    public Resource() {
    }

    public Resource(Resource resource) {
        this.id = resource.getId();
        this.name = resource.getName();
        this.code = resource.getCode();
        this.uri = resource.getUri();
        this.pid = resource.getPid();
        this.descr = resource.getDescr();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }
}
