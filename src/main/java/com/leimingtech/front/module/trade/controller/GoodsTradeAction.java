package com.leimingtech.front.module.trade.controller;

import java.util.List;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.leimingtech.core.entity.vo.GoodsTradeVo;
import com.leimingtech.front.module.tag.TagsDataType;
import com.leimingtech.service.module.goods.service.GoodsService;
import com.leimingtech.service.utils.page.Pager;

/**
 * 
 *    
 * 项目名称：leimingtech-front   
 * 类名称：MyFavAction   
 * 类描述：   
 * 修改备注：   
 * @version    
 *
 */
@Controller
@RequestMapping("/goodsTrade")
@Slf4j
public class GoodsTradeAction {
    @Resource
	private GoodsService goodsService;
	/**
	 * 导航主页面跳转
	 * 
	 * @Title: index
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @param @param apm 加载的
	 * @param @return 设定文件
	 * @return ModelAndView 返回类型
	 * @throws RuntimeException
	 */
	@RequestMapping("/index")
	public ModelAndView index() {
		try {
			ModelAndView model = new ModelAndView("/goodstrade/goodstrade");
			GoodsTradeVo goodsTradeVo=new GoodsTradeVo();
			// 准备分页pager
			Pager pager = new Pager();
			pager.setPageSize(20);
			goodsTradeVo.setTradeGoodsCount("tradeGoodsCount");//按照交易商品数量排序
			goodsTradeVo.setOrderBy("desc");
			pager.setCondition(goodsTradeVo);//实体加载在pager中
			//查分页的list
			List<GoodsTradeVo> goodstradeList = goodsService.findTradeGoodPagerList(pager);//结果集;
			model.addObject("goodsTradeList", goodstradeList);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			log.error("商品交易加载失败！");
			throw new RuntimeException("导航失败!");
		}
	}

	
}
