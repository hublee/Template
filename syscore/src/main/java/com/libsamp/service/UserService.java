package com.libsamp.service;

import com.libsamp.entity.Attachment;
import com.libsamp.entity.User;

import java.util.List;
import java.util.Map;

/**
 * Created by hlib on 2015/8/6 0006.
 */
public interface UserService extends BaseService<User> {

    User disableUser(Integer id, Integer isEnable) throws Exception;

    /**
     * 校验用户名是否已被注册
     * @param userName
     * @return
     */
    Boolean isExistName(String userName);

    /**
     * 校验邮箱是否已被注册
     * @param email
     * @return
     */
    Boolean isExistEmail(String email);

    List<User> getUserByRoleCode(String roleCode);


    Map<Integer,User> getUserMapByIds(List<Integer> ids);

    /**
     * 用户头像map
     * @param ids 文件id
     * @return
     */
    Map<Integer,Attachment> getIconMap(List<Integer> ids);
}
