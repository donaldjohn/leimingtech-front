package com.leimingtech.front.module.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class CartInterceptor {
	
	/**
	 * 切入的方法
	 * 第一个星标示 标示返回任意类型
	 * 括号中的点标示任意参数
	 */
//	@Pointcut("execution (* com.leimingtech.service.module.cart.service.CartService.queryBuyCart(..))")//该类的指定方法
	@Pointcut("execution (* com.leimingtech.service.module.cart.service.CartService.*(..))")	//该类的任意方法
	public void cartMethod(){
		System.out.println("切入点＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝");
	}
	
	/**前置通知**/
	@Before("cartMethod()")
	public void beforeAdvice(){
		System.out.println("前置通知====cartMethod()======");
	}
	
	
	/**后置通知**/
	@AfterReturning(pointcut = "cartMethod()", returning = "flag")
	public void afterAdvice(String flag){
		System.out.println("后置通知====AfterReturning======"+ flag);
	}
	
	/**最终通知**/
	@After("cartMethod()")
	public void finallyAdvice(){
		System.out.println("最终通知====@After======");
	}

	/**环绕通知**/
	@Around("cartMethod() && args(name)")
	public Object AroundAdvice(ProceedingJoinPoint pjp ,String name) throws Throwable{
		System.out.println("环绕通知=====@Around");
		Object obj = null;
//		if(name.equals("guc")){
		obj = pjp.proceed();//调用目标对象的方法
//		}else{
//			System.out.println("=====方法已经被拦截");
//		}
		return obj;
	}
	
	/**例外通知**/
	@AfterThrowing(pointcut = "cartMethod()" ,throwing = "e" )
	public void AfterThrowing(Exception e){
		System.out.println("错误信息:");
		System.out.println(e.getMessage());
	}
}
