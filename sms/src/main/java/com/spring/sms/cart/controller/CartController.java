package com.spring.sms.cart.controller;

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

import com.spring.sms.cart.dto.CartDto;
import com.spring.sms.cart.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value="/main" , method=RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/cart/main");
		HttpSession session = request.getSession();
		List<Map<String, Object>> cartInfo = cartService.getCartList((String)session.getAttribute("memberInfo"));
		
		
		mv.addObject("cartInfo",cartInfo);
		
		return mv;
	}
	@RequestMapping(value="/addNewGoods" , method=RequestMethod.POST)
	public ResponseEntity<Object> addNewGoods(@RequestParam("memberId") String memberId, @RequestParam("goodsId") int goodsId, @RequestParam("goodsCount") int goodsCount,  HttpServletRequest request)throws Exception{
		CartDto cartDto = new CartDto();
		cartDto.setGoodsId(goodsId);
		cartDto.setMemberId(memberId);
		cartDto.setGoodsCount(goodsCount);
		int result = cartService.addNewGoods(cartDto);
		return  new ResponseEntity<Object>(result +"" , HttpStatus.OK);
		
	}
	
	@RequestMapping(value="/delete" , method=RequestMethod.GET)
	public ResponseEntity<String> delete(@RequestParam("cartId") int cartId , HttpServletRequest request)throws Exception{
		
		cartService.deleteOneCart(cartId);
		
		String message = "";
			   message += "<script>";
			   message += "alert('장바구니에서 삭제되었습니다.');";
			   message += "location.href='"+ request.getContextPath()+"/cart/main';";
			   message += "</script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message , responseHeaders ,HttpStatus.OK);
	}
	
	@RequestMapping(value="/update" , method=RequestMethod.POST)
	public ResponseEntity<String> update(CartDto cartDto , HttpServletRequest request)throws Exception{
		
		cartService.updateGoodsCount(cartDto);
		String message = "";
			   message += "<script>";
			   message += "alert('상품수량이 수정되었습니다.');";
			   message += "location.href='"+ request.getContextPath()+"/cart/main';";
			   message += "</script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message , responseHeaders ,HttpStatus.OK);
	}
	

}
