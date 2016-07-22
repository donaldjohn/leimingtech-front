//package com.leimingtech.front.utils.sessionKey;
//
//import javax.servlet.http.HttpSession;
//
//import org.apache.shiro.SecurityUtils;
//import org.apache.shiro.subject.Subject;
//import org.springframework.web.context.request.RequestContextHolder;
//import org.springframework.web.context.request.ServletRequestAttributes;
//
//import com.leimingtech.core.common.Constants;
//import com.leimingtech.core.common.SpringContextUtil;
//import com.leimingtech.core.entity.base.Member;
//import com.leimingtech.core.entity.base.Store;
//import com.leimingtech.service.module.member.service.MemberService;
//import com.leimingtech.service.module.store.service.StoreService;
//
///**
// * @author llf
// * @Package com.leimingtech.front.utils.sessionKey
// * @Description:
// * @date 2015/3/13 15:53
// */
//public class CacheUtils {
//
//    /**
//     * 获取SessionUser
//     *
//     * @return
//     */
//    public static CacheUser getCacheUser() {
//
//        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
//        if (null != session) {
//            //仅用于测试
//            CacheUser cacheUser;//= initCacheUser("front")
//            Subject currentUser = SecurityUtils.getSubject();
//            cacheUser = (CacheUser) session.getAttribute(Constants.USER_SESSION_KEY);
//            if (cacheUser == null) {
//                cacheUser = CacheUtils.initCacheUser(currentUser.getPrincipal().toString());
//            }
//            return cacheUser;
//        } else {
//
//            return null;
//        }
//    }
//
//    /**
//     * 初始化CacheUser对象
//     *
//     * @param memberName
//     * @return
//     */
//    public static CacheUser initCacheUser(String memberName) {
//
//        MemberService memberService = SpringContextUtil.getBean(MemberService.class);
//        StoreService storeService = SpringContextUtil.getBean(StoreService.class);
//        Member member = memberService.findMemberByName(memberName);
//        Store store = storeService.findByMemberId(member.getMemberId());
//        CacheUser cacheUser = new CacheUser();
//        cacheUser.setMember(member);
//        cacheUser.setStore(store);
//        
//        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
//        if (null != session) {
//            session.setAttribute(Constants.USER_SESSION_KEY, cacheUser);	
//        } else {
//            throw new RuntimeException("CacheUser初始化失败");
//        }
//        return cacheUser;
//    }
//    
//    /**
//     * 判断用户是否登录
//     * @return
//     */
//    public static boolean isLogin(){
//    	Subject currentUser = SecurityUtils.getSubject();
//    	return currentUser.isAuthenticated();
//    }
//}
