package com.libsamp.service;

import com.libsamp.util.Page;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * Created by hlib on 2015/11/24 0024.
 */
public interface BaseService<T> {

    public static Logger log = Logger.getLogger(BaseService.class);

    /**
     * 分页查询
     * @param t
     * @return
     */
    Page<T> getListByPage(T t,int pageNo,int pageSize);

    List<T> getList(T t);

    T getById(Integer id);

    /**
     * 新增
     * @param t
     * @return
     */
    T add(T t);

    /**
     * 修改
     * @param t
     * @return
     */
    T modify(T t);

    /**
     * 保存，包含了新增和修改 = add or modify
     * @param t
     * @return
     */
    T save(T t);

    /**
     * 根据主键标记删除
     * @param id
     */
    void removeById(Integer id);

    /**
     * 根据主键 物理删除
     * @param id
     */
    void deleteById(Integer id);

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(List<Integer> ids);

    /**
     * 根据条件查询单条记录
     * @param t
     * @return
     */
    T getOneByExample(T t);

}
