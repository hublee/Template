package com.libsamp.service.impl;

import com.libsamp.annotation.Logable;
import com.libsamp.entity.Attachment;
import com.libsamp.entity.User;
import com.libsamp.mapper.UserMapper;
import com.libsamp.service.AttachmentService;
import com.libsamp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by hlib on 2015/8/6 0006.
 */
@Service("userService") @Transactional(readOnly = true)
public class UserServiceImpl extends BaseServiceImpl<UserMapper,User> implements UserService {

    @Autowired
    private AttachmentService attachmentService;

    private Map<String,Object> tokenMap = new ConcurrentHashMap<>();

    @Autowired
    public void setMapper(UserMapper mapper) {
        this.mapper = mapper;
        this.busName = "用户";
    }
    @Override
    public User getByName(String name) {
        return mapper.selectByName(name);
    }

    @Override @Transactional(readOnly = false) @Logable(option = "封禁/解封")
    public User disableUser(Integer id,Integer isEnable) throws Exception{
        User user = new User();
        user.setId(id);
        user.setIsEnable(isEnable);
        return modify(user);
    }

    @Override
    public Boolean isExistName(String userName) {
        return mapper.isExistName(userName) > 0 ? true : false;
    }

    @Override
    public Boolean isExistEmail(String email) {
        return mapper.isExistEmail(email) > 0 ? true : false;
    }

    @Override @Transactional(readOnly = false)
    public void updateIntegral(Integer userId, Integer changedValue) {
        mapper.updateIntegral(userId,changedValue);
    }

    public Map<String, Object> getTokenMap() {
        return tokenMap;
    }

    @Override
    public List<User> getUserByRoleCode(String roleCode) {
        return mapper.selectUserByRoleCode(roleCode);
    }

    @Override
    public Map<Integer, User> getUserMapByIds(List<Integer> ids) {
        Example example = new Example(User.class);
        example.createCriteria().andIn("id",ids);
        List<User> cmtUsers = mapper.selectByExample(example);
        Map<Integer,User> userMap = new HashMap<>();
        for(User u : cmtUsers) userMap.put(u.getId(),u);
        return userMap;
    }

    @Override
    public Map<Integer, Attachment> getIconMap(List<Integer> ids) {
        List<Attachment> usAttaches = attachmentService.getBySourceIdAndEntity(ids,User.class.getName());
        Map<Integer,Attachment> iconMap = new HashMap<>();
        for(Attachment atta : usAttaches){
            if(!User.FileType.icon.equals(atta.getSourceType())) continue;
            if(!iconMap.containsKey(atta.getSourceId())) iconMap.put(atta.getSourceId(),atta);
        }
        return iconMap;
    }
}
