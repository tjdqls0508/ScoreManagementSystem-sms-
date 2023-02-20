package com.spring.sms.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.goods.dao.GoodsDao;
import com.spring.sms.goods.dto.GoodsDto;

@Service
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public GoodsDto goodsDetail(int goodsId) throws Exception {
		goodsDao.updateHitsNum(goodsId);
		return goodsDao.selectGoodsDetail(goodsId);
	}


	@Override
	public List<GoodsDto> listGoodsGenre(String goodsGenre) throws Exception {
		return goodsDao.selectGoodsGenre(goodsGenre);
	}

	@Override
	public List<GoodsDto> listGoods(String goodsStatus) throws Exception {
		return goodsDao.selectGoodsList(goodsStatus);
	}

	@Override
	public List<GoodsDto> listGoodsSort(Map<String, Object> goodsInfo) throws Exception {
		return goodsDao.selectGoodListSort(goodsInfo);
	}


	@Override
	public List<GoodsDto> listGoodsGenreSort(Map<String, Object> goodsInfo) throws Exception {
		return goodsDao.selectGoodsGenreSort(goodsInfo);
	}

}
