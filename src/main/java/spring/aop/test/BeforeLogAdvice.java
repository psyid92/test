package spring.aop.test;

import java.lang.reflect.Method;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.MethodBeforeAdvice;

public class BeforeLogAdvice implements MethodBeforeAdvice {
	/*private final Log log = LogFactory.getLog(getClass());*/
	private final Logger log = LoggerFactory.getLogger(getClass());
	@Override
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String s = method.toString() + " 메소드 : " + target + "에서 호출 전...";
		if (args != null) {
			for (int i = 0; i < args.length; i++) 
				s += ", 인수 : " + args[i];
		}
		log.info(s);
		System.out.println(s);
	}
}
