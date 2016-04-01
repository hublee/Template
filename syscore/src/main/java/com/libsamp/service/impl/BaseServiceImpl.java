package com.libsamp.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.libsamp.annotation.Logable;
import com.libsamp.service.BaseService;
import com.libsamp.util.Page;
import com.libsamp.util.ReflectUtil;
import com.libsamp.util.SystemUtil;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ReflectionUtils;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Example;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.List;

/**
 * Created by hlib on 2015/11/24 0024.
 */
@Transactional(readOnly = true)
public abstract class BaseServiceImpl<D extends Mapper<T>,T> implements BaseService<T>{

    protected D mapper;
    protected Class<T> entityClass;
    protected String busName; //业务名称，用于记录操作日志

    public BaseServiceImpl() {
        Type[] trueType = ((ParameterizedType)this.getClass().getGenericSuperclass()).getActualTypeArguments();
        //this.entityClass  = (Class<T>)trueType[1];
        Type type = trueType[1];
        if(type instanceof Class) {
            this.entityClass = (Class<T>)trueType[1];
        } else {
            //type = ((ParameterizedType)type).getRawType();
            log.info(type.getClass());
        }
    }

    /**
     * 分页查询
     * @param t
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<T> getListByPage(T t,int pageNo,int pageSize){
        //只查询未被标记删除的数据
        try{
            Field fd_del = ReflectionUtils.findField(t.getClass(),"delFlag");
            fd_del.setAccessible(true);
            if(null != fd_del){
                fd_del.set(t,1);
            }
        }catch (Exception e){
            e.printStackTrace();
            log.error("分页查询失败",e);
        }

        //方式一
        //TODO 看分页插件源码
        PageHelper.startPage(pageNo, pageSize);
        //如果属性类型是 string ，则统一使用模糊查询
        Example example = new Example(t.getClass());
        Example.Criteria criteria = example.createCriteria();
        try {
            List<Field> persistFields = ReflectUtil.getPersistFields(t.getClass());
            List<Field> fieldList = ReflectUtil.getWithValueNotNull(t, persistFields);
            for(Field field : fieldList){
                if(field.getType() == String.class){
                    criteria.andLike(field.getName(), "%"+field.get(t)+"%");
                }else{
                    criteria.andEqualTo(field.getName(),field.get(t));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        List<T> list = mapper.selectByExample(example);
        PageInfo pageInfo = new PageInfo(list);
        return new Page<>(list,Long.valueOf(pageInfo.getTotal()).intValue(),pageNo,pageSize);
        //方式二
        /*int offset = pageSize*(pageNo - 1);
        int limit = pageSize;
        RowBounds rowBounds = new RowBounds(offset,limit);
        List<T> rows = mapper.selectByRowBounds(t,rowBounds);
        int count = mapper.selectCount(t);
        log.debug("total count : " + count);
        return new Page<>(rows,count,pageNo,pageSize);*/
    }

    public List<T> getList(T t){
        return mapper.select(t);
    }

    public T getById(Integer id){
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 新增
     * @param t
     * @return
     */
    @Transactional(readOnly = false) @Logable(option = "新增")
    public T add(T t){
        try{
            Field cr_time = ReflectionUtils.findField(t.getClass(),"createTime");
            if(null != cr_time) {
                cr_time.setAccessible(true);
                cr_time.set(t,new Date());
            }
            Field delFlag = ReflectionUtils.findField(t.getClass(),"delFlag");
            if(null != delFlag) {
                delFlag.setAccessible(true);
                delFlag.set(t,1);
            }
            Field cr_id = ReflectionUtils.findField(t.getClass(),"createId");
            if(null != cr_id) {
                cr_id.setAccessible(true);
                cr_id.set(t,SystemUtil.currentUser().getId());
            }
        }catch (Exception e){
            e.printStackTrace();
            log.error("新增数据失败",e);
        }
        mapper.insert(t);
        return t;
    }

    /**
     * 修改
     * @param t
     * @return
     */
    @Transactional(readOnly = false) @Logable(option = "修改")
    public T modify(T t){
        try {
            Field upd_time = ReflectionUtils.findField(t.getClass(),"updateTime");
            if(null != upd_time) {
                upd_time.setAccessible(true);
                upd_time.set(t,new Date());
            }

            Field upd_id = ReflectionUtils.findField(t.getClass(),"updateId");
            if(null != upd_id){
                upd_id.setAccessible(true);
                upd_id.set(t, SystemUtil.currentUser().getId());
            }
        }catch (Exception e){
            e.printStackTrace();
            log.error("更新失败",e);
        }
        mapper.updateByPrimaryKeySelective(t);
        return t;
    }

    /**
     * 保存，包含了新增和修改 = add or modify
     * @param t
     * @return
     */
    @Transactional(readOnly = false)
    public T save(T t){
        Integer id = null;
        try{
            Field field = ReflectionUtils.findField(t.getClass(), "id");
            field.setAccessible(true);
            id = (Integer) field.get(t);
        }catch (Exception e){
            e.printStackTrace();
            log.error("保存失败",e);
        }
        if(null != id){
            modify(t);
        }else{
            add(t);
        }
        return t;
    }

    /**
     * 根据主键删除(标记删除)
     * @param id
     */
    @Transactional(readOnly = false) @Logable(option = "删除")
    public void removeById(Integer id){
        T t = null;
        try {
            t = getEntityClass().newInstance();
            Field fd_id = ReflectionUtils.findField(t.getClass(),"id");
            fd_id.setAccessible(true);
            if(null != fd_id){
                fd_id.set(t,id);
            }
            Field fd_del = ReflectionUtils.findField(t.getClass(),"delFlag");
            fd_del.setAccessible(true);
            if(null != fd_del){
                fd_del.set(t,0);
            }
        }catch (Exception e){
            e.printStackTrace();
            log.error("删除失败",e);
        }
        mapper.updateByPrimaryKeySelective(t);
    }

    @Override
    @Transactional(readOnly = false)
    public void deleteById(Integer id) {
        mapper.deleteByPrimaryKey(id);
    }


    @Override
    @Transactional(readOnly = false)
    public void deleteByIds(List<Integer> ids) {
        T t;
        try{
            t = getEntityClass().newInstance();
            Field fd_id = ReflectionUtils.findField(t.getClass(),"id");
            fd_id.setAccessible(true);
            if(null != fd_id){
                Example example = new Example(t.getClass());
                example.createCriteria().andIn("id",ids);
                mapper.deleteByExample(example);
            }
        }catch (Exception e){
            log.error("批量删除失败",e);
            e.printStackTrace();
        }
    }

    public abstract void setMapper(D mapper);

    public String getBusName() {
        return busName;
    }

    public Class<T> getEntityClass() {
        return entityClass;
    }
}
