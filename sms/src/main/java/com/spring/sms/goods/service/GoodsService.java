package com.spring.sms.goods.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.goods.dto.GoodsDto;

public interface GoodsService {

	public GoodsDto goodsDetail(int goodsId)throws Exception;
	public List<GoodsDto> listGoods(String goodsStatus) throws Exception;
	public List<GoodsDto> listGoodsGenre(String goodsGenre) throws Exception;
	public List<GoodsDto> listGoodsGenreSort(Map<String, Object> goodsInfo) throws Exception;
	public List<GoodsDto> listGoodsSort(Map<String, Object> goodsInfo) throws Exception;
}
