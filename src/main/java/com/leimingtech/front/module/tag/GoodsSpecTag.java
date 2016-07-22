package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.GoodsService;

import freemarker.template.TemplateModelException;

/**
 * 商品规格标签
 * @author lkang
 * @version 2015-07-02 17:40:00
 */
@Component
public class GoodsSpecTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsService goodsService;
	
	/**
	 * 商品规格
	 * @param goodsid 商品id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		Integer goodId = ParamsUtils.getInt(params.get("goodsid"));
		Map<String, Object> goodsspec = goodsService.getGoodsSpec(goodId);
		return goodsspec;
	}

}
