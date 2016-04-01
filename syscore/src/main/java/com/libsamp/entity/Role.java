package com.libsamp.entity;


import javax.persistence.Table;

/**
 * Created by hlib on 2015/8/11 0011.
 */
@Table(name = "t_role")
public class Role extends BaseEntity{

    private String name;
    private String code;
    private String descr;

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

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }
}
