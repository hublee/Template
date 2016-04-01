package com.libsamp.util;

/**
 * Created by hlib on 2015/11/27 0027.
 */
public class StrUtil {

    /**
     * sql语句增加驼峰标识的别名
     * @param sql
     * @return
     */
    public static String addColAlias(String sql){
        StringBuffer rtSql = new StringBuffer();
        for(String col : sql.split(",")){
            String cl = col.substring(col.indexOf(".")+1);
            if(cl.indexOf("_") > 0) { //有驼峰标识的字段
                rtSql.append(",").append(col).append(" as ").append(cl.substring(0, cl.indexOf("_")))
                        .append(cl.substring(cl.indexOf("_") + 1).substring(0, 1).toUpperCase())
                        .append(cl.substring(cl.indexOf("_") + 1).substring(1));
            }else{
                rtSql.append(",").append(col).append(" as ").append(cl);
            }
        }
        return rtSql.substring(1);
    }

}
