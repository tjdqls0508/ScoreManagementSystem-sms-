package com.spring.sms.cart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.sms.cart.dto.CartDto;

@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public CartDto checkCart(CartDto cartDto) throws Exception {
		return sqlSession.selectOne("mapper.cart.checkCart", cartDto);
	}

	@Override
	public int addNewCart(CartDto cartDto) throws Exception {
		sqlSession.insert("mapper.cart.addNewCart", cartDto);
		return 1;
	}

	@Override
	public List<Map<String, Object>> getCartList(String memberId) {
		return sqlSession.selectList("mapper.cart.getCartList", memberId);
	}

	@Override
	public void deleteOneCart(int cartId) throws Exception {
		sqlSession.delete("mapper.cart.deleteOneCart", cartId);
	}

	@Override
	public void updateGoodsCount(CartDto cartDto) throws Exception {
		sqlSession.update("mapper.cart.updateGoodsCount", cartDto);
	}

}
