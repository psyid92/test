package com.sp.photo;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.bbs.Board;
import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("photo.photoServiceImpl")
public class PhotoServiceImpl implements PhotoService {
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public int insertPhoto(Photo dto, String path) {
		int result=0;
		
		try {
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				// 파일 업로드
				String newFilename=fileManager.doFileUpload(dto.getUpload(), path);
				dto.setImageFilename(newFilename);

				result=dao.insertData("photo.insertPhoto", dto);
			}
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.getIntValue("photo.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Photo> listPhoto(Map<String, Object> map) {
		List<Photo> list=null;
		
		try {
			list=dao.getListData("photo.listPhoto", map);
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public Photo readPhoto(int num) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("photo.readPhoto", num);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Photo preReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("photo.preReadPhoto", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Photo nextReadPhoto(Map<String, Object> map) {
		Photo dto=null;
		
		try {
			dto=dao.getReadData("photo.nextReadPhoto", map);
		} catch (Exception e) {
		}
		
		return dto;
	}
	
	@Override
	public int insertLikePhoto(Photo dto) {
		int result=0;

		try{
			result=dao.insertData("photo.insertLikePhoto", dto);
		} catch(Exception e) {
		}
		return result;
	}
	
	@Override
	public int countLikePhoto(int num) {
		int result=0;

		try{
			result=dao.getIntValue("photo.countLikePhoto", num);
		} catch(Exception e) {
		}
		return result;
	}
	
	@Override
	public int updatePhoto(Photo dto, String path) {
		int result=0;
		
		try {
			// 업로드한 파일이 존재한 경우
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), path);
		
				if (newFilename != null) {
					// 이전 파일 지우기
					Photo vo = readPhoto(dto.getNum());
					if(vo!=null && vo.getImageFilename()!=null) {
						fileManager.doFileDelete(vo.getImageFilename(), path);
					}
					
					dto.setImageFilename(newFilename);
				}
			}
			
			result=dao.updateData("photo.updatePhoto", dto);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deletePhoto(int num, String imageFilename, String path) {
		int result=0;
		
		try {
			// 댓글, 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제
			
			if(imageFilename!=null)
				fileManager.doFileDelete(imageFilename, path);
			
			// 게시물지우기
			result=dao.deleteData("photo.deletePhoto", num);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deletePhotoId(String userId, String root) {
		int result=0;
		// 회원이 탈퇴한 경우 게시물 삭제.
		// 좋아요/싫어요, 댓글은 ON DELETE CASCADE 옵션으로 자동 삭제
		try {
			String path=root+File.separator+"uploads"+File.separator+"photo";
			
			List<Board>list=dao.getListData("photo.listPhotoId", userId);
			for(Board dto:list) {
				if(dto.getSaveFilename() != null && dto.getSaveFilename().length()!=0) {
					  fileManager.doFileDelete(dto.getSaveFilename(), path);
		       }
			}
			
			dao.deleteData("bbs.deletePhotoId", userId);
			
		} catch (Exception e) {
		}
		
		return result;
	}	
	
	@Override
	public int insertReply(Reply dto) {
		int result=0;
		try {
			result=dao.insertData("photo.insertReply", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.getListData("photo.listReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.getListData("photo.listReplyAnswer", answer);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public int replyCountAnswer(int answer) {
		int result=0;
		try {
			result=dao.getIntValue("photo.replyCountAnswer", answer);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public int replyDataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("photo.replyDataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("photo.deleteReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertReplyLike(Reply dto) {
		int result=0;
		try {
			result=dao.insertData("photo.insertReplyLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Map<String, Object> replyCountLike(int replyNum) {
		Map<String, Object> map=null;
		try {
			map=dao.getReadData("photo.replyCountLike", replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}
}
