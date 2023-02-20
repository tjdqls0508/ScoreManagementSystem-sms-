package com.spring.sms.member.service;

import java.util.Map;

import com.spring.sms.member.dto.MemberDto;

public interface MemberService {
	
	public MemberDto login(Map<String, String> loginMap) throws Exception;
	public void addMember(MemberDto memberDto)throws Exception;
	public String overlapped(String memberId)throws Exception;
	
}
