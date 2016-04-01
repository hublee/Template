package com.libsamp.service.impl;

import com.libsamp.annotation.Logable;
import com.libsamp.dto.EasyuiTree;
import com.libsamp.entity.Dictionary;
import com.libsamp.mapper.DictionaryMapper;
import com.libsamp.service.DictionaryService;
import com.libsamp.util.DicUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hlib on 2015/8/10 0010.
 */
@Service("dictionaryService") @Transactional(readOnly = true)
public class DictionaryServiceImpl extends BaseServiceImpl<DictionaryMapper,Dictionary> implements DictionaryService {

    @Autowired
    public void setMapper(DictionaryMapper mapper) {
        this.mapper = mapper;
        this.busName = "数据字典";
    }

    @Override
    public List<EasyuiTree> getEasyuiTree(Dictionary param) {
        List<Dictionary> dictionaries = getList(param);
        List<EasyuiTree>  parents = new ArrayList<>();
        EasyuiTree root = new EasyuiTree();
        EasyuiTree parent;
        for(Dictionary dic : dictionaries){
            if(dic.getId() == 0){  //根节点
                root = new EasyuiTree(dic);
            }else if(dic.getDicPid() == 0){ //父节点
                parent = new EasyuiTree(dic);
                parent.setState("closed");  //默认不展开
                parent.setIconCls("icon-filter");
                //查找子节点
                List<EasyuiTree> children = new ArrayList<>();
                EasyuiTree child;
                for(Dictionary childDic : dictionaries){
                    if(childDic.getDicPid() == parent.getId()){
                        child = new EasyuiTree(childDic);
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

    @PostConstruct
    public void initDicMap(){
        List<Dictionary> dictionaryList =  getList(new Dictionary());
        DicUtil.initDicMap(dictionaryList);
    }

    @Override
    @Transactional(readOnly = false) @Logable(option = "删除数据字典")
    public void deleteById(Integer id) {
        //删除子节点
        Example example = new Example(Dictionary.class);
        example.createCriteria().andEqualTo("dicPid",id);
        List<Dictionary> childList = mapper.selectByExample(example);
        if(null != childList && childList.size() > 0){
            List<Integer> cids = new ArrayList<>();
            for(Dictionary child : childList) cids.add(child.getId());
            deleteByIds(cids);
        }
        super.deleteById(id);
    }
}
