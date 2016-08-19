package com.leimingtech.front.module.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.util.Strings;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Maps;
import com.leimingtech.core.common.CommonConstants;
import com.leimingtech.core.common.Constants;
import com.leimingtech.core.entity.GoodsClass;
import com.leimingtech.core.entity.GoodsSpec;
import com.leimingtech.core.entity.ImageSet;
import com.leimingtech.core.entity.base.Consult;
import com.leimingtech.core.entity.base.Goods;
import com.leimingtech.core.entity.base.MemberGrade;
import com.leimingtech.core.entity.vo.ArticleClassTitleVo;
import com.leimingtech.core.entity.vo.OrderGoodsVo;
import com.leimingtech.service.module.goods.service.GoodsClassService;
import com.leimingtech.service.module.goods.service.GoodsService;
import com.leimingtech.service.module.goods.service.GoodsSpecService;
import com.leimingtech.service.module.member.service.MemberGradeService;
import com.leimingtech.service.module.setting.service.SettingService;
import com.leimingtech.service.module.trade.service.ConsultService;
import com.leimingtech.service.module.trade.service.OrderGoodsService;
import com.leimingtech.service.module.website.service.ArticleClassService;
import com.leimingtech.service.utils.goods.GoodsUtils;
import com.leimingtech.service.utils.page.Pager;
import com.leimingtech.service.utils.sessionkey.front.CacheUtils;

/**
 * 商品action
 * @author cgl
 * 2015年08月13日11:17:49
 */
@Controller
@RequestMapping("/product")
@Slf4j
public class ProductAction {

//    @Resource
//    private GoodsCommonService goodsCommonService;

    @Resource
    private GoodsClassService goodsClassService;

    @Resource
    private ArticleClassService articleClassService;

    @Resource
    private ConsultService consultService;
    
    @Resource
    private GoodsSpecService goodsSpecService;

    @Resource
    private OrderGoodsService orderGoodsService;
    
    @Resource
    private SettingService settingService;
    
    @Resource
    private MemberGradeService memberGradeService;
    
    @Resource
    private GoodsService goodsService;
    
    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam(value = "id") Integer goodsId,
    					@RequestParam(required = false, value = "tab", defaultValue = "0") Integer tab) {
        try {
        	Goods goods = goodsService.findGoodById(goodsId);
        	if(null==goods){
        		new RuntimeException("商品不存在!");
        	}
        	//获取会员信息
        	if(CacheUtils.isLogin()){
        		Integer memberGradeId = CacheUtils.getCacheUser().getMember().getMemberGradeId();
        		if(memberGradeId != null){
        			MemberGrade memberGrade = memberGradeService.findMembeGraderById(memberGradeId);
        			model.addAttribute("preferential", memberGrade.getPreferential());
        		}
        	}else{
        		model.addAttribute("preferential", "");
        	}
        	//获取咨询设置开关状态
    		Map<String,String> consultMap = settingService.findByNameResultMap("consult");
    		String isShow = consultMap.get("consult_isShow");
    		model.addAttribute("isShow", isShow);
            model.addAttribute("goodsId", goodsId);
    		//图片目录
    		String imgSrc = Constants.SPECIMAGE_PATH;
    		model.addAttribute("imgSrc", imgSrc);
    		//获取admin图片设置的尺寸大小
    		Map<String,String> map = settingService.findByNameResultMap("images");
    		ImageSet imageSet = new ImageSet();
    		imageSet.setBig_pic_height(Integer.valueOf(map.get("big_pic_height")));
    		imageSet.setBig_pic_width(Integer.valueOf(map.get("big_pic_width")));
    		imageSet.setSmall_pic_height(Integer.valueOf(map.get("small_pic_height")));
    		imageSet.setSmall_pic_width(Integer.valueOf(map.get("small_pic_width")));
    		imageSet.setThumbnail_pic_height(Integer.valueOf(map.get("thumbnail_pic_height")));
    		imageSet.setThumbnail_pic_width(Integer.valueOf(map.get("thumbnail_pic_width")));
    		imageSet.setTiny_pic_height(Integer.valueOf(map.get("tiny_pic_height")));
    		imageSet.setTiny_pic_width(Integer.valueOf(map.get("tiny_pic_width")));
    		model.addAttribute("imageSet", imageSet);
    		model.addAttribute("tab", tab);
            return "/product/product-detail";
        } catch (Exception e) {
            e.printStackTrace();
            log.error("商品详情页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }
    
    /**
     * 商品body
     */
    @RequestMapping("/goodsBody")
    public ModelAndView goodsBody(Integer goodsId){
    	ModelAndView model = new ModelAndView("/product/goods-body");
    	model.addObject("commom_image", CommonConstants.COMMON_IMAGE);
        model.addObject("goodsId", goodsId);
        
    	return model;
    }
    
    /**
     * @param @param  goodsId
     * @param @param  pageNo
     * @param @return 设定文件
     * @return ModelAndView 返回类型
     * @throws
     * @Title: evaluateGoods
     * @Description: 商品评价，需要翻页，所以单独提出来
     */
    @RequestMapping("/evaluateGoods")
    public ModelAndView evaluateGoods(
            @RequestParam(value = "goodsId") String goodsId,
            @RequestParam(required = false, value = "pageNo", defaultValue = "1") String pageNo) {
    	ModelAndView model = new ModelAndView("/product/evaluate-goods-list");
        try {
//            // 商品评价总数
//            int evaluateGoodsCount = evaluateGoodsService .findCount(pager);
//            evaluateGoodsVo.setPingJiaNum(evaluateGoodsCount);
//
//            // 商品好评数量
//            evaluateGoods.setGevalScore(5);
//            pager.setCondition(evaluateGoods);
//            int evaluateGoodsHaoPingCount = evaluateGoodsService.findCount(pager);
//            evaluateGoodsVo.setHaoPingNum(evaluateGoodsHaoPingCount);
//            // 商品中评数量
//            evaluateGoods.setGevalScore(3);
//            pager.setCondition(evaluateGoods);
//            int evaluateGoodsZhongPingCount = evaluateGoodsService.findCount(pager);
//            evaluateGoodsVo.setZhongPingNum(evaluateGoodsZhongPingCount);
//            // 商品差评数量
//            evaluateGoods.setGevalScore(1);
//            pager.setCondition(evaluateGoods);
//            int evaluateGoodsChaPingCount = evaluateGoodsService.findCount(pager);
//            evaluateGoodsVo.setChaPingNum(evaluateGoodsChaPingCount);

            model.addObject("goodsId", goodsId);
            model.addObject("pageNo", pageNo);//当前页
            model.addObject("toUrl", "/product/evaluateGoods");// 跳转URL
            return model;
        } catch (Exception e) {
            log.error("商品评价页加载失败！",e);
            throw new RuntimeException("导航失败!");
        }
    }
    
    
    /**
     * 销售记录
     */
    @RequestMapping("/saleRecord")
    public ModelAndView saleRecord(
            @RequestParam(value = "goodsId") String goodsId,
            @RequestParam(required = false, value = "pageNo", defaultValue = "1") String pageNo){
    	ModelAndView model = new ModelAndView("/product/order-record-list");
    	try {
            // 翻页对象
            Pager pager = new Pager();
           // pager.setPageSize(10);
            if (StringUtils.isNotBlank(pageNo)) {
                pager.setPageNo(Integer.parseInt(pageNo));
            }
//            OrderRecordVo orderRecordVo = new OrderRecordVo();
//            orderRecordVo.setGoodsId(Integer.parseInt(goodsId));
//            pager.setCondition(orderRecordVo);
//            int count = orderRecordService.countOrderRecord(pager);
//            pager.setTotalRows(count);
            List<OrderGoodsVo> orderRecordList = orderGoodsService.findOrderGoodsVoByGoodsId(Integer.parseInt(goodsId));
            model.addObject("orderRecordList", orderRecordList);
            model.addObject("goodsId", goodsId);
//            model.addObject("pager", pager);
//            model.addObject("pageNo", pager.getPageNo());// 当前页
//            model.addObject("pageSize", pager.getPageSize());
//            model.addObject("recordCount", count);// 总数
//            model.addObject("toUrl", "/product/saleRecord");
    	}
    	catch (Exception e) {
            log.error("商品评价页加载失败！",e);
            throw new RuntimeException("导航失败!");
        }
    	return model;
    }
    
    /**
     * @Description: 产品咨询
     */
    @RequestMapping("/consult")
    public ModelAndView consult(
    		 @RequestParam(required = true, value = "goodsId") String goodsId,
            @RequestParam(required = false, value = "pageNo", defaultValue = "1") String pageNo
            ) {
        ModelAndView model = new ModelAndView("/product/consult-list");
        model.addObject("goodsId", Integer.parseInt(goodsId));
        try {
            // 翻页对象
            Pager pager = new Pager();
            pager.setPageSize(6);
            if (StringUtils.isNotBlank(pageNo)) {
                pager.setPageNo(Integer.parseInt(pageNo));
            }

            // 客服咨询
            Consult consult = new Consult();
            consult.setGoodsId(Integer.parseInt(goodsId));
            pager.setCondition(consult);// 实体加载在pager中

            List<Consult> consultList = consultService.findList(pager);

            pager.setResult(consultList);

            model.addObject("pager", pager);
            model.addObject("consultList", consultList);

            model.addObject("datas", consultList);// 结果集
            model.addObject("pageNo", pager.getPageNo());// 当前页
            model.addObject("pageSize", 6);
            model.addObject("recordCount", pager.getTotalRows());// 总数
            model.addObject("toUrl", "/product/consult");// 跳转URL

            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("商品评价页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 产品咨询提交
     * @param model
     * @return
     */
    @RequestMapping("/saveConsult")
    public
    @ResponseBody
    Map<String, Object> saveConsult(@ModelAttribute Consult consult) {

        Map<String, Object> map = Maps.newHashMap();
        try {
            if (!SecurityUtils.getSubject().isRemembered() && !SecurityUtils.getSubject().isAuthenticated()) {
                consult.setMemberId(0);
                consult.setCmemberName("匿名");
                consult.setIsanonymous(true);
            } else {
                consult.setCmemberName(CacheUtils.getCacheUser().getMember().getMemberName());
                consult.setMemberId(CacheUtils.getCacheUser().getMember().getMemberId());
                consult.setIsanonymous(false);
            }
            consultService.save(consult);
            map.put("success", true);
            map.put("msg", "咨询成功，请等待回复");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("客户咨询保存失败", e.toString());
            map.put("success", false);
            map.put("msg", "咨询失败");
        }

        return map;
    }

    
    @RequestMapping("/detailBySpec")
    public String detailBySpec(Model model,
                               @RequestParam(value = "goodsCommonId") Integer goodsCommonId,
                               @RequestParam(value = "spec") String spec) {
        try {
//            Goods goods = goodsService.findBySpec(goodsCommonId, spec);

            return "redirect:/product/detail?id="; //+ goods.getGoodsId();
        } catch (Exception e) {
            log.error("detailBySpec error！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * @param @param  goodsId
     * @param @param  pageNo
     * @param @return 设定文件
     * @return ModelAndView 返回类型
     * @throws
     * @Title: consult
     * @Description: 客服咨询，需要翻页，所以单独提出来
     */
    @RequestMapping("/queryTransport")
    public
    @ResponseBody
    Map<String, String> queryTransport(
            @RequestParam(value = "transportId") String transportId,
            @RequestParam(value = "areaId") String areaId) {

        Map<String, String> map = new HashMap<String, String>();

        try {
            // 运费
//            TransportExtend transportExtend = transportExtendService.query(
//                    Integer.parseInt(transportId), Integer.parseInt(areaId));

            String json = "null";
//            if (transportExtend != null) {
//                json = JsonUtils.toJsonStr(transportExtend);
//            }

            map.put("result", json);

            return map;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("商品评价页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 导航主页面跳转
     *
     * @param @param  apm 加载的
     * @param @return 设定文件
     * @return ModelAndView 返回类型
     * @throws RuntimeException
     * @Title: index
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/index")
    public ModelAndView index(@RequestParam(value = "gcId") String gcId) {
        try {
            ModelAndView model = new ModelAndView("/product/product");
            // 头部菜单
//            Map<GoodsClassVo, List<GoodsClassVo>> map = goodsClassService
//                    .queryGoodsClassList();

            // 尾部菜单
            List<ArticleClassTitleVo> listArticleClassTitleVo = articleClassService
                    .findTitleList();

//            model.addObject("map", map);
            model.addObject("listArticleClassTitleVo", listArticleClassTitleVo);
            model.addObject("gcId", gcId);
            model.addObject("apm", "index");
            return model;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 导航主页面跳转
     *
     * @param @param  apm 加载的
     * @param @return 设定文件
     * @return ModelAndView 返回类型
     * @throws RuntimeException
     * @Title: list
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    @RequestMapping("/list")
    public String list(
            @RequestParam(required = false, value = "gcId", defaultValue = "") String gcId,
            @RequestParam(required = false, value = "pageNo", defaultValue = "") String pageNoStr,
            @RequestParam(required = false, value = "div", defaultValue = "") String div,
            @RequestParam(required = false, value = "orderby", defaultValue = "mr") String orderby,
            Model model) {
        try {
            Pager pager = new Pager();
            if (Strings.isNotEmpty(pageNoStr)) {
                pager.setPageNo(Integer.valueOf(pageNoStr));
            }
//            GoodsCommon gc = new GoodsCommon();
            List<Integer> listLong = new ArrayList<Integer>();
            List<GoodsClass> listdata = new ArrayList<GoodsClass>();
            List<GoodsClass> list = goodsClassService.findList(Integer.valueOf(gcId));
            
            for(GoodsClass goodsClass : list){
            	List<GoodsClass> list1 = goodsClassService.findList(goodsClass.getGcId());
            	for(GoodsClass goodsClass2 :list1){
            		listdata.add(goodsClass2);
            	}
            	listdata.add(goodsClass);
            }
            
            if (listdata != null && listdata.size() > 0) {
                for (int i = 0; i < listdata.size(); i++) {
                    listLong.add(listdata.get(i).getGcId());
                }
            } else {
                listLong.add(Integer.valueOf(gcId));
            }
//            gc.setGcIdsByfind(listLong);

//            if (orderby.equals("mr")) {
//                gc.setGoodsCommonid(1);
//            } else if (orderby.equals("jg")) {
//                gc.setGoodsPrice(new BigDecimal(Double.toString(1)));
//            } else if (orderby.equals("sjsj")) {
//                gc.setGoodsSelltime(new Date());
//            }

//            pager.setCondition(gc);// 实体加载在pager中
//            int total = goodsCommonService.countByGcId(pager);
            ;// 获取总条数

//            List<GoodsCommon> goodsCommonList = goodsCommonService.findByGcId(pager);
            Goods goods = new Goods();
            goods.setGcId(Integer.valueOf(gcId));
//            List<Goods> commendGoodsList = goodsService.queryCommendGoods(goods);

            model.addAttribute("pager", pager);
//            model.addAttribute("goodsCommonList", goodsCommonList);// 结果集合
            model.addAttribute("pageNo", pager.getPageNo());// 当前页
            model.addAttribute("pageSize", pager.getPageSize());// 每页显示条数
//            model.addAttribute("recordCount", total);// 总数
            model.addAttribute("div", "dataListDiv");// 显示的DIV数据区域
            model.addAttribute("gcId", gcId);
            model.addAttribute("orderby", orderby);
            model.addAttribute("toUrl", "/product/list");//总数
//            model.addAttribute("commendGoodsList", commendGoodsList);//总数
            return "/product/product-list";
        } catch (Exception e) {
            e.printStackTrace();
            log.error("卖家中心首页加载失败！");
            throw new RuntimeException("导航失败!");
        }
    }

    /**
     * 通过商品id获得商品的规格以及sku信息
     */
    @ResponseBody
    @RequestMapping("/goodsSpecs")
    public Map<String, Object> goodsSpecs(Integer goodsId){
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	List<GoodsSpec> goodsSpecs = goodsSpecService.findListByGoodsId(goodsId);
    	
    	//得到该商品的所有goodsvalueId的String,以逗号分割
        for(int i = 0; i < goodsSpecs.size(); i++){
        	goodsSpecs.get(i).setSpecValueIdStr(
        			GoodsUtils.getThisGoodsAllSpecValueId(
        					goodsSpecs.get(i).getSpecGoodsSpec()
        			)
        	);
        }
    	
    	map.put("goodsSpecs", goodsSpecs);
    	
    	return map;
    }
}
