package com.leimingtech.front.module.tag;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.store.service.EvaluateStoreService;

import freemarker.template.TemplateModelException;

/**
 * 平均分信息
 * @author gyh
 * 2015-11-02下午15:20:00
 */
@Component
public class EvaluateTag extends BaseFreeMarkerTag {

	
	@Resource
    private EvaluateStoreService evaluateStoreService;
	
	/**
	 * 获取店铺的信息
	 * @param storeId 店铺id
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
		//获取店铺id
		Integer sevalStoreId = ParamsUtils.getInt(params.get("storeId"));
		//获取当前时间
		Long nowtime=System.currentTimeMillis();
		//获取半年前时间戳
		//Long halfyearTime=DateUtils.strToLong((DateUtils.getMonth(DateUtils.formatLongToStr(System.currentTimeMillis(),"") ,"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd HH:mm:ss",6)));
		Map<Object,Object> evaluatemap=new HashMap<Object, Object>();
		evaluatemap.put("sevalStoreId",sevalStoreId);
		evaluatemap.put("nowtime", nowtime);
		//evaluatemap.put("halfyearTime",halfyearTime);
		Map<String,Integer> evamap=evaluateStoreService.findEvaluate(evaluatemap);
		return evamap;
	}

}
