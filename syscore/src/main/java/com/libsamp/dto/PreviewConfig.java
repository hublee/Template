package com.libsamp.dto;

import java.util.Map;

/**
 * Created by hlib on 2015/8/19 0019.
 * bootstrap fileinput 上传文件返回对象
 */
public class PreviewConfig {
    private String caption;
    private String width;
    private String url;
    private String key;
    private Map<String,Object> extra;

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public Map<String, Object> getExtra() {
        return extra;
    }

    public void setExtra(Map<String, Object> extra) {
        this.extra = extra;
    }
}
