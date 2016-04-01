package com.libsamp.mapper;


import com.libsamp.entity.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by hlib on 2015/8/6 0006.
 */
@Repository
public interface UserMapper extends Mapper<User> {

    @Select("select * from t_user where name = #{name}")
    @Results(value = {
            @Result(id = true,property = "id",column = "id",javaType = Integer.class,jdbcType = JdbcType.INTEGER),
            @Result(property = "name",column = "name",javaType = String.class,jdbcType = JdbcType.VARCHAR),
            @Result(property = "nickName",column = "nick_name",javaType = String.class,jdbcType = JdbcType.VARCHAR),
            @Result(property = "isEnable",column = "is_enable",javaType = Integer.class,jdbcType = JdbcType.TINYINT)
    })
    User selectByName(@Param("name")String name);

    @Select("select count(0) from t_user where name = #{userName}")
    Integer isExistName(@Param("userName")String userName);

    @Select("select count(0) from t_user where email = #{email}")
    Integer isExistEmail(String email);

    @Update("update t_user set integralAmount = IFNULL(integralAmount,0)+#{riseAmount} where id = #{userId}")
    void updateIntegral(@Param("userId")Integer userId, @Param("riseAmount")Integer riseAmount);

    @Select("SELECT u.* FROM t_user u JOIN t_user_role ur ON(u.id=ur.userId) JOIN t_role r ON(r.id=ur.roleId) WHERE r.code = #{roleCode}")
    List<User> selectUserByRoleCode(@Param("roleCode")String roleCode);


}
