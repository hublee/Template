package com.libsamp.util;

/**
 * Created by hlib on 2015/8/20 0020.
 */
public class Constants {

    public static final String UPLOAD_URI = "/attaches";
//    public static final String UPLOAD_URI = "D:\\program\\apache-tomcat-7.0.55\\webapps\\top9_server\\attaches";

    public static final Integer DAY_MAX_INTEGRAL = 10; //每日积分上限

    public static final String SEARCH_INDEX_DIR = "D:\\lucene_index\\3"; //全文搜索索引目录

    public static final String AESKEY = "num1zeus123456";

    //亲加通讯配置参数
    private static final String GOTYE_APPKEY = "587ac548-6e6b-443b-8629-90cb903f1382";
    private static final String GOTYE_DEV_ACCOUNT = "niulei@libsamp.com";
    private static final String GOTYE_DEV_PWD = "wawjy6d5";
    public static final String GOTYE_URL = "https://voichannel.aichat.com.cn:8443/respApi/room?type=1&appKey="+GOTYE_APPKEY+"&devAccount="+GOTYE_DEV_ACCOUNT+"&devPwd="+GOTYE_DEV_PWD;

}
