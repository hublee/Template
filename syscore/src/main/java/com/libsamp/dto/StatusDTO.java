package com.libsamp.dto;

/**
 * Created by hlib on 2015/8/18 0018.
 */
public class StatusDTO {

    private String status;

    private String msg;

    public StatusDTO() {
    }

    public StatusDTO(Boolean b) {
        if(b){
            this.status = "200";
            this.msg = "操作成功";
        }else{
            this.status = "500";
            this.msg = "操作失败";
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
