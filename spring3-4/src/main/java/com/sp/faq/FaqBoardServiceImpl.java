package com.sp.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("category.faqBoardService")
public class FaqBoardServiceImpl implements FaqBoardService {
	@Autowired
	private CommonDAO  dao;

	@Override
	public int insertFaq(FaqBoard faq) {
		int result=0;
		
		try {
			result=dao.insertData("faq.insertFaq", faq);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("faq.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<FaqBoard> listFaq(Map<String, Object> map) {
		List<FaqBoard> list=null;
		
		try {
			list=dao.getListData("faq.listFaq", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<FaqBoard> listFaqCategory() {
		List<FaqBoard> list=null;
		
		try{
			list=dao.getListData("faq.listFaqCategory");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	@Override
	public FaqBoard readFaq(int num) {
		FaqBoard faq=null;
		
		try{
			// 게시물 가져오기
			faq=dao.getReadData("faq.readFaq", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return faq;
	}
	
	@Override
	public int updateFaq(FaqBoard faq) {
		int result=0;

		try{
			result=dao.updateData("faq.updateFaq", faq);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteFaq(int num) {
		int result=0;

		try{
			result=dao.deleteData("faq.deleteFaq", num);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertCategory(FaqBoard dto) {
		int result=0;
		try{
			result=dao.insertData("faq.insertCategory", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<FaqBoard> listCategory() {
		List<FaqBoard> list=null;
		
		try{
			list=dao.getListData("faq.listCategory");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int dataCountCategory() {
		int result=0;
		
		try{
			result=dao.getIntValue("faq.dataCountCategory");			
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteCategory(int categoryNum) {
		int result=0;

		try{
			dao.deleteData("faq.deleteCategory", categoryNum);
			result=1;
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
