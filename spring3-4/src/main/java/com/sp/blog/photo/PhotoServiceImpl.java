package com.sp.blog.photo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("blog.photo.photoServiceImpl")
public class PhotoServiceImpl implements PhotoService {
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public int insertPhoto(Photo dto, String pathname) {
		int result=0;
		
		try {
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				// 파일 업로드
				String newFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setImageFilename(newFilename);

				Map<String, Object> map=new HashMap<String, Object>();
				map.put("tableName", dto.getTableName());
				int maxNum=dao.getIntValue("blogPhoto.maxNum", map);
				dto.setNum(maxNum+1);
				
				result=dao.insertData("blogPhoto.insertPhoto", dto);
			}
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.getIntValue("blogPhoto.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Photo> listPhoto(Map<String, Object> map) {
		List<Photo> list=null;
		
		try {
			list=dao.getListData("blogPhoto.listPhoto", map);
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public Photo readPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("blogPhoto.readPhoto", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Photo preReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("blogPhoto.preReadPhoto", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Photo nextReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("blogPhoto.nextReadPhoto", map);
		} catch (Exception e) {
		}
		
		return dto;
	}
	
	@Override
	public int updatePhoto(Photo dto, String pathname) {
		int result=0;
		
		try {
			// 업로드한 파일이 존재한 경우
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
		
				if (newFilename != null) {
					// 이전 파일 지우기
					Map<String, Object> map=new HashMap<String, Object>();
					map.put("tableName", dto.getTableName());
					map.put("num", dto.getNum());
					Photo vo = readPhoto(map);
					if(vo!=null && vo.getImageFilename()!=null) {
						fileManager.doFileDelete(vo.getImageFilename(), pathname);
					}
					
					dto.setImageFilename(newFilename);
				}
			}
			
			result=dao.updateData("blogPhoto.updatePhoto", dto);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deletePhoto(Map<String, Object> map, String imageFilename, String pathname) {
		int result=0;
		
		try {
			if(imageFilename!=null)
				fileManager.doFileDelete(imageFilename, pathname);
			
			// 게시물지우기
			result=dao.deleteData("blogPhoto.deletePhoto", map);
		} catch (Exception e) {
		}
		
		return result;
	}

}
