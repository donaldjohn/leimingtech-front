/**
 * 
 */
package com.leimingtech.front.module.category;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.leimingtech.core.common.DateUtils;
import com.leimingtech.core.entity.base.Coupon;
import com.leimingtech.service.module.coupon.service.CouponService;

/**
 * <p>Title: CategoryAction.java</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2014-2018</p>
 * <p>Company: leimingtech.com</p>
 * @author linjm
 * @date 2015年7月16日
 * @version 1.0
 */

@Controller
@RequestMapping("/all")
public class CategoryAction {
	
	@Resource
	private CouponService couponService;
	
	@RequestMapping("/class")
	public String category(Model model){
		
		return "/category/all_class";
	}
	
	@RequestMapping("/brand")
	public String brand(Model model){
		
		return "/category/all_brand";
	}
	
	@RequestMapping("/coupon")
	public String coupon(Model model){
		Coupon coupon = new Coupon();
		coupon.setCouponState(0);  //选择已上架的  couponState:1下架，0上架
		coupon.setCouponAllowState(1);  //审核状态 0为待审核 1已通过 2未通过
		/**时间格式*/
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		/**当前时间*/
		String dateStr = format.format(new Date());
		coupon.setEndTime(DateUtils.strToLong(dateStr));  //选择过期时间在今天之前的
		List<Coupon> couponList = couponService.findCoupons(coupon);
		model.addAttribute("couponList", couponList);
		return "/category/all_coupon";
	}

}
