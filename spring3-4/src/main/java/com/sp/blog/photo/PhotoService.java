package com.sp.blog.photo;

import java.util.List;
import java.util.Map;

public interface PhotoService {
	public int insertPhoto(Photo dto, String pathname);
	public int dataCount(Map<String, Object> map);
	public List<Photo> listPhoto(Map<String, Object> map);
	public Photo readPhoto(Map<String, Object> map);
	public Photo preReadPhoto(Map<String, Object> map);
	public Photo nextReadPhoto(Map<String, Object> map);
	public int updatePhoto(Photo dto, String pathname);
	public int deletePhoto(Map<String, Object> map, String imageFilename, String pathname);
}
