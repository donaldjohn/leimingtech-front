/**
 * 
 */
package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.website.service.ArticleClassService;

import freemarker.template.TemplateModelException;

/**
 * <p>Title: ArticleClassTitleTag.java</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2014-2019</p>
 * <p>Company: leimingtech</p>
 * @author linjm
 * @date 2015年6月30日
 * @version 1.0
 */
@Component
public class ArticleClassTitleTag  extends BaseFreeMarkerTag{

	@Resource
	private ArticleClassService articleClassService;
	
	/*(non-Javadoc)
	 * @see com.leimingtech.core.freemarker.BaseFreeMarkerTag#exec(java.util.Map)
	 */
	@SuppressWarnings("rawtypes")
	protected Object exec(Map params) throws TemplateModelException {
//		Object level = params.get("level");//分类级别  
//		Object acId =params.get("acId");//分类id
		return articleClassService.findTitleList();
	}

}
