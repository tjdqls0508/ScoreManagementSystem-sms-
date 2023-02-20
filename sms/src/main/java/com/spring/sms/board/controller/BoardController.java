package com.spring.sms.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sms.board.dto.BoardDto;
import com.spring.sms.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/main" , method=RequestMethod.GET)
	public ModelAndView main(@RequestParam(name = "onePageViewCount"  , defaultValue = "10")    int onePageViewCount,
							 @RequestParam(name = "currentPageNumber" , defaultValue = "1")     int currentPageNumber,
							 @RequestParam(name = "searchKeyword"     , defaultValue = "total") String searchKeyword,
							 @RequestParam(name = "searchWord"        , defaultValue = "")      String searchWord) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/main");
		
		// 페이지의 시작 게시글 인덱스
		int startBoardIdx =  (currentPageNumber -1) * onePageViewCount + 1;
		if (currentPageNumber == 1) startBoardIdx = 0;
		
		
		// 관련 정보 Map 생성 ( 한페이지에 보여줄 게시글 숫자 , 시작페이지의 인덱스 , 검색 키워드 , 검색어 ) 
		Map<String, Object> searchInfo = new HashMap<String, Object>();
		searchInfo.put("onePageViewCount" , onePageViewCount);
		searchInfo.put("startBoardIdx"    , startBoardIdx);
		searchInfo.put("searchKeyword"    , searchKeyword);
		searchInfo.put("searchWord"       , searchWord);
		List<BoardDto> boardList = boardService.getSearchBoard(searchInfo);
		
		// 게시글의 전체 개수를 반환하는 관련정보 Map 생성 ( 검색 키워드 , 검색어 ) 
		Map<String, String> searchCountInfo = new HashMap<String, String>();
		searchCountInfo.put("searchKeyword", searchKeyword);
		searchCountInfo.put("searchWord", searchWord);
		
		// 전체페이지 개수 = 전체게시글 수 / 한페이지에서 보여지는 글수
		int totalBoardCount = boardService.getAllBoardCount(searchCountInfo);
		int addPage = totalBoardCount % onePageViewCount == 0 ? 0 : 1; 		// 나머지가 0이면 추가 x , 나머지가 0이 아니면 +1 페이지 처리
		int totalPageCount = totalBoardCount / onePageViewCount + addPage;
		
		
		// 시작페이지
		int startPage = 1;
		
		if (currentPageNumber % 10 == 0) startPage = (currentPageNumber / 10 - 1) * 10 + 1;
		else 							 startPage = (currentPageNumber / 10) * 10 + 1;							
		
		/*
		 
			[ 예시 ]  
			
			currentPage가 10페이면 시작페이지는 1  		<>		currentPage가 2페이지면  시작페이지는 1  
			currentPage가 20페이면 시작페이지는 11  	<>		currentPage가 12페이지면 시작페이지는 11  
			currentPage가 30페이면 시작페이지는 21 		<>		currentPage가 22페이지면 시작페이지는 21  
			
		*/
		
	
		
		// 끝페이지
		int endPage = startPage + 9;
			
		// 끝페이지가 전체 페이지 개수보다 크다면 
		if (endPage > totalPageCount) {
			endPage = totalPageCount;
		}
		
		// 게시물이 한페이지에 보여지는 것보다 작다면
		if (onePageViewCount > totalBoardCount) {
			startPage = 1;
			endPage = 0;
		}
		
				
		mv.addObject("startPage"         , startPage);
		mv.addObject("endPage"           , endPage);
		mv.addObject("totalBoardCount"   , totalBoardCount);
		mv.addObject("onePageViewCount"  , onePageViewCount);
		mv.addObject("currentPageNumber" , currentPageNumber);
		mv.addObject("searchKeyword"     , searchKeyword);
		mv.addObject("searchWord"        , searchWord);
		mv.addObject("boardDto"         , boardList);		
				
		
		return mv;
	}
	@RequestMapping(value="/info" , method=RequestMethod.GET)
	public ModelAndView info(@RequestParam("boardNum") int boardNum)throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/info");
		mv.addObject("boardDto", boardService.boardInfo(boardNum));
		return mv;
	}
	
	@RequestMapping(value="/write" , method=RequestMethod.GET)
	public ModelAndView write()throws Exception{
		return new ModelAndView("/board/write");
	}
	
	@RequestMapping(value="/addNewBoard" , method=RequestMethod.POST)
	public ResponseEntity<String> addNewBoard(BoardDto boardDto, HttpServletRequest request) throws Exception{
		boardService.addNewBoard(boardDto);
		String message = "<script>";
			   message += "alert('후기가 작성되었습니다.');";
			   message += "location.href='"+request.getContextPath()+"/board/main';";
			   message += "</script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message,responseHeaders,HttpStatus.OK);
	}
	
	@RequestMapping(value="/modifyBoard", method=RequestMethod.GET)
	public ModelAndView modifyBoard(@RequestParam("boardNum") int boardNum) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/modifyBoard");
		mv.addObject("boardDto", boardService.boardInfo(boardNum));
		
		return mv;
	}
	@RequestMapping(value="/modifyBoard" , method=RequestMethod.POST)
	public ResponseEntity<String> modifyBoard(BoardDto boardDto,HttpServletRequest request)throws Exception{
		
		boardService.modifyBoard(boardDto);
		String message = "";
			   message += "<script>";
			   message += "alert('게시물이 수정되었습니다.');";
			   message += "location.href='"+ request.getContextPath()+"/board/main';";
			   message += "</script>";;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message , responseHeaders ,HttpStatus.OK);
	}
	
	@RequestMapping(value="/removeBoard" , method=RequestMethod.GET)
	public ResponseEntity<String> removeBoard(@RequestParam("boardNum") int boardNum, HttpServletRequest request) throws Exception{		
		boardService.removeBoard(boardNum);
		String message = "";
			   message += "<script>";
			   message += "alert('게시물이 삭제되었습니다.');";
			   message += "location.href='"+ request.getContextPath()+"/board/main';";
			   message += "</script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		return new ResponseEntity<String>(message , responseHeaders ,HttpStatus.OK);
	}
	@RequestMapping(value="/writeReply" , method=RequestMethod.GET)
	public ModelAndView writeReply(@RequestParam("boardNum") int boardNum)throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/boardReply");
		mv.addObject("boardDto", boardService.boardInfo(boardNum));
		return mv;
	}
	@RequestMapping(value="/writeReply" , method=RequestMethod.POST)
	public ModelAndView writeReply(BoardDto boardDto) throws Exception{
		boardService.insertReplyBoard(boardDto);
		return new ModelAndView("redirect:/board/main");	
	}
	
}
