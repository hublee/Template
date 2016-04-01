package com.libsamp.service;


import com.libsamp.entity.ActionLog;

/**
 * Created by hlib on 2015/8/20 0020.
 */
public interface ActionLogService extends BaseService<ActionLog>{

    void log(String log);
}
