package com.sp.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int inserScore(Score dto) {
		int result = 0;
		try {
			result = sqlSession.insert("score.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = sqlSession.selectOne("score.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public <T> List<T> listScore(Map<String, Object> map) {
		List<T> list = null;
		try {
			list = sqlSession.selectList("score.listScore", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto = null;
		try {
			dto = sqlSession.selectOne("score.readScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateScore(Score dto) {
		int result = 0;
		try {
			result = sqlSession.update("score.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteScore(String hak) {
		int result = 0;
		try {
			result = sqlSession.delete("score.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteScoreList(List<String> list) {
		int result = 0;
		try {
			result = sqlSession.delete("score.deleteScoreList", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
