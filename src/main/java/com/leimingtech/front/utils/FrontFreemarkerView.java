//package com.leimingtech.front.utils;
// /**特殊需求已经注释了**//
//import java.io.File;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import com.leimingtech.core.freemarker.ExtFreeMarkerView;
//import com.leimingtech.extend.module.payment.alipay.pc.internation.config.AlipayInternaContents;
//import com.leimingtech.extend.module.payment.module.alipay.pc.internation.RateFileload;
//
//public class FrontFreemarkerView extends ExtFreeMarkerView {
//	private static final String RATE_PATH = "rate";
//    @Override
//    protected void exposeHelpers(Map<String, Object> model,
//                                 HttpServletRequest request) throws Exception {
//    	RateFileload rdf=new RateFileload();
//    	if("".equals(RateFileload.ratevalue)||RateFileload.ratevalue==null){
//    		File file=new File(AlipayInternaContents.aplipayratefiledir+AlipayInternaContents.aplipayratefilename+".txt"); 
//    		if(file.exists()){
//    			rdf.readrate();//读取汇率
//    		}
//    	}
//        model.put(RATE_PATH, RateFileload.ratevalue);
//        super.exposeHelpers(model, request);
//    }
//}
