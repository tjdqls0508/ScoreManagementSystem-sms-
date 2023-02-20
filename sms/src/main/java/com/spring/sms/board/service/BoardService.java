package com.spring.sms.board.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.board.dto.BoardDto;

public interface BoardService {

	public List<BoardDto> getSearchBoard(Map<String, Object> searchInfo)throws Exception;
	public int getAllBoardCount(Map<String, String> searchCountInfo) throws Exception;
	public BoardDto boardInfo(int boardNum)throws Exception;
	public void addNewBoard(BoardDto boardDto)throws Exception;
	public void modifyBoard(BoardDto boardDto)throws Exception;
	public void removeBoard(int boardNum)throws Exception;
	public void insertReplyBoard (BoardDto boardDto)throws Exception;
}
