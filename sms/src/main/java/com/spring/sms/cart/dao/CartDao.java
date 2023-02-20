package com.spring.sms.cart.dao;

import java.util.List;
import java.util.Map;

import com.spring.sms.cart.dto.CartDto;

public interface CartDao {
	
	public CartDto checkCart(CartDto cartDto)throws Exception;
	public int addNewCart(CartDto cartDto)throws Exception;
	public List<Map<String, Object>> getCartList(String memberId);
	public void deleteOneCart(int cartId)throws Exception;
	public void updateGoodsCount(CartDto cartDto)throws Exception;
	
}
