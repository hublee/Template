package com.libsamp.mapper;


import com.libsamp.entity.User;
import com.libsamp.util.MyMapper;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * Created by hlib on 2015/8/6 0006.
 */
public interface UserMapper extends MyMapper<User> {

    @Select("SELECT u.* FROM t_user u JOIN t_user_role ur ON(u.id=ur.userId) JOIN t_role r ON(r.id=ur.roleId) WHERE r.code = #{roleCode}")
    List<User> selectUserByRoleCode(@Param("roleCode")String roleCode);


}
