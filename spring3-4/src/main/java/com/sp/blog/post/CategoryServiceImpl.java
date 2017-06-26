package com.sp.blog.post;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("post.categoryService")
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int maxCategoryNum(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("boardCategory.maxCategoryNum", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertCategory(Category dto) {
		int result=0;
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("tableName", dto.getTableName());
			
			int num=maxCategoryNum(map)+1;
			dto.setCategoryNum(num);
			dao.insertData("boardCategory.insertCategory", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Category> listCategoryGroup(Map<String, Object> map) {
		List<Category> list=null;
		try {
			list=dao.getListData("boardCategory.listCategoryGroup", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Category> listCategory(Map<String, Object> map) {
		List<Category> list=null;
		try {
			list=dao.getListData("boardCategory.listCategory", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Category> listCategoryAll(Map<String, Object> map) {
		List<Category> list=null;
		try {
			list=dao.getListData("boardCategory.listCategoryAll", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public Category readCategory(Map<String, Object> map) {
		Category dto=null;
		try {
			dto=dao.getReadData("boardCategory.readCategory", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	@Override
	public int updateCategory(Category dto) {
		int result=0;
		try {
			result=dao.deleteData("boardCategory.updateCategory", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public int deleteCategory(Map<String, Object> map) {
		int result=0;
		try {
			// 게시판의 업로드된 파일을 삭제 해야함
			
			result=dao.deleteData("boardCategory.deleteCategory", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}
