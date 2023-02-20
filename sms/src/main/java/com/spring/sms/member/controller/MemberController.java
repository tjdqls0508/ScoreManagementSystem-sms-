package com.spring.sms.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/login" , method=RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap , HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		MemberDto memberDto = memberService.login(loginMap);
		
		if(memberDto != null) {
			HttpSession session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberDto.getMemberId());
			session.setMaxInactiveInterval(60*30);
			mv.setViewName("redirect:/main/main");
		}
		else {
			mv.addObject("invalidMember", true);
			mv.setViewName("/member/loginForm");
		}
		return mv;
	}
	@RequestMapping(value="/logout" , method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		session.setAttribute("isLogout", true);
		session.invalidate();
		
		mv.setViewName("redirect:/main/main");
		
		return mv;
	}
	
	@RequestMapping(value="/addMember" , method=RequestMethod.POST)
	public ResponseEntity<String> addMember(MemberDto memberDto , HttpServletRequest request) throws Exception{
		
		if (memberDto.getEmailstsYn() == null)  memberDto.setEmailstsYn("N");
		if (memberDto.getSmsstsYn() == null)    memberDto.setSmsstsYn("N");
		
		memberDto.setMemberPw(passwordEncoder.encode(memberDto.getMemberPw()));
		
		memberService.addMember(memberDto);

		String message  = "<script>";
			   message += " alert('회원가입되었습니다.');";
			   message += " location.href='" + request.getContextPath() + "/member/loginForm';";
			   message += " </script>";
	    
	    HttpHeaders responseHeaders = new HttpHeaders();
	    responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		return new ResponseEntity<String>(message, responseHeaders, HttpStatus.OK);
	}
	
	@RequestMapping(value="/overlapped" , method=RequestMethod.GET)
	public ResponseEntity<String> overlapped(@RequestParam("memberId") String memberId) throws Exception{
		return new ResponseEntity<String>(memberService.overlapped(memberId), HttpStatus.OK);
	}
	@RequestMapping(value="/loginForm" , method=RequestMethod.GET)
	public ModelAndView loginForm() throws Exception{
		return new ModelAndView("/member/loginForm");
	}
	@RequestMapping(value="/memberForm" , method=RequestMethod.GET)
	public ModelAndView memberForm() throws Exception{
		return new ModelAndView("/member/memberForm");
	}
	
	
}
