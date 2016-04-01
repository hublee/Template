package com.libsamp.entity;


import javax.persistence.Table;

/**
 * Created by hlib on 2015/8/14 0014.
 */
@Table(name = "t_attachment")
public class Attachment extends BaseEntity{
    private String name; //文件名
    private String uid; //附件唯一标识(服务器保存的文件名)
    private String uri; //附件相对路径
    private String suffix; //后缀名
    private Integer sourceId; //附件关联对象id
    private String sourceEntity; //关联对象类名
    private String sourceType; //关联对象属性分类
    private Long size; //附件大小
    private Long downCount; //下载次数
    private String descr; //附件描述
    private String privateAttr; //存放附件的一些私有属性（json格式）

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public Integer getSourceId() {
        return sourceId;
    }

    public void setSourceId(Integer sourceId) {
        this.sourceId = sourceId;
    }

    public String getSourceEntity() {
        return sourceEntity;
    }

    public void setSourceEntity(String sourceEntity) {
        this.sourceEntity = sourceEntity;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public Long getDownCount() {
        return downCount;
    }

    public void setDownCount(Long downCount) {
        this.downCount = downCount;
    }

    public String getPrivateAttr() {
        return privateAttr;
    }

    public void setPrivateAttr(String privateAttr) {
        this.privateAttr = privateAttr;
    }
}
