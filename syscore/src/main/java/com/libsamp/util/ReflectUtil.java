package com.libsamp.util;

import com.libsamp.annotation.Paramable;
import com.libsamp.entity.ActionLog;

import javax.persistence.Transient;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by hlib on 2015/11/27 0027.
 */
public class ReflectUtil {

    /**
     * 获取所有属性 包含父类的
     * @param clazz
     * @return
     */
    public static List<Field> getAllFieldsWithSuper(Class clazz){
        List<Field> fieldList = new ArrayList<>();
        fieldList.addAll(Arrays.asList(clazz.getDeclaredFields()));
        fieldList.addAll(Arrays.asList(clazz.getSuperclass().getDeclaredFields()));
        return fieldList;
    }


    /**
     * 获取已持久化的属性，未持久化的注解必须卸载属性上面
     * @param clazz
     * @return
     */
    public static List<Field> getPersistFields(Class clazz){
        List<Field> fieldList = getAllFieldsWithSuper(clazz);
        List<Field> rtField = new ArrayList<>();
        Boolean flag;
        for(Field field : fieldList){
            flag = true;
            for(Annotation annotation : field.getDeclaredAnnotations()){
                if(Transient.class == annotation.annotationType()){
                    flag = false;
                    break;
                }
            }
            if(!flag) continue;
            rtField.add(field);
        }
        return rtField;
    }

    /**
     * 获取值不为空的属性
     * @param t
     * @param fields
     * @param <T>
     * @return
     * @throws Exception
     */
    public static <T> List<Field> getWithValueNotNull(T t,List<Field> fields) throws Exception{
        List<Field> fieldList = new ArrayList<>();
        for(Field f : fields){
            f.setAccessible(true);
            if(null != f.get(t) && "" != f.get(t).toString()) fieldList.add(f);
        }
        return fieldList;
    }

    /**
     * 获取实体类未持久化且不为空的查询参数
     * @param clazz
     * @return
     */
    public static List<Field> getParamableFields(Class clazz){
        List<Field> fieldList = getAllFieldsWithSuper(clazz);
        List<Field> rtField = new ArrayList<>();
        for(Field field : fieldList){
            Paramable paramable = field.getAnnotation(Paramable.class);
            if(null == paramable || !paramable.value()){
                continue;
            }
            rtField.add(field);
        }
        return rtField;
    }


    public static void main(String[] args) throws Exception {
        ActionLog actionLog = new ActionLog();
//        actionLog.setDelFlag(1);
        List<Field> fieldList =  getPersistFields(ActionLog.class);
        /*for(Field f : fieldList){
            System.out.println(f.getName());
        }*/

        List<Field> fs = getWithValueNotNull(actionLog, fieldList);

        for(Field f : fs){
            System.out.println(f.getName());
        }


    }



}
