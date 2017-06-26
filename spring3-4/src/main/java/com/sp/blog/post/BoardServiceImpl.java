package com.sp.blog.post;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("post.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertBoard(Board dto, String pathname) {
		int result=0;
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());
			
			int maxNum=dao.getIntValue("blogBoard.maxNum", map);
			dto.setNum(maxNum+1);

			result=dao.insertData("blogBoard.insertBoard", dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto, map);
					}
				}
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.getIntValue("blogBoard.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.getListData("blogBoard.listBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public Board readBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.getReadData("blogBoard.readBoard", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public int updateHitCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.updateData("blogBoard.updateHitCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.getReadData("blogBoard.preReadBoard", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.getReadData("blogBoard.nextReadBoard", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String pathname) {
		int result=0;
		
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());
			
			result=dao.updateData("blogBoard.updateBoard", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto, map);
					}
				}
			}
			
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deleteBoard(Map<String, Object> map, String pathname) {
		int result=0;
		
		try {
			// 파일 지우기
			List<Board> listFile=listFile(map);
			if(listFile!=null) {
				Iterator<Board> it=listFile.iterator();
				while(it.hasNext()) {
					Board dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			deleteFile(map);
			
			result=dao.deleteData("blogBoard.deleteBoard", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int insertFile(Board dto, Map<String, Object> map) {
		int result=0;
		try {
			int maxNum=dao.getIntValue("blogBoard.maxFileNum", map);
			dto.setFileNum(maxNum+1);
			
			result=dao.insertData("blogBoard.insertFile", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}	
	@Override
	public List<Board> listFile(Map<String, Object> map) {
		List<Board> listFile=null;
		
		try {
			listFile=dao.getListData("blogBoard.listFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return listFile;
	}

	@Override
	public Board readFile(Map<String, Object> map) {
		Board dto=null;
		
		try {
			dto=dao.getReadData("blogBoard.readFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.deleteData("blogBoard.deleteFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertReply(Reply dto) {
		int result=0;
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());
			int maxNum=dao.getIntValue("blogBoard.maxReplyNum", map);
			dto.setReplyNum(maxNum+1);
			
			result=dao.insertData("blogBoard.insertReply", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.getListData("blogBoard.listReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Reply> listReplyAnswer(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.getListData("blogBoard.listReplyAnswer", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public int replyCountAnswer(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("blogBoard.replyCountAnswer", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public int replyDataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("blogBoard.replyDataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("blogBoard.deleteReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertReplyLike(Reply dto) {
		int result=0;
		try {
			result=dao.insertData("blogBoard.insertReplyLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Map<String, Object> replyCountLike(Map<String, Object> map) {
		Map<String, Object> result=null;
		try {
			result=dao.getReadData("blogBoard.replyCountLike", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}
