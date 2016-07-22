package com.leimingtech.front.module.user.controller;

import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.leimingtech.core.entity.PayCommon;
import com.leimingtech.core.entity.base.Member;
import com.leimingtech.core.entity.base.Pay;
import com.leimingtech.core.entity.base.PredepositRecharge;
import com.leimingtech.extend.module.payment.module.alipay.pc.china.pay.service.AlipayService;
import com.leimingtech.extend.module.payment.module.alipay.pc.internation.service.AlipayInternaService;
import com.leimingtech.extend.module.payment.module.unionopay.pc.pay.service.UnionpayService;
import com.leimingtech.extend.module.payment.module.whchat.h5.pay.scan.WechatScanService.WechatScanService;
import com.leimingtech.service.module.member.service.MemberService;
import com.leimingtech.service.module.trade.service.PayService;
import com.leimingtech.service.module.trade.service.PredepositService;
import com.leimingtech.service.utils.sessionkey.front.CacheUtils;

/**
 * 我的余额
 * @author liukai
 */
@Controller
@RequestMapping("/predeposit")
@Slf4j
public class MyPredepositAction {
	
	@Resource
	private PredepositService predepositService;
	
	@Resource
    private MemberService memberService;
	
	@Resource 
	private UnionpayService unionpayService;
    
    @Resource 
   	private AlipayService alipayService;
    
    @Resource
    private PayService payService;
    @Resource
	private WechatScanService wechatScanService;
    @Resource
   	private AlipayInternaService alipayinternaservice;
	
	/**
	 * 余额信息页面
	 * @return
	 */
	@RequestMapping("/predepositIndex")
	public ModelAndView predepositIndex(){
		try {
			ModelAndView model = new ModelAndView("/user/predeposit/predeposit-index");
			Member member =  memberService.findMemberById(CacheUtils.getCacheUser().getMember().getMemberId());
			model.addObject("member",member);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			log.error("余额充值页加载失败！");
			throw new RuntimeException("加载失败!");
		}
	}
	
	/**
	 * 余额信息页面
	 * @return
	 */
	@RequestMapping("/rechargeIndex")
	public ModelAndView rechargeIndex(){
		try {
			ModelAndView model = new ModelAndView("/user/predeposit/recharge-index");
			Member member =  memberService.findMemberById(CacheUtils.getCacheUser().getMember().getMemberId());
			model.addObject("member",member);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			log.error("余额充值页加载失败！");
			throw new RuntimeException("加载失败!");
		}
	}
	
	/**
	 * 余额信息页面
	 * @return
	 */
	@RequestMapping("/recharge")
	public ModelAndView recharge(
							@RequestParam(value="amount") Double amount
							){
		try {
			ModelAndView model = new ModelAndView("/user/predeposit/recharge");
			Member member =  memberService.findMemberById(CacheUtils.getCacheUser().getMember().getMemberId());
			PredepositRecharge predepositRecharge =  predepositService.addRechargePredeposit(member.getMemberId(), BigDecimal.valueOf(amount));
			model.addObject("predepositRecharge", predepositRecharge);
			return model;
		} catch (Exception e) {
			e.printStackTrace();
			log.error("余额充值页加载失败！");
			throw new RuntimeException("加载失败!");
		}
	}
	
	 /**
     * 去付款
     * @param @return 设定文件
     * @return ModelAndView    返回类型
     * @throws
     * @Title: gotopay
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/gotopay")
    public ModelAndView orderpay(@RequestParam(value = "pdrSn") String pdrSn,
    					@RequestParam("paymentCode") String paymentCode,
    					@RequestParam("paymentId") Integer paymentId,
    					HttpServletRequest request ,HttpServletResponse response) {
        try {
        	Pay pay = payService.findPayBySn(pdrSn);
			PayCommon payCommon = new PayCommon();
			payCommon.setOutTradeNo(pay.getPaySn());
			payCommon.setPayAmount(pay.getPayAmount());
        	String sHtmlText = "";
 			if(StringUtils.isNotEmpty(pdrSn)&&paymentCode.equals("ZFB")){
 				//修改预付款充值表信息
 				payCommon.setNotifyUrl("/payment/payback");
 				payCommon.setReturnUrl("/payment/payfront");
 				predepositService.updateRechargePredeposit(pdrSn, paymentId);
 				sHtmlText=alipayService.toPay(payCommon);
 			}else if(StringUtils.isNotEmpty(pdrSn)&&paymentCode.equals("YL")){
 				//修改预付款充值表信息
 				payCommon.setNotifyUrl("/Unionpayment/Unionpayback");
 				payCommon.setReturnUrl("/Unionpayment/Unionpayfront");
 				predepositService.updateRechargePredeposit(pdrSn, paymentId);
 				sHtmlText = unionpayService.toUnionpay(payCommon);//构造提交银联的表单
 			}else if(StringUtils.isNotEmpty(pdrSn)&&paymentCode.equals("GJZFB")){
 				//修改订单付款信息
 				payCommon.setNotifyUrl("/payinternament/payback");
 				payCommon.setReturnUrl("/payinternament/payfront");
 				predepositService.updateRechargePredeposit(pdrSn, paymentId);
 				sHtmlText = alipayinternaservice.toPay(pdrSn);//构造提交国际支付宝的表单
 			}else if(StringUtils.isNotEmpty(pdrSn)&&paymentCode.equals("weiscan")){
				//修改订单付款信息
				payCommon.setNotifyUrl("/weChatScanpayment/updateorderstate");
				predepositService.updateRechargePredeposit(pdrSn,paymentId);
				String tocodeurl=wechatScanService.toPay(payCommon);//微信扫码url
				ModelAndView model=new ModelAndView();
				model.addObject("paysn",pdrSn);//订单号
				model.addObject("tocodeurl", tocodeurl);
				model.setViewName("/weiscan/native_weichatscan");
				return model;
			}
 			
 			response.setCharacterEncoding("UTF-8");
 			response.getWriter().write(sHtmlText);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("提交付款页加载失败！");
            throw new RuntimeException("导航失败!");
        }
        return null;
    }
}
