package com.libsamp.service.impl;

import com.libsamp.dto.EasyuiTree;
import com.libsamp.dto.ResourceTree;
import com.libsamp.entity.*;
import com.libsamp.mapper.RoleMapper;
import com.libsamp.service.ResourceService;
import com.libsamp.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by hlib on 2015/8/11 0011.
 */
@Service("roleService")
@Transactional(readOnly = true)
public class RoleServiceImpl extends BaseServiceImpl<RoleMapper,Role> implements RoleService {

    @Autowired
    public void setMapper(RoleMapper mapper) {
        this.mapper = mapper;
        this.busName = "角色";
    }

    @Autowired
    private ResourceService resService;

    @Override
    @Transactional(readOnly = false) //开启事务
    public void batchInsertRole(Set<Integer> roleIds, Integer userId) {
        emptyRoleByUserId(userId);
        List<UserRole> userRoleList = new ArrayList<>();
        UserRole ur;
        for(Integer roleId : roleIds){
            ur = new UserRole(userId,roleId);
            userRoleList.add(ur);
        }
        insertBatchRole(userRoleList);
    }

    @Transactional(readOnly = false)
    public void emptyRoleByUserId(Integer userId){
        mapper.emptyRoleByUserId(userId);
    }


    @Override
    @Transactional(readOnly = false) //开启事务
    public void batchInsertRes(Set<Integer> resIds, Integer roleId) {
        //先清空所有权限再插入
        emptyResByRole(roleId);
        List<RoleResource> roleResourceList = new ArrayList<>();
        RoleResource rr;
        for(Integer resId : resIds){
            rr = new RoleResource(roleId,resId);
            roleResourceList.add(rr);
        }
        mapper.insertBatchRes(roleResourceList);
    }


    @Transactional(readOnly = false)
    public void emptyResByRole(Integer roleId){
        mapper.emptyResByRole(roleId);
    }

    @Override
    public List<EasyuiTree> getResourceTreeByRoleId(Integer roleId) {
        List<EasyuiTree> allNodes =  resService.getEasyuiTree(new Resource());
        Set<Integer> resIdSet = getResIdsByRoleId(roleId);
        for(EasyuiTree node : allNodes){
            if(null != node.getChildren()){
                for(EasyuiTree child : node.getChildren()){
                    if(null != child.getChildren()){
                        for(EasyuiTree child2 : child.getChildren()){
                            if(resIdSet.contains(child2.getId())) child2.setChecked(true);
                        }
                    }
                }
            }
        }
        return allNodes;
    }

    @Override
    public List<Resource> getResourcesByRoleId(Integer roleId) {
        List<Integer> roleIds = new ArrayList<>();
        roleIds.add(roleId);
        List<Resource> resourceList = mapper.getResourcesByRoleIds(roleIds);
        return resourceList;
    }

    private Set<Integer> getResIdsByRoleId(Integer roleId){
        List<Resource> resourceList = getResourcesByRoleId(roleId);
        Set<Integer> idSet = new HashSet<Integer>();
        for(Resource res : resourceList){
            idSet.add(res.getId());
        }
        return idSet;
    }

    @Override
    public List<Role> getRoleByUserId(Integer userId) {
        return mapper.getRolesByUserId(userId);
    }

    @Override
    public List<Resource> getResourcesByRoleIds(List<Integer> roleIds) {
        return mapper.getResourcesByRoleIds(roleIds);
    }

    @Override
    public List<ResourceTree> loadResourceTreeByUser(User user) {

        List<Role> roles = getRoleByUserId(user.getId());

        List<Integer> roleIds = new ArrayList<Integer>();
        for(Role role : roles) roleIds.add(role.getId());
        List<Resource> resourceList =  getResourcesByRoleIds(roleIds);

        List<ResourceTree> resTree = new ArrayList<>(); //系统目录菜单
        for(Resource res : resourceList){
            if(null != res.getPid() && res.getPid() == 0){
                resTree.add(new ResourceTree(res,new ArrayList<Resource>()));
            }
        }

        /**遍历父菜单找子菜单*/
        for(ResourceTree parent : resTree){
            for(Resource child : resourceList){
                if(child.getPid() == parent.getId()){
                    parent.getChildren().add(child);
                }
            }
        }
        return resTree;
    }

    @Override @Transactional(readOnly = false)
    public void insertBatchRole(List<UserRole> userRoleList) {
        mapper.insertBatchRole(userRoleList);
    }

    @Override
    public Set<String> getResCode(Integer roleId) {
        List<Resource> resList =  getResourcesByRoleId(roleId);
        if(null == resList || resList.size() <= 0) return null;
        Set<String> resCodes = null;
        for(Resource res : resList){
            if(null == resCodes) resCodes = new HashSet<>();
            resCodes.add(res.getCode());
        }
        return resCodes;
    }
}
