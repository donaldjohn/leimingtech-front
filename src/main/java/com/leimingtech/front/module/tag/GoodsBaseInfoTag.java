package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.base.Goods;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.GoodsService;

import freemarker.template.TemplateModelException;

/**
 * 商品基本属性标签
 * @author lkang
 * @version 2015-07-02 18:30:00
 */
@Component
public class GoodsBaseInfoTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsService goodsService;
	
	/**
	 * 商品基本属性
	 * @param goodsid 商品id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		Goods goods = goodsService.findGoodById(ParamsUtils.getInt(params.get("goodsid")));
		if(null == goods){
			goods = new Goods();
		}
		return goods;
	}

}
