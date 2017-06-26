package spring.aop.test;

import java.lang.reflect.Method;

import org.springframework.aop.AfterReturningAdvice;

// AfterReturningAdvice : 대상 객체 메소드 실행 후 (예외없이 실행 된 경우)
public class AfterLogAdvice implements AfterReturningAdvice {
	@Override
	public void afterReturning(Object returnValue, Method method, Object[] args, Object target) throws Throwable {
		String s = method.toString() + "메소드" + target + " 에서 호출 후...";
		System.out.println(s);
	}
}
