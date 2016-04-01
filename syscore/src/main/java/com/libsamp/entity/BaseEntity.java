package com.libsamp.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by hlib on 2015/8/6 0006.
 */
public abstract class BaseEntity implements Serializable{
    @Id //必须加主键标识，否则mybatis 无法判断哪个主键，一些用到主键作参数的方法
    protected Integer id;

    /** 创建时间 **/
    @Column(name = "create_time")
    protected Date createTime;
    /**创建人**/
    @Column(name = "create_id")
    protected Integer createId;
    /** 修改时间 **/
    @Column(name = "update_time")
    protected Date updateTime;
    /**修改人**/
    @Column(name = "update_id")
    protected Integer updateId;
    /**删除标记 0 删除 1有效**/
    @Column(name = "del_flag")
    protected Integer delFlag;

    @Transient
    private String order;
    @Transient
    private String sort;
    @Transient
    private int refreshType;
    @Transient
    private String appendWhere;

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @JsonIgnore
    public int getRefreshType() {
        return refreshType;
    }

    public void setRefreshType(int refreshType) {
        this.refreshType = refreshType;
    }
//    @JsonIgnore
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
//    @JsonIgnore
    public Date getUpdateTime() {
        return updateTime;
    }
    @JsonIgnore
    public String getAppendWhere() {
        return appendWhere;
    }

    public void setAppendWhere(String appendWhere) {
        this.appendWhere = appendWhere;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String orderSql(String defaultOrder){
        String orderBy = " order by ";
        if(StringUtils.isBlank(this.getSort()))
            orderBy += defaultOrder;
        else
            orderBy += this.getSort();
        if(StringUtils.isNotBlank(this.getOrder()))
            orderBy += " " + this.getOrder();
        else
            orderBy += " desc ";
        return orderBy;
    }

    public Integer getCreateId() {
        return createId;
    }

    public void setCreateId(Integer createId) {
        this.createId = createId;
    }

    public Integer getUpdateId() {
        return updateId;
    }

    public void setUpdateId(Integer updateId) {
        this.updateId = updateId;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
