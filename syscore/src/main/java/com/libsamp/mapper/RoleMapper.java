package com.libsamp.mapper;

import com.libsamp.entity.Resource;
import com.libsamp.entity.Role;
import com.libsamp.sql.ResourceSqlProvider;
import com.libsamp.util.MyMapper;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by hlib on 2015/8/11 0011.
 */
public interface RoleMapper extends MyMapper<Role> {

    @Select("select r.* from t_role r inner join t_user_role u on(r.id=u.role_id) where u.user_id = #{userId}")
    List<Role> getRolesByUserId(Integer userId);

    @SelectProvider(type = ResourceSqlProvider.class,method = "getRoleResSql")
    List<Resource> getResourcesByRoleIds(@Param("roleIds")List<Integer> roleIds);

    @Select("select u.user_id from t_role r inner join t_user_role u on(r.id=u.role_id) where u.role_id = #{roleId}")
    List<Integer> selectUserIdsByRoleId(Integer roleId);
}
