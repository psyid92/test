package com.sp.myBbs;

import java.util.List;
import java.util.Map;

public class BoardServiceImpl implements BoardService {

	@Override
	public int insertBoard(Board dto) {
		int result = 0;
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updateBoard(Board dto) {
		return 0;
	}

	@Override
	public int deleteBoard(int num) {
		return 0;
	}

	@Override
	public int updateHitCount(int num) {
		return 0;
	}

	@Override
	public Board readBoard(int num) {
		return null;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		return null;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
