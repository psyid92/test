package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private ScoreDAO dao;

	@Override
	public int inserScore(Score dto) {
		int result = 0;
		result = dao.inserScore(dto);
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		result = dao.dataCount(map);
		return result;
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list = null;
		list = dao.listScore(map);
		return list;
	}

	@Override
	public Score readScore(String hak) {
		return dao.readScore(hak);
	}

	@Override
	public int updateScore(Score dto) {
		return dao.updateScore(dto);
	}

	@Override
	public int deleteScore(String hak) {
		return dao.deleteScore(hak);
	}

	@Override
	public int deleteScoreList(List<String> list) {
		return dao.deleteScoreList(list);
	}
}
