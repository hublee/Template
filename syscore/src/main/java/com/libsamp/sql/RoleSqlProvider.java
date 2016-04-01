package com.libsamp.sql;

import com.libsamp.entity.RoleResource;
import com.libsamp.entity.UserRole;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/26 0026.
 */
public class RoleSqlProvider {

    private final String USER_ROLE = "t_user_role";
    private final String ROLE_RES = "t_role_resource";
    private final String TB_ROLE = "t_role";

    public String batchInsertRoleSql(Map<String,Object> param){
        List<UserRole> userRoleList = (List<UserRole>) param.get("userRoles");
        StringBuffer values = new StringBuffer();
        if(null != userRoleList){
            for(UserRole ur : userRoleList){
                values.append(",(").append(ur.getUserId()).append(",").append(ur.getRoleId()).append(")");
            }
        }
        if(values.toString() == "") return "";
        BEGIN();
        INSERT_INTO(USER_ROLE);
        VALUES("user_id,role_id",values.substring(1));
        String sql = SQL().replace("VALUES (","VALUES ");
        return sql.substring(0,sql.length()-1);
    }

    public String batchInsertResSql(Map<String,Object> param){
        List<RoleResource> roleResources = (List<RoleResource>) param.get("roleResources");
        StringBuffer values = new StringBuffer();
        if(null != roleResources){
            for(RoleResource rr : roleResources){
                values.append(",(").append(rr.getRoleId()).append(",").append(rr.getResId()).append(")");
            }
        }
        if(values.toString() == "") return "";
        BEGIN();
        INSERT_INTO(ROLE_RES);
        VALUES("role_id,res_id",values.substring(1));
        String sql = SQL().replace("VALUES (","VALUES ");
        return sql.substring(0,sql.length()-1);
    }
}
