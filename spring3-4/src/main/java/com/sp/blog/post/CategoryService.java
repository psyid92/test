package com.sp.blog.post;

import java.util.List;
import java.util.Map;

public interface CategoryService {
	public int maxCategoryNum(Map<String, Object> map);
	public int insertCategory(Category dto);
	public List<Category> listCategoryGroup(Map<String, Object> map);
	public List<Category> listCategory(Map<String, Object> map);
	public List<Category> listCategoryAll(Map<String, Object> map);
	public Category readCategory(Map<String, Object> map);
	public int updateCategory(Category dto);
	public int deleteCategory(Map<String, Object> map);
}
