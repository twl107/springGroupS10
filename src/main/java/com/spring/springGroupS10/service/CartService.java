package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.CartVO;

public interface CartService {

	List<CartVO> getCartList(long memberIdx);

	int addOrUpdateCart(CartVO vo);

	void deleteCartItem(int cartIdx);

	void updateItemQuantity(int cartIdx, int quantity);

	List<CartVO> getCartListByIdxs(List<Long> cartIdxs);

}
