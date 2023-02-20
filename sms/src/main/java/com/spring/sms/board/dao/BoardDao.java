package com.spring.sms.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.sms.board.dto.BoardDto;

public interface BoardDao {

	public List<BoardDto> getSearchBoard(Map<String, Object> searchInfo)throws Exception;
	public BoardDto selectOneBoard(int boardNum)throws Exception;
	public void updateReadCount(int boardNum)throws Exception;
	public void insertNewBoard(BoardDto boardDto)throws Exception;
	public void updateBoard(BoardDto boardDto)throws Exception;
	public void deleteBoard(int boardNum)throws Exception;
	public int getAllBoardCount(Map<String, String> searchCountInfo)throws Exception;
	public void insertReplyBoard(BoardDto boardDto)throws Exception;
	public void updateBoardReplyStep(BoardDto boardDto)throws Exception;
	
	
}
