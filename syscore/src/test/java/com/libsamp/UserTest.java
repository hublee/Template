package com.libsamp;

import com.libsamp.entity.ActionLog;
import com.libsamp.entity.User;
import com.libsamp.mapper.DictionaryMapper;
import com.libsamp.mapper.UserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.ReflectionUtils;

import javax.persistence.Transient;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

/**
 * Created by hlib on 2015/11/25 0025.
 */
@ContextConfiguration(value = "classpath*:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class UserTest {

    @Autowired
    private DictionaryMapper dicMapper;

    @Autowired
    private UserMapper userMapper;

    @Test
    public void getUser(){

        User user =  userMapper.selectByName("pppplib");
//        user = userMapper.selectByPrimaryKey(31);
        System.out.println(user);

    }

    @Test
    public void testReflect(){
        ActionLog actionLog = new ActionLog();
        actionLog.setDelFlag(1);


        /*for(Field field : actionLog.getClass().getDeclaredFields()){
            System.out.println(field.getName());
        }*/

        boolean flag = true;
        for(Field field : actionLog.getClass().getSuperclass().getDeclaredFields()){
            Annotation[] annotation = field.getDeclaredAnnotations();
            for(Annotation anno : annotation){
                Class anType = anno.annotationType();
                if(anType == Transient.class) {
                    flag = false;
                    break;
                }
            }
            if(!flag) continue;
            System.out.println(field.getName());
            Class type = field.getType();
            System.out.println(type.getName());
        }

        /*for(Method method : actionLog.getClass().getMethods()){
            System.out.print(method.getName() + " -- ");
            method.setAccessible(true);
            Annotation annotation = method.getAnnotation(Transient.class);
            System.out.println(annotation);

        }*/

    }

}
