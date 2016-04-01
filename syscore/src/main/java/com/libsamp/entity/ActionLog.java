package com.libsamp.entity;


import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Created by hlib on 2015/8/20 0020.
 */
@Table(name = "t_action_log")
public class ActionLog extends BaseEntity{
    private Integer userId;
    @Transient
    private String userName;

    private String busId;
    private String busName;
    private String entityClass;
    private String actionDescr;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getActionDescr() {
        if("" == actionDescr) return null;
        return actionDescr;
    }

    public void setActionDescr(String actionDescr) {
        this.actionDescr = actionDescr;
    }

    public String getBusName() {
        if("" == busName) return null;
        return busName;
    }

    public void setBusName(String busName) {
        this.busName = busName;
    }

    public String getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(String entityClass) {
        this.entityClass = entityClass;
    }

    public String getBusId() {
        return busId;
    }

    public void setBusId(String busId) {
        this.busId = busId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}
