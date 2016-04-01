package com.libsamp.mapper;


import com.libsamp.entity.Attachment;
import com.libsamp.sql.AttachmentSqlProvider;
import com.libsamp.util.MyMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.List;

/**
 * Created by hlib on 2015/8/14 0014.
 */
public interface AttachmentMapper extends MyMapper<Attachment> {

}
