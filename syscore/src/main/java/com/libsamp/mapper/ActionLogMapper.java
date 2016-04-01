package com.libsamp.mapper;


import com.libsamp.entity.ActionLog;
import com.libsamp.sql.ActionLogSqlProvider;
import com.libsamp.util.MyMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.List;

/**
 * Created by hlib on 2015/8/20 0020.
 */
public interface ActionLogMapper extends MyMapper<ActionLog> {

    @SelectProvider(type = ActionLogSqlProvider.class,method = "getJoinSql")
    List<ActionLog> getListByJoin(@Param("actionLog")ActionLog actionLog);
}
