package com.spring.sms.admin.member.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.member.dto.MemberDto;

public interface AdminMemberService {

	public List<MemberDto> listMember()throws Exception;
	public MemberDto memberDetail(String memberId)throws Exception;
	public void modifyMemberInfo(Map<String, String> memberMap)throws Exception;
}
