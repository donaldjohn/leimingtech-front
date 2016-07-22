package com.leimingtech.front.module.tag;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.GoodsClass;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.GoodsClassService;

import freemarker.template.TemplateModelException;

/**
 * 商品分类的tag标签
 * @author LKANG
 * 添加时间：2015-06-30 12:12:00
 */
@Component
public class GoodsClassTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsClassService goodsClassService;
	
	/**
	 * 商品分类列表
	 * @param parentId  父级id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		String parendid = ParamsUtils.getString(params.get("parentid"));
		List<GoodsClass> classList = new ArrayList<GoodsClass>();
		GoodsClass goodsclass=new GoodsClass();
		goodsclass.setGcshow(1);//是否显示1为显示0为不显示
		if(StringUtils.isNotEmpty(parendid) && !"null".equals(parendid)){
			int parentId = Integer.parseInt(parendid); 
			goodsclass.setGcParentId(parentId);
			classList = goodsClassService.findListbyishow(goodsclass);
		}else{
			classList = goodsClassService.findAllbyisshow(goodsclass);
		}
		for (GoodsClass goodsClass : classList) {
			goodsClass.setDeep(goodsClass.getGcIdpath().split(",").length);
		}
		
		return classList;
	}

}
