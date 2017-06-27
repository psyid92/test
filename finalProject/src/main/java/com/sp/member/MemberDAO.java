package com.sp.member;

public interface MemberDAO {
	public int insertMember(Member1 dto) throws Exception;
	public int updateMember(Member1 dto) throws Exception;
	public int deleteMember(Member1 dto) throws Exception;
	
	public int newLogin(String m1_email) throws Exception;

}
