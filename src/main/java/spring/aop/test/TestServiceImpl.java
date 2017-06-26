package spring.aop.test;

public class TestServiceImpl implements TestService {
	private String message;
	
	public TestServiceImpl() {
		this.message = "AOP 테스트 입니다.";
	}
	
	@Override
	public void save(String value) {
		/*System.out.println(Integer.parseInt(value));*/
		this.message = value;
	}

	@Override
	public void write() {
		System.out.println(message);
	}
}
