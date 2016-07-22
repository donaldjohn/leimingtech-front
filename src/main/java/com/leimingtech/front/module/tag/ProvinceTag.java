/**
 * 
 */
package com.leimingtech.front.module.tag;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.core.entity.Area;
import com.leimingtech.service.module.area.service.AreaService;

import freemarker.template.TemplateModelException;

/**
 * <p>Title: AdvTag.java</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2014-2018</p>
 * <p>Company: leimingtech.com</p>
 * @author linjm
 * @date 2015年7月9日
 * @version 1.0
 */
@Component
public class ProvinceTag extends BaseFreeMarkerTag{

	@Resource
	private AreaService areaService;
	
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		try {
			 List<Area> areas = areaService.queryAll();
			 return areas;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
