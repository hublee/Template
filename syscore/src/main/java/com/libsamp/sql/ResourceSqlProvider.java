package com.libsamp.sql;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/25 0025.
 */
public class ResourceSqlProvider {

    private static final String TABLE = "t_resource r";
    private static final String JOIN_ROLE_RESOURCE = "t_role_resource s";


    public String getRoleResSql(Map<String,Object> param){
        List<Integer> roleIds = (List<Integer>) param.get("roleIds");
        if(null == roleIds) roleIds = new ArrayList<>();
        StringBuffer ids = new StringBuffer("(");
        for(Object id : roleIds) ids.append(id).append(",");
        ids.append("-1)");
        BEGIN();
        SELECT("r.*");
        FROM(TABLE);
        INNER_JOIN(JOIN_ROLE_RESOURCE.concat(" on(r.id = s.res_id)"));
        WHERE("s.role_id in"+ids);
        return SQL();
    }
}
