package com.libsamp.entity;


import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by hlib on 2015/8/8 0008.
 * 数据字典类
 */

@Table(name = "t_dictionary")
public class Dictionary extends BaseEntity{
    private String dicKey;//字典key
    private String dicValue;//字典值
    private Integer dicPid;//上级ID
    private Integer levelId;//级别，省市县
    private String remark;//字典描述
    private Integer sortNum;//排序
    //    private String type;//类，还是项

    public String getDicKey() {
        return dicKey;
    }

    public void setDicKey(String dicKey) {
        this.dicKey = dicKey;
    }

    public String getDicValue() {
        return dicValue;
    }

    public void setDicValue(String dicValue) {
        this.dicValue = dicValue;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public Integer getDicPid() {
        return dicPid;
    }

    public void setDicPid(Integer dicPid) {
        this.dicPid = dicPid;
    }

    public Integer getLevelId() {
        return levelId;
    }

    public void setLevelId(Integer levelId) {
        this.levelId = levelId;
    }
}
