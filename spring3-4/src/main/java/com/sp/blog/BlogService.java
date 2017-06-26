package com.sp.blog;

import java.util.List;
import java.util.Map;

public interface BlogService {
	public long maxBlogSeq();
	public int insertBlog(BlogInfo dto, String pathname);
	
	public List<BlogTheme> listBlogThemeGroup();
	public List<BlogTheme> listBlogTheme(int groupNum);
	public List<BlogTheme> listBlogThemeAll();
	
	public int updateBlog(BlogInfo dto, String pathname);
	public int deleteImage(long blogSeq, String pathname, String filename);
	
	public int deleteBlog(long blogSeq, String pathname);
	
	public int dataCountBlog(Map<String, Object> map);
	public List<BlogInfo> listBlog(Map<String, Object> map);

	public BlogInfo readBlogInfo(Map<String, Object> map);
	public BlogInfo readBlogInfoHome(long blogSeq);
	public BlogInfo readBlogInfoProfile(long blogSeq);
	
	public int updateBlogVisitorCount(long blogSeq);

	public int createBlogTable(long blogSeq);
	public int dropBlogTable(long blogSeq);
}
