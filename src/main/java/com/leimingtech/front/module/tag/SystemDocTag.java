package com.leimingtech.front.module.tag;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.common.ParamsUtils;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.website.service.DocumentService;

import freemarker.template.TemplateModelException;
import com.leimingtech.core.entity.base.Document;

/**
 * 系统文章
 * @author linjm
 * @date 2015-12-08
 */
@Component
public class SystemDocTag extends BaseFreeMarkerTag{

  @Resource
  private DocumentService documentService;
	
	@Override
	protected Object exec(Map params) throws TemplateModelException {
		int id = ParamsUtils.getInt(params.get("docId"));
		Document doc = documentService.findById(id);
		return doc;
	}

}
