package com.spring.sms.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.goods.dto.GoodsDto;

public interface AdminGoodsService {

	public List<GoodsDto> listNewGoods()throws Exception;
	public void addNewGoods(GoodsDto goodsDto)throws Exception;
	public GoodsDto goodsDetail(int goodsId)throws Exception;
	public void modifyGoodsInfo(Map<String, Object> goodsMap)throws Exception;
	 
}
