package com.libsamp.dto;

import java.io.Serializable;

/**
 * Created by hlib on 2015/8/12 0012.
 * 封装登陆用户信息
 */
public class ShiroUser implements Serializable {

    private Integer id;

    private String name;

    public ShiroUser(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public ShiroUser() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
