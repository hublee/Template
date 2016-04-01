package com.libsamp.mapper;


import com.libsamp.entity.Attachment;
import com.libsamp.sql.AttachmentSqlProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by hlib on 2015/8/14 0014.
 */
public interface AttachmentMapper extends Mapper<Attachment> {

    List<Attachment> selectListByIds(List<Integer> ids);

    @SelectProvider(type = AttachmentSqlProvider.class,method = "getBySourceIdAndEntity")
    List<Attachment> selectBySourceIdAndEntity(@Param("sourceIds")List<Integer> sourceIds,@Param("entity")String entity);

    @SelectProvider(type = AttachmentSqlProvider.class,method = "getBySourceIdAndEntity")
    List<Attachment> selectBySourceIdAndEntityAndType(@Param("sourceIds")List<Integer> sourceIds,
                                                      @Param("entity")String entity,@Param("type")String type);
}
