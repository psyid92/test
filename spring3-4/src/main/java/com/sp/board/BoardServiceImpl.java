package com.sp.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("board.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertBoard(Board dto, String mode) {
		int result=0;
		
		try {
			if(mode.equals("created")) {
				int maxNum=dao.getIntValue("board.maxBoardNum");
				dto.setBoardNum(maxNum+1);
				dto.setGroupNum(dto.getBoardNum());
				
			} else if(mode.equals("reply")) {
				// orderNo 변경
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("board.updateOrderNo", map);

				int maxNum=dao.getIntValue("board.maxBoardNum");
				dto.setBoardNum(maxNum+1);
				dto.setDepth(dto.getDepth() + 1);
				dto.setOrderNo(dto.getOrderNo() + 1);
			}
			
			result=dao.insertData("board.insertBoard", dto);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("board.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.getListData("board.listBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Board readBoard(int boardNum) {
		Board dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.getReadData("board.readBoard", boardNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateHitCount(int boardNum) {
		int result=0;

		try{
			result=dao.updateData("board.updateHitCount", boardNum);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.getReadData("board.preReadBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.getReadData("board.nextReadBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateBoard(Board dto) {
		int result=0;

		try{
			result=dao.updateData("board.updateBoard", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteBoard(int boardNum) {
		int result=0;

		try{
			result=dao.deleteData("board.deleteBoard", boardNum);
		} catch(Exception e) {
		}
		return result;
	}
}
