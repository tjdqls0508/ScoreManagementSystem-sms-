package com.spring.sms.admin.member.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.admin.member.service.AdminMemberService;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	private AdminMemberService adminMemberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/adminMemberMain" , method=RequestMethod.GET)
	public ModelAndView adminMemberMain(HttpServletRequest request)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/member/adminMemberMain");
		
		HttpSession session = request.getSession();
		session.setAttribute("memberList", adminMemberService.listMember());
		return mv;
	}
	@RequestMapping(value="/memberDetail" , method=RequestMethod.GET)
	public ModelAndView memberDetail(@RequestParam("memberId") String memberId) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/member/memberDetail");
		mv.addObject("memberInfo", adminMemberService.memberDetail(memberId));
		
		return mv;
	}
	
	@RequestMapping(value="/modifyMemberInfo" , method=RequestMethod.POST)
	public ResponseEntity<Object> modifyMemberInfo(@RequestParam("memberId") String memberId,
												   @RequestParam("modType") String modType,
												   @RequestParam("value") String value) throws Exception{
		
		Map<String, String> memberMap = new HashMap<String, String>();
		String val[] = null;
		
		if(modType.equals("memberPw")) {
			memberMap.put("memberPw", passwordEncoder.encode(value));
		}
		else if(modType.equals("memberName")) {
			memberMap.put("memberName", value);
		}
		else if (modType.equals("memberGender")) {
			memberMap.put("memberGender" , value);
		}
		else if (modType.equals("memberBirth")){
			val = value.split(",");
			memberMap.put("memberBirthY" , val[0]);
			memberMap.put("memberBirthM" , val[1]);
			memberMap.put("memberBirthD"  , val[2]);
			memberMap.put("memberBirthGn" , val[3]);
		}
		else if (modType.equals("hp")){
			val = value.split(",");
			memberMap.put("hp1"      , val[0]);
			memberMap.put("hp2"      , val[1]);
			memberMap.put("hp3"      , val[2]);
			memberMap.put("smsstsYn" , val[3]);
		}
		else if (modType.equals("email")){
			val = value.split(",");
			memberMap.put("email1"     , val[0]);
			memberMap.put("email2"     , val[1]);
			memberMap.put("emailstsYn" , val[2]);
		}
		else if (modType.equals("address")){
			val = value.split(",");
			memberMap.put("zipcode"       , val[0]);
			memberMap.put("roadAddress"   , val[1]);
			memberMap.put("jibunAddress"  , val[2]);
			memberMap.put("namujiAddress" , val[3]);
		}
		
		memberMap.put("memberId", memberId);
		adminMemberService.modifyMemberInfo(memberMap);
		
		return new ResponseEntity<Object>(HttpStatus.OK);
	}
	
	@RequestMapping(value="/memberExcelExport" , method=RequestMethod.GET)
	public void memberExcelExport(HttpServletResponse response , @RequestParam Map<String, String> dateMap) throws Exception {
		  
		SimpleDateFormat joinSdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat fileSdf = new SimpleDateFormat("yyyy_MM_dd_hh_mm");
		String makeFileTime = fileSdf.format(new Date());
		String makeFileName = makeFileTime + "_memberList.xls";
		
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("회원리스트");
	    Row row = null;
	    Cell cell = null;

	    int rowNo = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    // 가는 경계선
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 노란색 배경
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // 가운데 정렬
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("회원아이디");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("회원이름");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("휴대폰번호");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주소");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("가입일");
	    
		for (MemberDto memberDto :  adminMemberService.listMember()) {
			row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(memberDto.getMemberId());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(memberDto.getMemberName());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(memberDto.getHp1() + "-" + memberDto.getHp2() + "-" + memberDto.getHp3());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(memberDto.getRoadAddress() + " " + memberDto.getJibunAddress() + " " + memberDto.getNamujiAddress());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(joinSdf.format(memberDto.getJoinDate()));

		} 

	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+makeFileName);

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();

		
	}
	
}
