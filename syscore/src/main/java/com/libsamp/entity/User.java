package com.libsamp.entity;


import com.libsamp.dto.ShiroUser;

import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Created by hlib on 2015/8/5 0005.
 */
@Table(name = "t_user")
public class User extends BaseEntity{

    private String name;

    private String nickName;

    private String password;

    private String email;

    private String tel;

    private Integer sex;

    private String depart; //部门  针对内部用户

    private Integer isEnable;

    @Transient
    private String newPwd;

    private Integer userType; //区分后台用户与APP用户 1后台用户 0 app用户

    public User() {
    }

    public User(ShiroUser shiroUser) {
        this.id = shiroUser.getId();
        this.name = shiroUser.getName();
    }

    public String getName() {
        if(name == "") return null;
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getDepart() {
        return depart;
    }

    public void setDepart(String depart) {
        this.depart = depart;
    }

    public Integer getIsEnable() {
        return isEnable;
    }

    public void setIsEnable(Integer isEnable) {
        this.isEnable = isEnable;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getNewPwd() {
        return newPwd;
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }


    public enum FileType{
        icon("用户头像");
        private String descr;
        FileType(String descr){
            this.descr = descr;
        }

        @Override
        public String toString() {
            return super.toString();
        }
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "User{" +
                ", name='" + name + '\'' +
                ", nickName='" + nickName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", tel='" + tel + '\'' +
                ", sex=" + sex +
                ", depart='" + depart + '\'' +
                ", isEnable=" + isEnable +
                ", newPwd='" + newPwd + '\'' +
                ", userType=" + userType +
                '}';
    }
}
