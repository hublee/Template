package com.libsamp.service;

import com.libsamp.annotation.Logable;
import com.libsamp.dto.ShiroUser;
import com.libsamp.entity.ActionLog;
import com.libsamp.entity.User;
import com.libsamp.service.impl.BaseServiceImpl;
import com.libsamp.util.SystemUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;

/**
 * Created by hlib on 2015/8/21 0021.
 */
@Aspect
@Service
public class LogInterceptor {

    @Autowired
    private ActionLogService logService;

    /*@Autowired
    private UserService userService;*/

    @Pointcut("execution(* com.libsamp..*.*(..))")
    public void busMethod(){
        System.out.println("记录日志");
    }

    @Around(value = "busMethod() && @annotation(logable) && args(object,..)",argNames = "logable,object")
    public Object doAround(ProceedingJoinPoint joinPoint,Logable logable,Object object) throws Throwable{
        ActionLog actionLog = new ActionLog();
        ShiroUser user = SystemUtil.currentUser();
        if(null != user) {
            actionLog.setUserId(user.getId());
        }else{ //app用户
        }
        BaseServiceImpl target = (BaseServiceImpl) joinPoint.getTarget();
        String modelName = target.getBusName();
        actionLog.setActionDescr(logable.option() + modelName);
        actionLog.setBusName(modelName);
        actionLog.setEntityClass(target.getEntityClass().getName());
        String method = joinPoint.getSignature().getName();

        Object rtObj = null;
        //记录增删改的操作业务id
        switch (method){
            case "removeByIds":
            case "removeById":
                actionLog.setBusId(joinPoint.getArgs()[0]+"");
                break;
            case "add":
            case "modify":
                rtObj = joinPoint.proceed();
                Class clazz =  rtObj.getClass();
                Field field = clazz.getDeclaredField("id");
                field.setAccessible(true);
                Integer busId = (Integer) field.get(rtObj);
                actionLog.setBusId(busId+"");
                if(actionLog.getEntityClass().equals(User.class.getName()) //记录注册用户的id
                        && "注册".equals(logable.option())
                        && null == actionLog.getUserId()){
                    actionLog.setUserId(busId);
                }
                break;
            case "save":
                Object entity = joinPoint.getArgs()[0];
                Class clazz2 =  entity.getClass();
                Field field2 = clazz2.getDeclaredField("id");
                field2.setAccessible(true);
                Integer id2 = (Integer) field2.get(entity);
                String optionType = (null == id2 ? logable.option().split("/")[0] : logable.option().split("/")[1]); //判断添加或修改
                actionLog.setActionDescr(optionType + modelName);
                rtObj = joinPoint.proceed();
                actionLog.setBusId(field2.get(entity)+"");  //重新获取返回的id
                break;
        }
        logService.add(actionLog);
        return null == rtObj ? joinPoint.proceed() : rtObj;
    }


}
