package com.spring.sms.admin.member.dao;

import java.util.List;
import java.util.Map;

import com.spring.sms.member.dto.MemberDto;

public interface AdminMemberDao {

	public List<MemberDto> listMember()throws Exception;
	public MemberDto memberDetail(String memberId)throws Exception;
	public void modifyMemberInfo(Map<String, String> memberMap)throws Exception;
}
