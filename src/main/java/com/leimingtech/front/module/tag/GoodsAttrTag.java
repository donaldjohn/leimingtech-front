package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.GoodsService;

import freemarker.template.TemplateModelException;

/**
 * 商品基本属性标签
 * @author lkang
 * @version 2015-07-02 18:30:00
 */
@Component
public class GoodsAttrTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsService goodsService;
	
	/**
	 * 商品属性
	 * @param goodsid商品id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		Map<String, Object> goodsAttr = goodsService.getGoodsAttr(ParamsUtils.getInt(params.get("goodsid")));
		return goodsAttr;
	}

}
