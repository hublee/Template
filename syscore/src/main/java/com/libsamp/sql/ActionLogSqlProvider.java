package com.libsamp.sql;

import com.libsamp.entity.ActionLog;
import com.libsamp.util.StrUtil;
import org.apache.commons.lang3.StringUtils;

import java.util.Map;

import static org.apache.ibatis.jdbc.SqlBuilder.*;

/**
 * Created by hlib on 2015/11/27 0027.
 */
public class ActionLogSqlProvider {

    private final String ACTION_LOG = "t_action_log a";
    private final String USER = "t_user u";
    private final String LOG_COL = "a.user_id,a.bus_id,a.bus_name,a.entity_class,a.action_descr," +
            "a.create_id,a.create_time,a.update_id,a.update_time,a.del_flag";

    public String getJoinSql(Map<String,Object> param){
        ActionLog actionLog = (ActionLog) param.get("actionLog");
        BEGIN();
        SELECT(StrUtil.addColAlias(LOG_COL).concat(",u.name as userName "));
        FROM(ACTION_LOG);
        LEFT_OUTER_JOIN(USER.concat(" on(a.user_id = u.id)"));
        StringBuffer condition = new StringBuffer(" 1=1 and a.del_flag=1 ");
        if(null != actionLog){
            if(StringUtils.isNotBlank(actionLog.getUserName())){
                condition.append(" and u.name like '%").append(actionLog.getUserName()).append("%'");
            }
            if(null != actionLog.getUserId()){
                condition.append(" and a.user_id=").append(actionLog.getUserId());
            }
            if(null != actionLog.getBusId()){
                condition.append(" and a.bus_id=").append(actionLog.getBusId());
            }
            if(StringUtils.isNotBlank(actionLog.getBusName())){
                condition.append(" and a.bus_name like '%").append(actionLog.getBusName()).append("%'");
            }
            if(StringUtils.isNotBlank(actionLog.getActionDescr())){
                condition.append(" and a.action_descr like '%").append(actionLog.getActionDescr()).append("%'");
            }
        }
        WHERE(condition.toString());
        return SQL();
    }
}
