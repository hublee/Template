package com.libsamp.service.shiro;


import com.libsamp.dto.ShiroUser;
import com.libsamp.entity.Resource;
import com.libsamp.entity.Role;
import com.libsamp.entity.User;
import com.libsamp.mapper.RoleMapper;
import com.libsamp.mapper.UserMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ShiroDbRealm extends AuthorizingRealm{
  @Autowired
  private UserMapper userMapper;
  @Autowired
  private RoleMapper roleMapper;

  protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
    SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
    List<Role> roleList = roleMapper.getRolesByUserId(shiroUser.getId());
    if(null != roleList && roleList.size() > 0) {
      List<Integer> roleIds = null;
      for (Role role : roleList) {
        //基于role的权限信息
        info.addRole(role.getCode());
        if(null == roleIds){
          roleIds = new ArrayList<>();
        }
        roleIds.add(role.getId());
      }

      //基于permissions的权限信息
      List<Resource>  resources = roleMapper.getResourcesByRoleIds(roleIds);
      if(null != resources){
        Set<String> resCodes = null;
        for(Resource res : resources){
          if(null == resCodes) resCodes = new HashSet<>();
          resCodes.add(res.getCode());
        }
        info.addStringPermissions(resCodes);
      }
    }
    return info;
  }

  /**
   *  认证回调函数,登录时调用.
   */
  protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
    UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
    User user = userMapper.selectOne(new User(token.getUsername()));
    if (user != null) {
      if(user.getIsEnable() == 0) throw new DisabledAccountException();

      return new SimpleAuthenticationInfo(new ShiroUser(user.getId(),user.getName()),user.getPassword(),getName());
    } else {
      throw new UnknownAccountException();
    }
  }

  @PostConstruct
  public void initCredentialsMatcher(){
    setCredentialsMatcher(new CustomCredentialsMatcher());
  }

}