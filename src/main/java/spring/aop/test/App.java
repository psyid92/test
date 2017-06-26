package spring.aop.test;

import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("classpath:spring/aop/test/app.xml");
		
		try {
			TestService service = (TestService) context.getBean("testService");
			service.save("예제...");
			service.write();
		} catch (Exception e) {
		} finally {
			context.close();
		}
	}
}
