package com.spring.sms.admin.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.admin.order.dao.AdminOrderDao;
import com.spring.sms.order.dto.OrderDto;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Autowired
	private AdminOrderDao adminOrderDao;
	
	@Override
	public List<OrderDto> listNewOrder() throws Exception {
		return adminOrderDao.selectNewOrderList();
	}

	@Override
	public void modifyDeliveryState(Map<String, String> deliveryMap) throws Exception {
		adminOrderDao.updateDeliveryState(deliveryMap);
	}

	@Override
	public Map<String, Object> orderDetail(int orderId) throws Exception {
		return adminOrderDao.selectOrderDetail(orderId);
	}

}
