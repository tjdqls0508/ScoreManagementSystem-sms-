package com.spring.sms.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.board.dao.BoardDao;
import com.spring.sms.board.dto.BoardDto;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<BoardDto> getSearchBoard(Map<String, Object> searchInfo) throws Exception {
		return boardDao.getSearchBoard(searchInfo);
	}

	@Override
	public BoardDto boardInfo(int boardNum) throws Exception {
		boardDao.updateReadCount(boardNum);
		return boardDao.selectOneBoard(boardNum);
	}

	@Override
	public void addNewBoard(BoardDto boardDto) throws Exception {
		boardDao.insertNewBoard(boardDto);
	}

	@Override
	public void modifyBoard(BoardDto boardDto) throws Exception {
		boardDao.updateBoard(boardDto);
	}

	@Override
	public void removeBoard(int boardNum) throws Exception {
		boardDao.deleteBoard(boardNum);
	}

	@Override
	public int getAllBoardCount(Map<String, String> searchCountInfo) throws Exception {
		return boardDao.getAllBoardCount(searchCountInfo);
	}

	@Override
	public void insertReplyBoard(BoardDto boardDto) throws Exception {
		boardDao.updateBoardReplyStep(boardDto);
		boardDao.insertReplyBoard(boardDto);
	}


}
