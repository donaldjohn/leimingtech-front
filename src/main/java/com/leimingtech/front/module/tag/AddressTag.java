package com.leimingtech.front.module.tag;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.leimingtech.core.entity.base.Address;
import com.leimingtech.core.freemarker.BaseFreeMarkerTag;
import com.leimingtech.service.module.cart.service.AddressService;
import com.leimingtech.service.utils.sessionkey.front.CacheUtils;

import freemarker.template.TemplateModelException;

/**
 * 收货地址标签
 * @author liukai
 */
@Component
public class AddressTag extends BaseFreeMarkerTag{
	
	@Resource
	private AddressService addressService;

	@SuppressWarnings("rawtypes")
	@Override
	protected Object exec(Map params) throws TemplateModelException {
		//获取买家收货地址
        List<Address> addressList = addressService.queryAddreassMemberId(CacheUtils.getCacheUser().getMember().getMemberId());
		return addressList;
	}
}
