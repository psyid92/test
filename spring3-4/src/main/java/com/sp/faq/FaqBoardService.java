package com.sp.faq;

import java.util.List;
import java.util.Map;

public interface FaqBoardService {
	public int insertFaq(FaqBoard faq);
	public int dataCount(Map<String, Object> map);
	public List<FaqBoard> listFaq(Map<String, Object> map);
	public List<FaqBoard> listFaqCategory();
	public FaqBoard readFaq(int num);
	public int updateFaq(FaqBoard faq);
	public int deleteFaq(int num);

	public int insertCategory(FaqBoard faq);
	public List<FaqBoard> listCategory();
	public int dataCountCategory();
	public int deleteCategory(int categoryNum);
	
}
