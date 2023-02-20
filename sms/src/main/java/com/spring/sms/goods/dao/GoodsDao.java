package com.spring.sms.goods.dao;

import java.util.List;
import java.util.Map;

import com.spring.sms.goods.dto.GoodsDto;

public interface GoodsDao {
	
	public GoodsDto selectGoodsDetail(int goodsId)throws Exception;
	public List<GoodsDto> selectGoodsList(String goodsStatus)throws Exception;
	public List<GoodsDto> selectGoodsGenre(String goodsGenre)throws Exception;
	public List<GoodsDto> selectGoodsGenreSort(Map<String, Object> goodsInfo)throws Exception;
	public void updateHitsNum(int goodsId)throws Exception;
	public List<GoodsDto> selectGoodListSort(Map<String, Object> goodsInfo)throws Exception;
}
