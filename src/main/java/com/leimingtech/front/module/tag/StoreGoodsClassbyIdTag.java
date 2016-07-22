package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.StoreGoodsClass;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.store.service.StoreGoodsClassService;

import freemarker.template.TemplateModelException;

/**
 * 商店自定义分类页标签
 * @author gyh
 * @version 2015-07-09 17:30:00
 */
@Component
public class StoreGoodsClassbyIdTag extends BaseFreeMarkerTag {
	@Resource
	private StoreGoodsClassService storeGoodsClassService;
	
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		//商店自定义分类ID
		int Stid=ParamsUtils.getInt(params.get("Stid"));
		StoreGoodsClass storeGoodsClass=null;
		if(Stid!=0){
			 storeGoodsClass=storeGoodsClassService.selectByPrimaryKey(Stid);
		}
		return storeGoodsClass;
	}
}
