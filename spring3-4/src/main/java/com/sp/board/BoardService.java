package com.sp.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertBoard(Board dto, String mode);
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	
	// 게시물 보기
	public Board readBoard(int boardNum);
	
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	
	public int updateHitCount(int boardNum);
	
	public int updateBoard(Board dto);
	public int deleteBoard(int boardNum);
}
