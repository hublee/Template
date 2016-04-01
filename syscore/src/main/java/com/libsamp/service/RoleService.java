package com.libsamp.service;


import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.ResourceTree;
import com.libsamp.entity.Resource;
import com.libsamp.entity.Role;
import com.libsamp.entity.User;
import com.libsamp.entity.UserRole;

import java.util.List;
import java.util.Set;

/**
 * Created by hlib on 2015/8/11 0011.
 */
public interface RoleService extends BaseService<Role> {

    void batchInsertRole(Set<Integer> roleId, Integer userId);

    void batchInsertRes(Set<Integer> resIds, Integer roleId);

    List<EasyuiTree> getResourceTreeByRoleId(Integer roleId);

    List<Resource> getResourcesByRoleId(Integer roleId);

    List<Role> getRoleByUserId(Integer userId);

    List<Resource> getResourcesByRoleIds(List<Integer> roleIds);

    List<ResourceTree> loadResourceTreeByUser(User user);

    void insertBatchRole(List<UserRole> userRoleList);

    Set<String> getResCode(Integer roleId);

    List<Integer> getUserIdsByRoleId(Integer roleId);

}
