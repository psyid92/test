package com.sp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member readMember(String userId);
	
	public int insertMember(Member dto);
	
	public int updateMember(Member dto);
	public int updateLastLogin(String userId);
	
	public int deleteMember2(String userId);
	
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
}
