package com.libsamp.service.impl;

import com.libsamp.entity.ActionLog;
import com.libsamp.mapper.ActionLogMapper;
import com.libsamp.service.ActionLogService;
import com.libsamp.util.Page;
import com.libsamp.util.SystemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by hlib on 2015/8/20 0020.
 */
@Service("actionLogService")
public class ActionLogServiceImpl extends BaseServiceImpl<ActionLogMapper,ActionLog> implements ActionLogService {

    @Autowired
    public void setMapper(ActionLogMapper mapper) {
        this.mapper = mapper;
    }

    /**
     * 重写父类insert方法 避免记录日志造成死循环
     * @param vo
     * @return
     */
    @Override @Transactional(readOnly = false)
    public ActionLog add(ActionLog vo){
        return super.add(vo);
    }

    /**
     * 自定义日志记录器
     * @param log
     */
    @Override @Transactional(readOnly = false)
    public void log(String log) {
        try {
            ActionLog actionLog = new ActionLog();
            actionLog.setUserId(SystemUtil.currentUser().getId());
            actionLog.setActionDescr(log);
            add(actionLog);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Page<ActionLog> getListByPage(ActionLog actionLog, int pageNo, int pageSize) {
//        PageHelper.startPage(pageNo,pageSize);
//        List<ActionLog> actionLogList = mapper.getListByJoin(actionLog);
//        PageInfo pageInfo = new PageInfo(actionLogList);
//        return new Page<>(actionLogList,Long.valueOf(pageInfo.getTotal()).intValue(),pageNo,pageSize);
        return super.getListByPage(actionLog,pageNo,pageSize);
    }
}
