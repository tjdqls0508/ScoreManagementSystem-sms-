package com.spring.sms.member.dao;

import java.util.Map;

import com.spring.sms.member.dto.MemberDto;

public interface MemberDao {

	public MemberDto login(Map<String, String> loginMap)throws Exception;
	public void insertNewMember(MemberDto memberDto)throws Exception;
	public int selectOverlappedID(String memberId)throws Exception;
}
