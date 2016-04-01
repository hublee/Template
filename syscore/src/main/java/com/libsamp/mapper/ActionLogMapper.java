package com.libsamp.mapper;


import com.libsamp.entity.ActionLog;
import com.libsamp.sql.ActionLogSqlProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by hlib on 2015/8/20 0020.
 */
public interface ActionLogMapper extends Mapper<ActionLog> {

    @SelectProvider(type = ActionLogSqlProvider.class,method = "getJoinSql")
    List<ActionLog> getListByJoin(@Param("actionLog")ActionLog actionLog);
}
