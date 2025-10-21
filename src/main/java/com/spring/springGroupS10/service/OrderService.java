package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.OrderDetailVO;
import com.spring.springGroupS10.vo.OrderVO;

public interface OrderService {

	boolean processOrder(OrderVO orderVO, List<Long> cartIdxs);

	OrderVO getOrderByOrderId(String orderId);

	List<OrderVO> getOrderListByMemberIdx(long memberIdx);

	OrderVO getOrderByOrderIdAndMember(String orderId, long memberIdx);

	List<OrderDetailVO> getOrderDetailItems(long orderIdx);

}
