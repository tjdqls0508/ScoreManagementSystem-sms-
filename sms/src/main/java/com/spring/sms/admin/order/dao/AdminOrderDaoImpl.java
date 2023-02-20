package com.spring.sms.admin.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.order.dto.OrderDto;

@Repository
public class AdminOrderDaoImpl implements AdminOrderDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<OrderDto> selectNewOrderList() throws Exception {
		return sqlSession.selectList("mapper.admin.order.selectNewOrderList");
	}

	@Override
	public void updateDeliveryState(Map<String, String> deliveryMap) throws Exception {
		sqlSession.update("mapper.admin.order.updateDeliveryState", deliveryMap);
	}

	@Override
	public Map<String, Object> selectOrderDetail(int orderId) throws Exception {
		return sqlSession.selectOne("mapper.admin.order.selectOrderDetail", orderId);
	}
	
}
