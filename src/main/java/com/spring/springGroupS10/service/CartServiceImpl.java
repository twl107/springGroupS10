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
		CartVO existingCartItem = cartDAO.getCartItem(vo);
		
		if (existingCartItem != null) {
			vo.setIdx(existingCartItem.getIdx());
			cartDAO.updateCartQuantity(vo);
		}
		else {
			cartDAO.addCart(vo);
		}
		return 1;
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
