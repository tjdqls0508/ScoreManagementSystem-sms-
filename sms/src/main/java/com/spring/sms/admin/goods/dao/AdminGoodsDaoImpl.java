package com.spring.sms.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.goods.dto.GoodsDto;

@Repository
public class AdminGoodsDaoImpl implements AdminGoodsDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<GoodsDto> selectNewGoodsList() throws Exception {
		return sqlSession.selectList("mapper.admin.goods.selectNewGoodsList");
	}

	@Override
	public void insertNewGoods(GoodsDto goodsDto) throws Exception {
		sqlSession.insert("mapper.admin.goods.insertNewGoods", goodsDto);
	}

	@Override
	public GoodsDto selectGoodsDetail(int goodsId) throws Exception {
		return sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail", goodsId);
	}

	@Override
	public void updateGoodsInfo(Map<String, Object> goodsMap) throws Exception {
		sqlSession.update("mapper.admin.goods.updateGoodsInfo", goodsMap);
		
	}

	
}
