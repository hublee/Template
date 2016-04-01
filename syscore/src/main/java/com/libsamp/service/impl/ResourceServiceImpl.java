package com.libsamp.service.impl;

import com.libsamp.annotation.Logable;
import com.libsamp.dto.EasyuiTree;
import com.libsamp.entity.Resource;
import com.libsamp.mapper.ResourceMapper;
import com.libsamp.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by hlib on 2015/8/10 0010.
 */
@Service("resourceService") @Transactional(readOnly = true)
public class ResourceServiceImpl extends BaseServiceImpl<ResourceMapper,Resource> implements ResourceService {

    @Autowired
    public void setMapper(ResourceMapper mapper) {
        this.mapper = mapper;
        this.busName = "资源菜单";
    }

    @Override
    public List<EasyuiTree> getEasyuiTree(Resource param) {
        param.setDelFlag(1);
        List<Resource> resourceList = getList(param);
        List<EasyuiTree>  parents = new ArrayList<>();
        EasyuiTree root = new EasyuiTree();
        EasyuiTree parent;
        for(Resource res : resourceList){
            if(res.getId() == 0){
                root = new EasyuiTree(res);
            }else if(res.getPid() == 0){
                parent = new EasyuiTree(res);
                parent.setState("closed");
                parent.setIconCls("icon-filter");
                //子节点
                List<EasyuiTree> children = new ArrayList<>();
                EasyuiTree child;
                for(Resource childRes : resourceList){
                    if(childRes.getPid() == parent.getId()){
                        child = new EasyuiTree(childRes);
                        children.add(child);
                    }
                }
                parent.setChildren(children);
                parents.add(parent);
            }
        }
        root.setChildren(parents);
        List<EasyuiTree> rtTree = new ArrayList<>();
        rtTree.add(root);
        return rtTree;
    }

    @Transactional(readOnly = false) @Logable(option = "删除菜单节点")
    public void deleteById(Integer id) {
        //删除子节点
        Example example = new Example(Resource.class);
        example.createCriteria().andEqualTo("pid",id);
        List<Resource> resources = mapper.selectByExample(example);
        if(null != resources && resources.size() > 0){
            List<Integer> sids = new ArrayList<>();
            for(Resource res : resources) sids.add(res.getId());
            deleteByIds(sids);
        }
        super.deleteById(id);
    }
}
