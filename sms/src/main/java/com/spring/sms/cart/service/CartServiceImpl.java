package com.spring.sms.cart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sms.cart.dao.CartDao;
import com.spring.sms.cart.dto.CartDto;
@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDao cartDao;
	
	@Override
	public List<Map<String, Object>> getCartList(String memberId) throws Exception {
		
		List<Map<String, Object>> cartInfo = cartDao.getCartList(memberId);
		return cartInfo;
	}

	@Override
	public int addNewGoods(CartDto cartDto) throws Exception {
		
		CartDto checkCart = cartDao.checkCart(cartDto);
		if(checkCart != null) {
			return 2;
		}
		try {
			return cartDao.addNewCart(cartDto);
		} catch (Exception e) {
			return 0;
		}
	}

	@Override
	public void deleteOneCart(int cartId) throws Exception {
		cartDao.deleteOneCart(cartId);
	}

	@Override
	public void updateGoodsCount(CartDto cartDto) throws Exception {
		cartDao.updateGoodsCount(cartDto);
	}
	
	
	
}
