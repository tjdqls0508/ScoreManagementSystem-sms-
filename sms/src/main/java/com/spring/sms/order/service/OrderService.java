package com.spring.sms.order.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.order.dto.OrderDto;

public interface OrderService {

	public void addNewOrder(OrderDto orderDto) throws Exception;
	public MemberDto getOrdererInfo(String memberId)throws Exception;
	public GoodsDto getGoodsInfo(int goodsId)throws Exception;
	public List<OrderDto> getOrderList(String memberId)throws Exception;
	public Map<String , Object> orderDetail(int orderId)throws Exception;
	public void modifyDeliveryState(int orderId)throws Exception;
}
