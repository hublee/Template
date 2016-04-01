package com.libsamp.service;


import com.libsamp.dto.EasyuiTree;
import com.libsamp.entity.Dictionary;

import java.util.List;

/**
 * Created by hlib on 2015/8/8 0008.
 */
public interface DictionaryService extends BaseService<Dictionary> {

    List<EasyuiTree> getEasyuiTree(Dictionary param);

    void initDicMap();

}
