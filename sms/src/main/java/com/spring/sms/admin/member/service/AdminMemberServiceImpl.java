package com.spring.sms.admin.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.admin.member.dao.AdminMemberDao;
import com.spring.sms.member.dto.MemberDto;
@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDao adminMemberDao;
	
	@Override
	public List<MemberDto> listMember() throws Exception {
		return adminMemberDao.listMember();
	}

	@Override
	public MemberDto memberDetail(String memberId) throws Exception {
		return adminMemberDao.memberDetail(memberId);
	}

	@Override
	public void modifyMemberInfo(Map<String, String> memberMap) throws Exception {
		adminMemberDao.modifyMemberInfo(memberMap);
	}

}
