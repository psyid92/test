package com.sp.bbs;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("bbs.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertBoard(Board dto, String pathname) {
		int result = 0;
		try {
			if (! dto.getUpload().isEmpty()) {
				String filename = fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setSaveFilename(filename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			result = dao.insertData("bbs.insertBoard", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("bbs.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = new ArrayList<>();
		try {
			list = dao.getListData("bbs.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Board readBoard(int num) {
		Board dto = null;
		try {
			dto = dao.getReadData("bbs.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateHitCount(int num) {
		int result = 0;
		try {
			result = dao.updateData("bbs.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.getReadData("bbs.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.getReadData("bbs.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String pathname) {
		int result = 0;
		
		try {
			if (dto.getUpload() != null && !dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
				
				if (newFilename != null) {
					// 이전 파일 지우기
					if (dto.getSaveFilename().length() != 0 && dto.getSaveFilename() != null) {
						fileManager.doFileDelete(dto.getSaveFilename(), pathname);
					}
					
					dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
					dto.setSaveFilename(newFilename);
				}
			}
			dao.updateData("bbs.updateBoard", dto);
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteBoard(int num, String pathname, String userId) {
		int result = 0;
		
		try {
			Board dto = readBoard(num);
			if (dto != null) {
				if (!dto.getUserId().equals(userId) && !userId.equals("admin"))
					return result;
				if (dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			dao.deleteData("bbs.deleteBoard", num);
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertLikeBoard(Board dto) {
		int result = 0;
		try {
			result = dao.insertData("bbs.insertLikeBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int countLikeBoard(int num) {
		int result = 0;
		try {
			result = dao.getIntValue("bbs.countLikeBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertReply(Reply dto) {
		int result = 0;
		try {
			result = dao.insertData("bbs.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = new ArrayList<>();
		try {
			list = dao.getListData("bbs.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("bbs.replyDataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.deleteData("bbs.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
