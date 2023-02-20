package com.spring.sms.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.goods.dto.GoodsDto;

@Repository
public class GoodsDaoImpl implements GoodsDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public GoodsDto selectGoodsDetail(int goodsId) throws Exception {
		return sqlSession.selectOne("mapper.goods.selectGoodsDetail", goodsId);
	}

	@Override
	public List<GoodsDto> selectGoodsList(String goodsStatus) throws Exception {
		return sqlSession.selectList("mapper.goods.selectGoodsList", goodsStatus);
	}


	@Override
	public List<GoodsDto> selectGoodsGenre(String goodsGenre) throws Exception {
		return sqlSession.selectList("mapper.goods.selectGenreList", goodsGenre);
	}

	@Override
	public void updateHitsNum(int goodsId) throws Exception {
		sqlSession.update("mapper.goods.updateHitsNum", goodsId);
	}

	@Override
	public List<GoodsDto> selectGoodListSort(Map<String, Object> goodsInfo) throws Exception {
		return sqlSession.selectList("mapper.goods.selectGoodsListSort" , goodsInfo);
	}

	@Override
	public List<GoodsDto> selectGoodsGenreSort(Map<String, Object> goodsInfo) throws Exception {
		return sqlSession.selectList("mapper.goods.selectGoodsGenreSort" , goodsInfo);
	}

}
