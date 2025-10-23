package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.springGroupS10.dao.OrderDAO;
import com.spring.springGroupS10.vo.OrderDetailVO;
import com.spring.springGroupS10.vo.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO orderDAO;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean processOrder(OrderVO orderVO, List<Long> cartIdxs) {
		try {
			orderDAO.insertOrder(orderVO);
			long orderIdx = orderVO.getIdx();
			
			for(OrderDetailVO detail : orderVO.getOrderDetails()) {
				detail.setOrderIdx(orderIdx);
				
				if (detail.getOptionIdx() != null && detail.getOptionIdx() == 0) {
					detail.setOptionIdx(null);
				}
				
				orderDAO.insertOrderDetail(detail);
			}
			
			orderDAO.deleteCartItems(cartIdxs);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public OrderVO getOrderByOrderId(String orderId) {
		return orderDAO.getOrderByOrderId(orderId);
	}

	@Override
	public List<OrderVO> getOrderListByMemberIdx(long memberIdx) {
		return orderDAO.getOrderListByMemberIdx(memberIdx);
	}

	@Override
	public OrderVO getOrderByOrderIdAndMember(String orderId, long memberIdx) {
		return orderDAO.getOrderByOrderIdAndMember(orderId, memberIdx);
	}

	@Override
	public List<OrderDetailVO> getOrderDetailItems(long orderIdx) {
		return orderDAO.getOrderDetailItems(orderIdx);
	}

	@Override
	public int getAdminOrderTotalCnt(String status) {
		return orderDAO.getAdminOrderTotalCnt(status);
	}

	@Override
	public List<OrderVO> getAdminOrderList(int startIndexNo, int pageSize, String startJumun, String endJumun, String orderStatus) {
		return orderDAO.getAdminOrderList(startIndexNo, pageSize, startJumun, endJumun, orderStatus);
	}

	@Override
	public int setUpdateStatus(String orderId, String orderStatus) {
		return orderDAO.setUpdateStatus(orderId, orderStatus);
	}

	@Override
	public List<OrderVO> getRecentOrderList(Long memberIdx, int i) {
		return orderDAO.getRecentOrderList(memberIdx, i);
	}

	
	
	
}
