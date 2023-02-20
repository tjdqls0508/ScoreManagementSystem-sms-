package com.spring.sms.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.sms.member.dao.MemberDao;
import com.spring.sms.member.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	
	@Override
	public MemberDto login(Map<String, String> loginMap) throws Exception {

		MemberDto memberDto = memberDao.login(loginMap);
		
		if(memberDto != null) {
			if(passwordEncoder.matches(loginMap.get("memberPw"), memberDto.getMemberPw()));
				return memberDto;
		}
		
		return null;
	}

	@Override
	public void addMember(MemberDto memberDto) throws Exception {
		memberDao.insertNewMember(memberDto);
	}

	@Override
	public String overlapped(String memberId) throws Exception {
		if(memberDao.selectOverlappedID(memberId) == 1)		return "true";
		else												return "false";
	}

}
