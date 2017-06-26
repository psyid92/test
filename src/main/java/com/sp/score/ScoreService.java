package com.sp.score;

import java.util.List;
import java.util.Map;

public interface ScoreService {
	public int inserScore(Score dto);
	public int dataCount(Map<String, Object> map);
	public List<Score> listScore(Map<String, Object> map);
	public Score readScore(String hak);
	public int updateScore(Score dto);
	public int deleteScore(String hak);
	public int deleteScoreList(List<String> list);
}
