package com.libsamp.dto;

import java.util.List;

/**
 * Created by hlib on 2015/8/19 0019.
 */
public class FileInputStatusDTO<T> extends StatusDTO {

    public FileInputStatusDTO(Boolean b, List<PreviewConfig> initialPreviewConfig) {
        super(b);
        this.initialPreviewConfig = initialPreviewConfig;
    }

    public FileInputStatusDTO(T data,Boolean b, List<PreviewConfig> initialPreviewConfig) {
        super(b);
        this.initialPreviewConfig = initialPreviewConfig;
        this.data = data;
    }

    public FileInputStatusDTO(T data,Boolean b, List<PreviewConfig> initialPreviewConfig,List<String> initialPreview) {
        super(b);
        this.initialPreviewConfig = initialPreviewConfig;
        this.data = data;
        this.initialPreview = initialPreview;
    }

    public FileInputStatusDTO(Boolean b, List<PreviewConfig> initialPreviewConfig,List<String> initialPreview) {
        super(b);
        this.initialPreviewConfig = initialPreviewConfig;
        this.initialPreview = initialPreview;
    }

    public FileInputStatusDTO() {

    }

    private T data;

    private List<PreviewConfig> initialPreviewConfig;

    private List<String> initialPreview;

    public List<PreviewConfig> getInitialPreviewConfig() {
        return initialPreviewConfig;
    }

    public void setInitialPreviewConfig(List<PreviewConfig> initialPreviewConfig) {
        this.initialPreviewConfig = initialPreviewConfig;
    }

    public List<String> getInitialPreview() {
        return initialPreview;
    }

    public void setInitialPreview(List<String> initialPreview) {
        this.initialPreview = initialPreview;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
