package com.libsamp.util;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.special.InsertListMapper;

/**
 * Created by hlib on 2016/4/1 0001.
 */
public interface MyMapper<T> extends Mapper<T>,InsertListMapper<T>{

}
