package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.dao.CartDAO;
import com.spring.springGroupS10.vo.CartVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	CartDAO cartDAO;

	@Override
	public List<CartVO> getCartList(long memberIdx) {
		return cartDAO.getCartList(memberIdx);
	}

	@Override
	public int addOrUpdateCart(CartVO vo) {
		// 1. 현재 회원의 장바구니에 동일한 상품(옵션까지)이 있는지 확인한다.
		CartVO existingCartItem = cartDAO.getCartItem(vo);
		
		// 2. 만약 동일한 상품이 존재한다면,
		if (existingCartItem != null) {
			// 기존 항목의 idx와 추가할 수량을 vo에 담아 수량 업데이트를 요청한다.
			vo.setIdx(existingCartItem.getIdx());
			cartDAO.updateCartQuantity(vo);
		}
		// 3. 만약 동일한 상품이 없다면,
		else {
			// 새롭게 장바구니에 추가한다.
			cartDAO.addCart(vo);
		}
		return 1; // 특별한 예외가 없다면 성공으로 간주
	}

	@Override
	public void deleteCartItem(int cartIdx) {
		cartDAO.deleteCartItem(cartIdx);
	}

	@Override
	public void updateItemQuantity(int cartIdx, int quantity) {
		cartDAO.updateItemQuantity(cartIdx, quantity);
	}

	@Override
	public List<CartVO> getCartListByIdxs(List<Long> cartIdxs) {
		return cartDAO.getCartListByIdxs(cartIdxs);
	}

	@Override
	public List<CartVO> getRecentCartList(Long memberIdx, int i) {
		return cartDAO.getRecentCartList(memberIdx, i);
	}

}
