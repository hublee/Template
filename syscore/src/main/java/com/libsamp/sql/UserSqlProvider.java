package com.libsamp.sql;

import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/25 0025.
 */
public class UserSqlProvider {

    private static final String TABLE = "t_user";

    public String selectByNameSql(Map<String,Object> params){
        BEGIN();
        SELECT(" id,name,nick_name,password,email,create_time,update_time,is_enable ");
        FROM(TABLE);
        String name = params.get("name") + "";
        if(null != name){
            WHERE("name = #{name,javaType=String,jdbcType=VARCHAR}");
        }
        return SQL();
    }


}
