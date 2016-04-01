package com.libsamp.sql;

import javax.persistence.Table;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/26 0026.
 */
public class MyBaseSqlProvider {

    public String getDelSql(Map<String,Object> params){
        String id = (String) params.get("id");
        String entity = (String) params.get("entity");
        BEGIN();
        UPDATE(getTableName(entity));
        SET(" del_flag = 0 ");
        WHERE(" id = " .concat(id));
        return SQL();
    }

    public String getTableName(String entity) {
        try {
            Class clazz = Class.forName(entity);
            Annotation annotation = clazz.getAnnotation(Table.class);
            Object invoke = "";
            for (Method method : annotation.annotationType().getDeclaredMethods()) {
                if (!"name".equals(method.getName())) continue;
                if (!method.isAccessible()) {
                    method.setAccessible(true);
                }
                invoke = method.invoke(annotation);
            }
            return invoke.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
}
