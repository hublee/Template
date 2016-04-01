package com.libsamp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by hlib on 2015/9/6 0006.
 */
public class DateUtil {

    public static String getTimeStr(Date date,String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }


    public static Date getDate(String source,String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = sdf.parse(source);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static Long getTime(Date date,String format){
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        String timeStr = sdf.format(date);
        Date newDate = null;
        try {
            newDate = sdf.parse(timeStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return newDate.getTime();
    }
}
