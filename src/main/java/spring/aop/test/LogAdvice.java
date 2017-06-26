package spring.aop.test;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

public class LogAdvice implements MethodInterceptor{
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		// 메소드 전
		
		String s;
		s = invocation.getMethod().getName() + "호출전...";
		System.out.println(s);
		
		Object returnValue = invocation.proceed();
		
		// 메소드 후
		s = invocation.getMethod().getName() + "호출후, 리턴 : " + returnValue;
		System.out.println(s);
		
		return returnValue;
	}
}
