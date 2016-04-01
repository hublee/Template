package com.libsamp.util;

/**
 * Apple应用元数据模型
 * 用户获取到的android和IOS安装包里面的信息,包含包名，描述，版本等信息
 */
public class ApkPlistMetadata{
    private String packageName;//应用的包名
    private String discription;//应用的描述
    private Integer versionCode; //版本号
    private String versionName;//应用的版本名称
    private String channelCode; //渠道代码
    public String getPackageName(){
        return packageName;
    }
    public void setPackageName(String packageName){
        this.packageName=packageName;
    }
    public String getDiscription(){
        return discription;
    }
    public void setDiscription(String discription){
        this.discription=discription;
    }
    public String getVersionName(){
        return versionName;
    }
    public void setVersionName(String versionName){
        this.versionName = versionName;
    }

    public Integer getVersionCode() {
        return versionCode;
    }

    public void setVersionCode(Integer versionCode) {
        this.versionCode = versionCode;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    @Override
    public String toString() {
        return "ApkPlistMetadata{" +
                "packageName='" + packageName + '\'' +
                ", discription='" + discription + '\'' +
                ", versionCode=" + versionCode +
                ", versionName='" + versionName + '\'' +
                '}';
    }
}