package com.libsamp.sql;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/26 0026.
 */
public class AttachmentSqlProvider {

    private static final String TABLE = "t_attachment";

    public String getBySourceIdAndEntity(Map<String,Object> param){
        Object sourceEntity = param.get("entity");
        Object sourceType = param.containsKey("type") ? param.get("type") : null;
        List<Integer> sourceIds = (List<Integer>) param.get("sourceIds");
        if(null == sourceIds) sourceIds = new ArrayList<>();
        StringBuffer ids = new StringBuffer("(");
        for(Object id : sourceIds) ids.append(id).append(",");
        ids.append("-1)");
        BEGIN();
        SELECT("*");FROM(TABLE);
        StringBuffer condition = new StringBuffer("id in " + ids);
        if(null != sourceEntity && !"".equals(sourceEntity.toString())){
            condition.append(" and source_entity = '" + sourceEntity +"'");
        }
        if(null != sourceType && !"".equals(sourceType.toString())){
            condition.append(" and source_type = '" + sourceType +"'");
        }
        WHERE(condition.toString());
        return SQL();
    }

}
