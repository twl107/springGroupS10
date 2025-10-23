package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.CartVO;

public interface CartDAO {

	List<CartVO> getCartList(@Param("memberIdx") long memberIdx);

	CartVO getCartItem(@Param("vo") CartVO vo);

	void updateCartQuantity(@Param("vo") CartVO vo);

	void addCart(@Param("vo") CartVO vo);

	void deleteCartItem(@Param("cartIdx") int cartIdx);

	void updateItemQuantity(@Param("cartIdx") int cartIdx, @Param("quantity") int quantity);

	List<CartVO> getCartListByIdxs(@Param("list") List<Long> cartIdxs);

	List<CartVO> getRecentCartList(@Param("memberIdx") Long memberIdx, @Param("i") int i);

}
