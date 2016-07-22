package com.leimingtech.front.module.tag;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.leimingtech.core.entity.base.Brand;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.BrandService;

import freemarker.template.TemplateModelException;

/**
 * 品牌标签
 * @author lkang
 * 2015-07-01 17:40:00
 */
@Component
public class BrandTag extends BaseFreeMarkerTag {

	@Resource
    private BrandService brandService;
	
	/**
	 * 品牌列表
	 * @param classid 分类id
	 * @param storeid 店铺id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		String classIdStr = params.get("classid") + ""; // 分类id
		String storeIdStr = params.get("storeid") + ""; // 店铺id
		String typeIdStr = params.get("typeid") + ""; // 店铺id
		List<Brand> brandList = new ArrayList<Brand>();
		if(StringUtils.isNotEmpty(classIdStr) && !"null".equals(classIdStr)){ // 根据分类id获取分类下的品牌
			int classId = Integer.parseInt(params.get("classid") + "");
			brandList = brandService.findByClassId(classId);
		} else if(StringUtils.isNotEmpty(storeIdStr) && !"null".equals(storeIdStr)){ // 根据店铺id获取店铺下的品牌
			int storeId = Integer.parseInt(storeIdStr);
			brandList = brandService.getBrandListByStoreId(storeId);
		} else if(StringUtils.isNotEmpty(typeIdStr) && !"null".equals(typeIdStr)){//根据typeid获得所有品牌
			int typeId = Integer.parseInt(typeIdStr);
			brandList = brandService.getBrandListByTypeId(typeId);
		}else { // 获取全部的品牌
			brandList = brandService.findList();
		}
		return brandList;
	}

}
