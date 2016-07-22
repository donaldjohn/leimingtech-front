package com.leimingtech.front.module.search.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.leimingtech.core.entity.ImageSet;
import com.leimingtech.core.entity.base.GoodsWords;
import com.leimingtech.core.entity.base.StoreWords;
import com.leimingtech.core.jackson.JsonUtils;
import com.leimingtech.service.module.goods.service.GoodsClassService;
import com.leimingtech.service.module.search.service.GoodsWordsService;
import com.leimingtech.service.module.search.service.StoreWordsService;
import com.leimingtech.service.module.setting.service.SettingService;

/**
 * 列表和搜索页面
 * @author cgl
 *
 */

@Controller
@RequestMapping("/search")
public class SearchAction {
	
	@Autowired
	GoodsWordsService goodsWordsService;
	
	@Autowired
	StoreWordsService storeWordsService;
	
	@Resource
    private SettingService settingService;
	
	/**
	 * 搜索商品
	 * @param searchType 搜索商品的类型,比如:搜索商品的名字,分类,类型,店铺
	 * @param keyword 关键词
	 * @param pageNo 分页的页码
	 * @param sortOrder 排序类型,desc,asc
	 * @param sortField 排序的字段
	 * @param filterConditions 过滤条件
	 * @return
	 */
	@RequestMapping("/goodsSearch")
	public ModelAndView goodsSearch(	
			@RequestParam(value="searchType",required=true, defaultValue="allSearch") String searchType,
			@RequestParam(value="keyword",required=false) String keyword,
			@RequestParam(value="pageNo",required=false)String pageNo,
			@RequestParam(value="filterConditions",required=false)String filterConditions,
			@RequestParam(value="specFilter",required=false)String specFilter,
			@RequestParam(value="sortField",required=false)String sortField,
			@RequestParam(value="sortOrder",required=false)String sortOrder
			){
		ModelAndView model = new ModelAndView("/search/goods-search");
		model.addObject("searchType", searchType);
		if(!searchType.equals("allSearch")){
			model.addObject("keyword", keyword);
		}else{
			model.addObject("keyword", "");
		}
		if(pageNo != null && !pageNo.equals("")){
			model.addObject("pageNo", pageNo);
		}
		if(filterConditions != null && !filterConditions.equals("")){
			model.addObject("filterConditions", filterConditions);
		}
		if(specFilter != null && !specFilter.equals("")){
			model.addObject("specFilter", specFilter);
		}
		if(sortField != null && !sortField.equals("")){
			model.addObject("sortField", sortField);
		}
		if(sortOrder != null && !sortOrder.equals("")){
			model.addObject("sortOrder", sortOrder);
		}
		//获取admin图片设置的尺寸大小
		Map<String,String> map = settingService.findByNameResultMap("images");
		ImageSet imageSet = new ImageSet();
		imageSet.setBig_pic_height(Integer.valueOf(map.get("big_pic_height")));
		imageSet.setBig_pic_width(Integer.valueOf(map.get("big_pic_width")));
		imageSet.setSmall_pic_height(Integer.valueOf(map.get("small_pic_height")));
		imageSet.setSmall_pic_width(Integer.valueOf(map.get("small_pic_width")));
		imageSet.setThumbnail_pic_height(Integer.valueOf(map.get("thumbnail_pic_height")));
		imageSet.setThumbnail_pic_width(Integer.valueOf(map.get("thumbnail_pic_width")));
		imageSet.setTiny_pic_height(Integer.valueOf(map.get("tiny_pic_height")));
		imageSet.setTiny_pic_width(Integer.valueOf(map.get("tiny_pic_width")));
		model.addObject("imageSet", imageSet);
		//图片目录
		model.addObject("toUrl", "/search/goodsSearch");// 跳转URL
		return model;
	}
	
	/**
	 * 搜索商品
	 * @param keyword 关键词
	 * @param pageNo 分页的页码
	 * @param sortOrder 排序类型,desc,asc
	 * @param sortField 排序的字段
	 * @param filterConditions 过滤条件
	 * @return  storeSearchService
	 */
	@RequestMapping("/storeSearch")
	public ModelAndView storeSearch(	
			@RequestParam(value="keyword",required=false) String keyword,
			@RequestParam(value="pageNo",required=false)String pageNo,
			@RequestParam(value="filterConditions",required=false)String filterConditions,
			@RequestParam(value="sortField",required=false)String sortField,
			@RequestParam(value="sortOrder",required=false)String sortOrder
			){
		ModelAndView model = new ModelAndView("/search/store-search");
		if(pageNo != null && !pageNo.equals("")){
			model.addObject("pageNo", pageNo);
		}
		if(keyword != null && !keyword.equals("")){
			model.addObject("keyword", keyword);
		}
		if(filterConditions != null && !filterConditions.equals("")){
			model.addObject("filterConditions", filterConditions);
		}
		if(sortField != null && !sortField.equals("")){
			model.addObject("sortField", sortField);
		}
		if(sortOrder != null && !sortOrder.equals("")){
			model.addObject("sortOrder", sortOrder);
		}

		//图片目录
		model.addObject("toUrl", "/search/storeSearch");// 跳转URL
		return model;
	}
	
	/**
	 * 商品关键词的匹配搜索
	 */
	@ResponseBody
	@RequestMapping("/goodsKeywordMatch")
	public String goodsKeywordMatch(String keyword){
		
		if(StringUtils.isNotEmpty(keyword)){
		
			List<GoodsWords> list = goodsWordsService.keywordMatch(keyword);
			
			String jsonStr = JsonUtils.toJsonStr(list);
			
			return jsonStr;
			
			}
		
		return "";
	}
	
	/**
	 * 店铺关键词的匹配搜索
	 */
	@ResponseBody
	@RequestMapping("/storeKeywordMatch")
	public String storeKeywordMatch(String keyword){
		
		if(StringUtils.isNotEmpty(keyword)){
			
			List<StoreWords> list = storeWordsService.keywordMatch(keyword);
			
			String jsonStr = JsonUtils.toJsonStr(list);
			
			return jsonStr;
			
		}
		
		return "";
	}
	
}
