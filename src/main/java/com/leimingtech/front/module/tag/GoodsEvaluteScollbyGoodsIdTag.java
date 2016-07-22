package com.leimingtech.front.module.tag;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.trade.service.EvaluateGoodsService;

import freemarker.template.TemplateModelException;

/**
 * 商品评论列表
 * @author cgl
 * 添加时间：2015年08月10日14:26:40
 */
@Component
public class GoodsEvaluteScollbyGoodsIdTag extends BaseFreeMarkerTag {
	 @Resource
	 private EvaluateGoodsService evaluateGoodsService;
		/**
		 * 商品评论列表
		 * @param MemberId 会员id
		 * @param StoreId  店铺id
		 */
	 @SuppressWarnings("rawtypes")
		protected Object exec(Map params) throws TemplateModelException {
			// 商品id
			Integer goodsId = ParamsUtils.getInt(params.get("goodsId"));
			if(goodsId != null && goodsId != 0){
				//平均分
				BigDecimal avearageScoll = evaluateGoodsService.getAverageScoreByGooodsId(goodsId);
				
				if(avearageScoll == null){
					return 0;
				}
				
				return avearageScoll;
			}else{
				return 0;
			}
		}

}
