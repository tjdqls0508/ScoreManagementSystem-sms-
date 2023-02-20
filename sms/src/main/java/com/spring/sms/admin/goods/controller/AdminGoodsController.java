package com.spring.sms.admin.goods.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.admin.goods.service.AdminGoodsService;
import com.spring.sms.goods.dto.GoodsDto;

@Controller
@RequestMapping("/admin/goods")
public class AdminGoodsController {

	//private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	//String seperatorPath = "\\";	// window

	private static final String CURR_IMAGE_REPO_PATH = "/var/lib/tomcat8/file_repo";
	String seperatorPath = "/";		// linux
	
	@Autowired
	private AdminGoodsService adminGoodsService;
	
	@RequestMapping(value="/adminGoodsMain" , method=RequestMethod.GET)
	public ModelAndView adminGoodsMain(HttpServletRequest request)throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/goods/adminGoodsMain");
		
		HttpSession session = request.getSession();
		session.setAttribute("sideMenu", "adminMode");
		
		mv.addObject("newGoodsList", adminGoodsService.listNewGoods());
		
		return mv;
	}
	@RequestMapping(value="/addNewGoods" , method=RequestMethod.GET)
	public String addNewGoods() throws Exception{
		return "/admin/goods/addNewGoodsForm";
	}
	@RequestMapping(value="/addNewGoods" , method=RequestMethod.POST)
	public ResponseEntity<String> addNewGoods(MultipartHttpServletRequest multipartRequest , HttpServletResponse response) throws Exception{
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		
		GoodsDto goodsDto = new GoodsDto();
		goodsDto.setGoodsTitle(multipartRequest.getParameter("goodsTitle"));
		goodsDto.setGoodsSinger(multipartRequest.getParameter("goodsSinger"));
		int goodsPrice = Integer.parseInt(multipartRequest.getParameter("goodsPrice"));
		goodsDto.setGoodsPrice(goodsPrice);
		goodsDto.setGoodsComposer(multipartRequest.getParameter("goodsComposer"));
		goodsDto.setGoodsGenre(multipartRequest.getParameter("goodsGenre"));
		int goodsPoint = Integer.parseInt(multipartRequest.getParameter("goodsPoint"));
		goodsDto.setGoodsPoint(goodsPoint);
		goodsDto.setGoodsUploadDate(fm.parse(multipartRequest.getParameter("goodsUploadDate")));
		int goodsTotalPage = Integer.parseInt(multipartRequest.getParameter("goodsTotalPage"));
		goodsDto.setGoodsTotalPage(goodsTotalPage);
		int goodsDeliveryPrice = Integer.parseInt(multipartRequest.getParameter("goodsDeliveryPrice"));
		goodsDto.setGoodsDeliveryPrice(goodsDeliveryPrice);
		goodsDto.setGoodsDeliveryDate(fm.parse(multipartRequest.getParameter("goodsDeliveryDate")));
		goodsDto.setGoodsStatus(multipartRequest.getParameter("goodsStatus"));

		Iterator<String> file = multipartRequest.getFileNames();
		String originalFileName = "";
		if (file.hasNext()) {
			
			MultipartFile uploadFile = multipartRequest.getFile(file.next()); 	
			
			if(!uploadFile.getOriginalFilename().isEmpty()) {
			
				File f = new File(CURR_IMAGE_REPO_PATH + seperatorPath + uploadFile.getOriginalFilename());	
				uploadFile.transferTo(f); 
				goodsDto.setGoodsFileName(uploadFile.getOriginalFilename());
			}
		
		}
		
		adminGoodsService.addNewGoods(goodsDto);
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String message= "<script>";
			   message += " alert('성공적으로 등록되었습니다.');";
			   message +=" location.href='" + multipartRequest.getContextPath() + "/admin/goods/adminGoodsMain';";
			   message +="</script>";
		
		return new ResponseEntity<String>(message, responseHeaders, HttpStatus.OK);
		
	}
	
	@RequestMapping(value="/modifyGoodsForm" , method=RequestMethod.GET)
	public ModelAndView modifyGoodsForm(@RequestParam("goodsId") int goodsId) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/goods/modifyGoodsForm");
		mv.addObject("goods", adminGoodsService.goodsDetail(goodsId));
		
		return mv;
	}
	@RequestMapping(value="/modifyGoodsInfo" , method=RequestMethod.POST)
	public ResponseEntity<String> modifyGoodsInfo(@RequestParam("goodsId") int goodsId, 
												  @RequestParam("attribute") String attribute,
												  @RequestParam("value")	 String value) throws Exception{
		
		
		Map<String, Object> goodsMap = new HashMap<String, Object>();
		goodsMap.put("goodsId", goodsId);
		goodsMap.put(attribute, value);
		adminGoodsService.modifyGoodsInfo(goodsMap);
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	@RequestMapping(value="/modifyGoodsImageInfo" , method=RequestMethod.POST)
	public ResponseEntity<String> modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest , HttpServletResponse response) throws Exception{
		
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFileName = "";
		Iterator<String> file = multipartRequest.getFileNames();
		if (file.hasNext()) {
			
			MultipartFile uploadFile = multipartRequest.getFile(file.next()); 	
			File f = new File(CURR_IMAGE_REPO_PATH + seperatorPath + uploadFile.getOriginalFilename());	
			uploadFile.transferTo(f); 

			originalFileName = uploadFile.getOriginalFilename();
		}
		Map<String,Object> goodsMap = new HashMap<String,Object>();
		int goodsId = Integer.parseInt(multipartRequest.getParameter("goodsId"));
		goodsMap.put("goodsId" , goodsId);
		goodsMap.put("goodsFileName" , originalFileName);
		adminGoodsService.modifyGoodsInfo(goodsMap);
		
		return new ResponseEntity<String>(HttpStatus.OK);
		
	}
	
	@RequestMapping(value="/goodsExcelExport" , method=RequestMethod.GET)
	public void goodsExcelExport(HttpServletResponse response , @RequestParam Map<String, String> dateMap) throws Exception {
		  
		SimpleDateFormat fileSdf = new SimpleDateFormat("yyyy_MM_dd_hh_mm");
		SimpleDateFormat dateSdf = new SimpleDateFormat("yyyy-MM-dd");
		String makeFileTime = fileSdf.format(new Date());
		String makeFileName = makeFileTime + "_goodsList.xls";
		
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("상품리스트");
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
	    cell.setCellValue("상품번호");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품이름");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("가수");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("작곡가");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품가격");
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("업로드 날짜");

		for (GoodsDto goodsDto :  adminGoodsService.listNewGoods()) {
			row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(goodsDto.getGoodsId());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(goodsDto.getGoodsTitle());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(goodsDto.getGoodsSinger());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(goodsDto.getGoodsComposer());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(goodsDto.getGoodsPrice());
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(dateSdf.format(goodsDto.getGoodsUploadDate()));
		} 

	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+makeFileName);

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
		
	}
	
}
