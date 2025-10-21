package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.OrderDetailVO;
import com.spring.springGroupS10.vo.OrderVO;

public interface OrderDAO {

	void insertOrder(@Param("orderVO") OrderVO orderVO);

	void insertOrderDetail(@Param("detail") OrderDetailVO detail);

	void deleteCartItems(@Param("cartIdxs") List<Long> cartIdxs);

	OrderVO getOrderByOrderId(@Param("orderId") String orderId);

	List<OrderVO> getOrderListByMemberIdx(@Param("memberIdx") long memberIdx);

	OrderVO getOrderByOrderIdAndMember(@Param("orderId") String orderId, @Param("memberIdx") long memberIdx);

	List<OrderDetailVO> getOrderDetailItems(@Param("orderIdx") long orderIdx);

}
