package com.libsamp.entity;

import javax.persistence.Table;

/**
 * Created by hlib on 2015/8/11 0011.
 */
@Table(name = "t_user_role")
public class UserRole {

    private Integer userId;

    private Integer roleId;

    public UserRole() {
    }

    public UserRole(Integer userId, Integer roleId) {
        this.userId = userId;
        this.roleId = roleId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}
