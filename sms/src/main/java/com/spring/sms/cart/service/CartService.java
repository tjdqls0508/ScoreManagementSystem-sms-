package com.spring.sms.cart.service;

import java.util.List;
import java.util.Map;

import com.spring.sms.cart.dto.CartDto;

public interface CartService {
	
	public List<Map<String, Object>> getCartList(String memberId)throws Exception;
	public int addNewGoods(CartDto cartDto)throws Exception;
	public void deleteOneCart(int cartId)throws Exception;
	public void updateGoodsCount(CartDto cartDto)throws Exception;
}
