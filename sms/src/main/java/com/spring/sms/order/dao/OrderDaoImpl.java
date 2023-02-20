package com.spring.sms.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.goods.dto.GoodsDto;
import com.spring.sms.member.dto.MemberDto;
import com.spring.sms.order.dto.OrderDto;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertNewOrder(OrderDto orderDto) throws Exception {
		sqlSession.insert("mapper.order.insertNewOrder", orderDto);
	}

	@Override
	public MemberDto selectOrdererInfo(String memberId) throws Exception {
		return sqlSession.selectOne("mapper.order.selectOrdererInfo", memberId);
	}

	@Override
	public GoodsDto selectGoodsInfo(int goodsId) throws Exception {
		return sqlSession.selectOne("mapper.order.selectGoodsInfo", goodsId);
	}

	@Override
	public List<OrderDto> selectOrderList(String memberId) throws Exception {
		return sqlSession.selectList("mapper.order.selectOrderList", memberId);
	}

	@Override
	public Map<String, Object> selectOrderDetail(int orderId) throws Exception {
		return sqlSession.selectOne("mapper.order.selectOrderDetail", orderId);
	}

	@Override
	public void updateDeliveryState(int orderId) throws Exception {
		sqlSession.update("mapper.order.updateDeliveryState", orderId);
	}

}
