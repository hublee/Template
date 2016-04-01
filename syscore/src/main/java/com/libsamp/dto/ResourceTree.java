package com.libsamp.dto;

import com.libsamp.entity.Resource;

import java.util.List;

/**
 * Created by hlib on 2015/8/11 0011.
 */
public class ResourceTree extends Resource {

    public ResourceTree() {
    }

    public ResourceTree(Resource resource,List<Resource> children) {
        super(resource);
        this.children = children;
    }

    public ResourceTree(List<Resource> children) {
        this.children = children;
    }

    private List<Resource> children;  //资源树子节点

    public List<Resource> getChildren() {
        return children;
    }

    public void setChildren(List<Resource> children) {
        this.children = children;
    }
}
