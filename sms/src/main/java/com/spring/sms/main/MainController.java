package com.spring.sms.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.goods.service.GoodsService;

@Controller
public class MainController {
	
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value="/" , method=RequestMethod.GET)	
	public ModelAndView home()throws  Exception{
		return new ModelAndView("redirect:/main/main");
	}
	@RequestMapping(value="/main/main" , method=RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/main");
		
		HttpSession session = request.getSession();
		session.setAttribute("sideMenu", "user");
		
		List<GoodsDto> bestseller = goodsService.listGoods("bestseller");
		List<GoodsDto> recommend = goodsService.listGoods("recommend");
		List<GoodsDto> newScore = goodsService.listGoods("newScore");
		
		mv.addObject("bestseller", bestseller);
		mv.addObject("recommend", recommend);
		mv.addObject("newScore", newScore);
		
		return mv;
	}
	
}
