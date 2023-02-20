package com.spring.sms.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.order.dto.OrderDto;
import com.spring.sms.order.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value="/orderEachGoods" , method=RequestMethod.GET)
	public ModelAndView orderEachGoods(@RequestParam("goodsId") 	  int goodsId,
									   @RequestParam("orderGoodsQty") int orderGoodsQty,
									   HttpServletRequest request) 					throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/order/orderEachGoods");
		HttpSession session = request.getSession();
		
		mv.addObject("orderer", orderService.getOrdererInfo((String)session.getAttribute("memberInfo")));
		mv.addObject("goodsInfo", orderService.getGoodsInfo(goodsId));
		mv.addObject("orderGoodsQty", orderGoodsQty);
		return mv;
	}
	@RequestMapping(value="/payToOrderGoods" , method=RequestMethod.POST)
	public ResponseEntity<Object> payToOrderGoods(OrderDto orderDto , HttpServletRequest request) throws Exception{
		orderService.addNewOrder(orderDto);
		return new ResponseEntity<Object>(HttpStatus.OK);
	}
	//이거 작동안함 세션문제인가
	@RequestMapping(value="/orderList" ,  method=RequestMethod.GET)
	public ModelAndView orderList(HttpServletRequest request)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/order/orderList");
		
		HttpSession session = request.getSession();
		List<OrderDto> orderList = orderService.getOrderList((String) session.getAttribute("memberInfo"));
		mv.addObject("orderList", orderList);
		
		return mv;
		
	}
	
	@RequestMapping(value="/orderDetail" , method=RequestMethod.GET)
	public ModelAndView orderDetail(@RequestParam("orderId") int orderId)throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/order/orderDetail");
		mv.addObject("orderMap", orderService.orderDetail(orderId));
		
		return mv;
	
	}
	
	@RequestMapping(value="/modifyDeliveryState" , method=RequestMethod.GET)
	public ResponseEntity<String> modifyDeliveryState(@RequestParam("orderId") int orderId, HttpServletRequest request) throws Exception{
		orderService.modifyDeliveryState(orderId);
		String message = "";
			   message += "<script>";
			   message += "alert('주문이 취소 되었습니다.');";
			   message += "location.href='" + request.getContextPath() + "/order/orderList';";
			   message += "</script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message, responseHeaders, HttpStatus.OK);
	}
}
