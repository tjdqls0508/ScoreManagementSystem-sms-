package com.spring.sms.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.order.dao.OrderDao;
import com.spring.sms.order.dto.OrderDto;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	
	@Override
	public void addNewOrder(OrderDto orderDto) throws Exception {
		orderDao.insertNewOrder(orderDto);
	}

	@Override
	public MemberDto getOrdererInfo(String memberId) throws Exception {
		return orderDao.selectOrdererInfo(memberId);
	}

	@Override
	public GoodsDto getGoodsInfo(int goodsId) throws Exception {
		return orderDao.selectGoodsInfo(goodsId);
	}

	@Override
	public List<OrderDto> getOrderList(String memberId) throws Exception {
		return orderDao.selectOrderList(memberId);
	}

	@Override
	public Map<String, Object> orderDetail(int orderId) throws Exception {
		return orderDao.selectOrderDetail(orderId);
	}

	@Override
	public void modifyDeliveryState(int orderId) throws Exception {
		orderDao.updateDeliveryState(orderId);
	}

}
