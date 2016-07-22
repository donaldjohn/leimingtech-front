package com.leimingtech.front.module.tag;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.base.Goods;
import com.leimingtech.core.entity.base.GoodsRecommend;
import com.leimingtech.core.entity.base.RelGoodsRecommend;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.core.state.goods.GoodsState;
import com.leimingtech.service.module.goods.service.GoodsRecommendService;
import com.leimingtech.service.module.goods.service.RelGoodsRecommendService;

import freemarker.template.TemplateModelException;

/**
 * 推荐商品,最新上市,猜你喜欢商品的tag标签
 * @author LKANG
 * 添加时间：2015-08-25 12:12:00
 */
@Component
public class RecommendGoodsTag extends BaseFreeMarkerTag {

	@Resource
	private GoodsRecommendService goodsRecommendService;
	
	@Resource
	private RelGoodsRecommendService relGoodsRecommendService;
	
	/**
	 * 商品分类列表
	 * @param parentId  父级id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		String recommendName = ParamsUtils.getString(params.get("goodsflagsname"));//商品栏目名称
		List<RelGoodsRecommend> relGoodsRecommedlist=null;
		if(recommendName!=null&&!"".equals(recommendName)){
			GoodsRecommend goodsRecommend=new GoodsRecommend();
			goodsRecommend=goodsRecommendService.findBycolum(recommendName);
			if(goodsRecommend!=null){
				RelGoodsRecommend relGoodsRecommend=new RelGoodsRecommend();
				Goods goods=new Goods();
				relGoodsRecommend.setReCommendId(goodsRecommend.getReCommendid());
				goods.setGoodsShow((GoodsState.GOODS_ON_SHOW));//商品上架状态
				goods.setGoodsState(GoodsState.GOODS_OPEN_STATE);////商品状态审核通过
				relGoodsRecommend.setGoods(goods);
				relGoodsRecommedlist =relGoodsRecommendService.findgoodsList(relGoodsRecommend);
				relGoodsRecommend=null;//释放资源
				goods=null;
			}
		}
		return relGoodsRecommedlist;
	}

}
