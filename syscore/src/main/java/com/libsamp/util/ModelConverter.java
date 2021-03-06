package com.libsamp.util;

import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.ReflectionException;
import org.apache.ibatis.reflection.ReflectorFactory;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.log4j.Logger;

import java.lang.reflect.Field;
import java.util.*;

public class ModelConverter {

	static final Logger log = Logger.getLogger(ModelConverter.class);
	private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
	private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
	private static final ReflectorFactory DEFAULT_REFLECT_FACTORY = new DefaultReflectorFactory();
	
	@SuppressWarnings("unchecked")
	public static <T> T mapToModel(Map<String,Object> source,Class<T> clazz) {
		T target = null;
		if(source != null) 
			try {
				target = clazz.newInstance();
				MetaObject msObj = MetaObject.forObject(target, DEFAULT_OBJECT_FACTORY,DEFAULT_OBJECT_WRAPPER_FACTORY,DEFAULT_REFLECT_FACTORY);
				for (Map.Entry<String, Object> entry : source.entrySet()) {
					try {
						//log.info(entry.getValue().getClass());
						Object value = entry.getValue();
						if(value.getClass() == HashMap.class) {
							//log.info(entry.getKey());
							Field fd = clazz.getDeclaredField(entry.getKey());
							//Object obj = msObj.getValue(entry.getKey());
							//HashMap<String,Object> ms = (HashMap<String,Object>)msObj.getValue(entry.getKey());
							msObj.setValue(entry.getKey(),mapToModel((HashMap<String,Object>)value, fd.getType()));
							
						} else {
							msObj.setValue(entry.getKey(), entry.getValue());
						}
					} catch (ReflectionException e) {
						log.debug("not found property named '" + entry.getKey() + "' in '"+ clazz.getName() +"'");
					} catch (SecurityException e) {
						e.printStackTrace();
					} catch (NoSuchFieldException e) {
						log.debug("not found property named '" + entry.getKey() + "' in '"+ clazz.getName() +"'");
					}
				}
			} catch (InstantiationException e) {
				log.error(e);
			} catch (IllegalAccessException e) {
				log.error(e);
			}
		return target;
	}
	
	public static <T> List<T> toEntryList(List<? extends Map<String,Object>> sourceList,Class<T> clazz) {
		List<T> resultList = new ArrayList<T>();
		for (Map<String,Object> tmp : sourceList) {
			T mode = mapToModel(tmp, clazz);
			resultList.add(mode);
		}
		return resultList;
	}
	
	public static void main(String[] args) {
		Map<String,Object> m = new HashMap<String, Object>();
		//m.put("user", value)
		m.put("updateTime",new Date());
		m.put("xdfsdfs", new Date());
	}
}
