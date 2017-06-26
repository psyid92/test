package com.sp.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;

	@Override
	public Member readMember1(int memberIdx) {
		Member dto=null;
		try {
			dto=dao.getReadData("member.readMember1", memberIdx);
			
			if(dto!=null) {
				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Member readMember2(String userId) {
		Member dto=null;
		try {
			dto=dao.getReadData("member.readMember2", userId);
			
			if(dto!=null) {
				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int insertMember(Member dto) {
		int result=0;
		
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());

			int seq=dao.getIntValue("member.memberSeq");
			dto.setMemberIdx(seq);
			
			// 회원정보 저장
			dao.insertData("member.insertMember1", seq);
			dao.insertData("member.insertMember2", dto);
			
			result=1;
		} catch (Exception e) {
		}
		
		return result;
	}
	
	@Override
	public int updateMember2(Member dto) {
		int result=0;
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			result=dao.updateData("member.updateMember2", dto);
			
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateLastLogin(String userId) {
		int result=0;
		try {
			result=dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteMember2(Map<String, Object> map) {
		int result=0;
		try {
			
			// member1 테이블 수정
			int memberIdx=(Integer)map.get("memberIdx");
			dao.updateData("member.updateMember1", memberIdx);
			
			// member2 테이블 삭제
			String userId=(String)map.get("userId");
			result=dao.deleteData("member.deleteMember2", userId);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("member.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.getListData("member.listMember", map);
		} catch (Exception e) {
		}
		return list;
	}
}
