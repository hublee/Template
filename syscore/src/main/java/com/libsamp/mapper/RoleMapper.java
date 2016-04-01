package com.libsamp.mapper;

import com.libsamp.entity.Resource;
import com.libsamp.entity.Role;
import com.libsamp.entity.RoleResource;
import com.libsamp.entity.UserRole;
import com.libsamp.sql.ResourceSqlProvider;
import com.libsamp.sql.RoleSqlProvider;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by hlib on 2015/8/11 0011.
 */
@Repository
public interface RoleMapper extends Mapper<Role> {

    @Delete("delete from t_user_role where user_id = #{userId}")
    void emptyRoleByUserId(@Param("userId")Integer userId);

    @InsertProvider(type = RoleSqlProvider.class,method = "batchInsertRoleSql")
    void insertBatchRole(@Param("userRoles")List<UserRole> userRoles);

    @Delete("delete from t_role_resource where role_id = #{roleId}")
    void emptyResByRole(@Param("roleId")Integer roleId);

    @InsertProvider(type = RoleSqlProvider.class,method = "batchInsertResSql")
    void insertBatchRes(@Param("roleResources")List<RoleResource> roleResources);

    @Select("select r.* from t_role r inner join t_user_role u on(r.id=u.role_id) where u.user_id = #{userId}")
    List<Role> getRolesByUserId(Integer userId);

    @SelectProvider(type = ResourceSqlProvider.class,method = "getRoleResSql")
    List<Resource> getResourcesByRoleIds(@Param("roleIds")List<Integer> roleIds);
}
