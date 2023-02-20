package com.spring.sms.order.dao;

import java.util.List;
import java.util.Map;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.order.dto.OrderDto;

public interface OrderDao {

	public void insertNewOrder(OrderDto orderDto) throws Exception;
	public MemberDto selectOrdererInfo(String memberId)throws Exception;
	public GoodsDto selectGoodsInfo(int goodsId) throws Exception;
	public List<OrderDto> selectOrderList(String memberId)throws Exception;
	public Map<String, Object> selectOrderDetail(int orderId)throws Exception;
	public void updateDeliveryState(int orderId)throws Exception;
}
