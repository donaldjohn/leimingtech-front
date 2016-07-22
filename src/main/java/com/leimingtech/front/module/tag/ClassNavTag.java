package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.leimingtech.core.common.CommonConstants;
import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.GoodsClass;
import com.leimingtech.core.entity.base.Brand;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.goods.service.BrandService;
import com.leimingtech.service.module.goods.service.GoodsClassService;

import freemarker.template.TemplateModelException;

/**
 * 商品列表页面包线分类标签
 * @author kviuff
 * @date 2015-07-14
 */

@Component
public class ClassNavTag extends BaseFreeMarkerTag {

	@Resource
    private GoodsClassService goodsClassService;
	
	@Resource
    private BrandService brandService;
	
	/**
	 * @param classId 商品分类id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		String classId = ParamsUtils.getString(params.get("classId"));
		String searchType = ParamsUtils.getString(params.get("searchType"));
		String nav = "";
		if("gcIdSearch".equals(searchType)){ // 根据分类id搜索－列表页
			nav = getClassNav(classId);
		}else if("BrandIdSearch".equals(searchType)){ // 根据品牌id搜索－列表页
			Brand brand = brandService.findById(Long.parseLong(classId));
			nav += "<span class=\"arrow\">&gt;</span>";
			nav += "<span>";
			nav += "<a href=\"" + CommonConstants.FRONT_SERVER 
					+ "/search/goodsSearch?searchType=BrandIdSearch&keyword=" 
					+ brand.getBrandId() + "\">";
			nav += brand.getBrandName();
			nav += "</a>";
			nav += "</span>";
		}else if(!searchType.equals("keywordSearch") && !searchType.equals("allSearch")){ // 商品详细页
			nav = getClassNav(classId);
		}
		return nav;
	}
	
	/**
	 * 根据classId获取分类路径
	 * @param classId
	 * @return
	 */
	private String getClassNav(String classId){
		String nav = "";
		if(StringUtils.isBlank(classId)){
			return nav;
		}
		GoodsClass gClass = goodsClassService.findById(Integer.parseInt(classId));
		if(gClass!=null){
			String gcIdpath = gClass.getGcIdpath();
			String[] idpath = gcIdpath.split(",");
			for (String string : idpath) {
				gClass = goodsClassService.findById(Integer.parseInt(string));
				String gcName = gClass.getGcName();
				nav += "<span class=\"arrow\">&gt;</span>";
				nav += "<span><a href=\"" + CommonConstants.FRONT_SERVER 
						+ "/search/goodsSearch?searchType=gcIdSearch&keyword=" 
						+ string + "\">" + gcName + "</a></span>";
			}
		}
		return nav;
	}
	
}
