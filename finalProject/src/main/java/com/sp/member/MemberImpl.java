package com.sp.member;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberImpl implements MemberDAO{
	
	@Autowired
	private CommonDAO  dao;
	
	@Override
	public int insertMember(Member1 dto) throws Exception {
		int result = 0;
		
		try {
			dao.insertData("insertMember1", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updateMember(Member1 dto) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMember(Member1 dto) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int newLogin(String m1_email) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
