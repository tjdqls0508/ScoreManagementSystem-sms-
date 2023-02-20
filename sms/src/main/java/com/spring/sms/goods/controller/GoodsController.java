package com.spring.sms.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.goods.service.GoodsService;


@Controller
@RequestMapping("/goods")
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value="/goodsDetail" , method=RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goodsId") int goodsId)throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/goods/goodsDetail");
		mv.addObject("goods", goodsService.goodsDetail(goodsId));
		
		return mv;
	}
	@RequestMapping(value="/goodsStatus" , method=RequestMethod.GET)
	public ModelAndView goodsStatus(@RequestParam("goodsStatus") String goodsStatus,@RequestParam(name = "sortKeyword" , defaultValue = "recent") String sortKeyword, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/goods/goodsStatus");
		
		HttpSession session = request.getSession();
		session.setAttribute("goodsStatus", goodsStatus);
		
		Map<String, Object> goodsInfo = new HashMap<String, Object>();
		goodsInfo.put("goodsStatus", goodsStatus);
		goodsInfo.put("sortKeyword", sortKeyword);
		List<GoodsDto> goodsList =  goodsService.listGoodsSort(goodsInfo);
		mv.addObject("goodsList", goodsList);
		return mv;
	}
	@RequestMapping(value="/genre" , method=RequestMethod.GET)
	public ModelAndView genre(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/goods/goodsGenre");
		
		HttpSession session = request.getSession();
		session.setAttribute("sideMenu", "genreVer");
		
		List<GoodsDto> gayo = goodsService.listGoodsGenre("가요");
		List<GoodsDto> pop = goodsService.listGoodsGenre("POP");
		List<GoodsDto> ost = goodsService.listGoodsGenre("OST");
		List<GoodsDto> jazz = goodsService.listGoodsGenre("재즈");
		List<GoodsDto> classic = goodsService.listGoodsGenre("클래식");
		List<GoodsDto> dongyo = goodsService.listGoodsGenre("동요");
		List<GoodsDto> ccm = goodsService.listGoodsGenre("CCM");
		
		mv.addObject("gayo", gayo);
		mv.addObject("pop", pop);
		mv.addObject("ost", ost);
		mv.addObject("jazz", jazz);
		mv.addObject("classic", classic);
		mv.addObject("dogyo", dongyo);
		mv.addObject("ccm", ccm);
		
		return mv;
	}
	@RequestMapping(value="/genreDetail" , method=RequestMethod.GET)
	public ModelAndView genreDetail(@RequestParam("goodsGenre") String goodsGenre, @RequestParam(name = "sortKeyword" , defaultValue = "recent") String sortKeyword, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/goods/genreDetail");
		
		HttpSession session = request.getSession();
		session.setAttribute("goodsGenre", goodsGenre);
		
		Map<String, Object> goodsInfo = new HashMap<String, Object>();
		goodsInfo.put("goodsGenre", goodsGenre);
		goodsInfo.put("sortKeyword", sortKeyword);
		List<GoodsDto> goodsList = goodsService.listGoodsGenreSort(goodsInfo);
		mv.addObject("goodsList", goodsList);
		return mv;
	}
	
}
