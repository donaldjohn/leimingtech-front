package com.leimingtech.front.module.tag;

import java.text.NumberFormat;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.entity.base.EvaluateStore;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.front.module.store.util.Util;
import com.leimingtech.service.module.store.service.EvaluateStoreService;

import freemarker.template.TemplateModelException;

/**
 * 店铺评分表自定义标签
 * @author gyh
 * @version 2015-07-14 17:30:00
 */
@Component
public class EvaluateStorebyStoreIdTag extends BaseFreeMarkerTag {
	@Resource
	private EvaluateStoreService evaluateStoreService;
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		Integer storeId=ParamsUtils.getInt(params.get("storeId"));
		EvaluateStore evaluateStore=new EvaluateStore();
		if(storeId!=0){
			evaluateStore=evaluateStoreService.findEvaluateStore(storeId);
			//保留一位小数
			NumberFormat numberFormat= NumberFormat.getNumberInstance() ; 
			numberFormat.setMaximumFractionDigits(1);
			if(evaluateStore!=null){
				//发货速度评分
				if(evaluateStore.getSevalDeliverycredit()!=null){
					evaluateStore.setSevalDeliverycredit(Double.valueOf(numberFormat.format(evaluateStore.getSevalDeliverycredit())));
				}
				//描述相符评分
				if(evaluateStore.getSevalDesccredit()!=null){
					evaluateStore.setSevalDesccredit(Double.valueOf(numberFormat.format(evaluateStore.getSevalDesccredit())));
				}
				//服务态度评分
				if(evaluateStore.getSevalServicecredit()!=null){
					evaluateStore.setSevalServicecredit(Double.valueOf(numberFormat.format(evaluateStore.getSevalServicecredit())));
				}
			}
			 if(!evaluateStore.getCount().equals("0")){
			    evaluateStore.setAverageCredit(Util.getAverageCreditFormat(evaluateStore));
			 }
		}
		return evaluateStore;
	}
}
