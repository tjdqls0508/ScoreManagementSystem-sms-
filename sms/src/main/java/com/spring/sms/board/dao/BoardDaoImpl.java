package com.spring.sms.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.board.dto.BoardDto;

import sun.print.resources.serviceui;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<BoardDto> getSearchBoard(Map<String, Object> searchInfo) throws Exception {
		return sqlSession.selectList("mapper.board.getSearchBoard" , searchInfo);
	}

	@Override
	public BoardDto selectOneBoard(int boardNum) throws Exception {
		return sqlSession.selectOne("mapper.board.selectOneBoard", boardNum);
	}

	@Override
	public void updateReadCount(int boardNum) throws Exception {
		sqlSession.update("mapper.board.increaseReadCount", boardNum);
	}

	@Override
	public void insertNewBoard(BoardDto boardDto) throws Exception {
		sqlSession.insert("mapper.board.addNewBoard", boardDto);
	}

	@Override
	public void updateBoard(BoardDto boardDto) throws Exception {
		sqlSession.update("mapper.board.updateBoard", boardDto);
	}

	@Override
	public void deleteBoard(int boardNum) throws Exception {
		sqlSession.delete("mapper.board.removeBoard", boardNum);
	}

	@Override
	public int getAllBoardCount(Map<String, String> searchCountInfo) throws Exception {
		return sqlSession.selectOne("mapper.board.getAllBoardCount", searchCountInfo);
	}

	@Override
	public void insertReplyBoard(BoardDto boardDto) throws Exception {
		sqlSession.insert("mapper.board.insertReplyBoard", boardDto);
	}

	@Override
	public void updateBoardReplyStep(BoardDto boardDto) throws Exception {
		sqlSession.update("mapper.board.updateBoardReplyStep", boardDto);
	}

}
