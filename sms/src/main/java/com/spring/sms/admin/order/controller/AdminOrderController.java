package com.spring.sms.admin.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.admin.order.service.AdminOrderService;
import com.spring.sms.order.dto.OrderDto;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

	@Autowired
	private AdminOrderService adminOrderService;
	
	@RequestMapping(value="/adminOrderMain" , method=RequestMethod.GET)
	public ModelAndView adminOrderMain(HttpServletRequest request)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/order/adminOrderMain");
		
		HttpSession session = request.getSession();
		session.setAttribute("sideMenu", "adminMode");
		
		List<OrderDto> newOrderList = adminOrderService.listNewOrder();
		mv.addObject("newOrderList", newOrderList);
		
		return mv;
	}
	
	@RequestMapping(value="/modifyDeliveryState" , method=RequestMethod.GET)
	public ResponseEntity<Object> modifyDeliveryState(@RequestParam Map<String, String> deliveryMap) throws Exception{
		
		adminOrderService.modifyDeliveryState(deliveryMap);
		return new ResponseEntity<Object>(HttpStatus.OK);
	}
	@RequestMapping(value="/orderDetail" , method=RequestMethod.GET)
	public ModelAndView orderDetail(@RequestParam("orderId") int orderId)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/order/orderDetail");
		mv.addObject("orderMap", adminOrderService.orderDetail(orderId));
		
		return mv;
	}
	@RequestMapping(value="/orderExcelExport" , method=RequestMethod.GET)
	public void orderExcelExport(HttpServletResponse response , @RequestParam Map<String, String> dateMap) throws Exception {

		SimpleDateFormat orderTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat fileSdf = new SimpleDateFormat("yyyy_MM_dd_hh_mm");
		String makeFileTime = fileSdf.format(new Date());
		String makeFileName = makeFileTime + "_orderList.xls";
		
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("주문리스트");
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
	    cell.setCellValue("주문번호");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문시간");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문자");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문자 연락처");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("수령자");
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("수령자 연락처");
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문상품명");
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("수량");
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("배송상태");

		for (OrderDto orderDto :  adminOrderService.listNewOrder()) {
			row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getOrderId());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderTime.format(orderDto.getPayOrderTime()));
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getOrdererName());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getOrdererHp());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getReceiverName());
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getReceiverHp1() + "-" + orderDto.getReceiverHp2() + "-" + orderDto.getReceiverHp3());
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getGoodsTitle());
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(orderDto.getOrderGoodsQty());
	        cell = row.createCell(8);
	        cell.setCellStyle(bodyStyle);
	        if (orderDto.getDeliveryState().equals("deliveryPrepared")) 	cell.setCellValue("배송준비중");
	        if (orderDto.getDeliveryState().equals("delivering")) 			cell.setCellValue("배송중");
	        if (orderDto.getDeliveryState().equals("finishedDelivering"))   cell.setCellValue("배송완료");
	        if (orderDto.getDeliveryState().equals("cancelOrder")) 			cell.setCellValue("주문취소");
	        if (orderDto.getDeliveryState().equals("returningGoods")) 		cell.setCellValue("반품");
		} 

	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+makeFileName);

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();

		
	}
}




























