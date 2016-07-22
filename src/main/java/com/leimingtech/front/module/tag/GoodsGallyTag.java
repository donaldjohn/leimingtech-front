package com.leimingtech.front.module.tag;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.GoodsService;

import freemarker.template.TemplateModelException;

/**
 * 商品相册标签
 * @author lkang
 * @version 2015-07-02 17:30:00
 */
@Component
public class GoodsGallyTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsService goodsService;
	
	/**
	 * 商品相册
	 * @param goodsid 商品id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		List<String> imgList = goodsService.getGoodsImgList(ParamsUtils.getInt(params.get("goodsid")));
		return imgList;
	}

}
