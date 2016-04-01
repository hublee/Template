package com.libsamp.service;


import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.ResourceTree;
import com.libsamp.entity.Resource;

import java.util.List;

/**
 * Created by hlib on 2015/8/10 0010.
 */
public interface ResourceService extends BaseService<Resource>{

    List<EasyuiTree> getEasyuiTree(Resource param);

    List<ResourceTree> loadResTree();
}
