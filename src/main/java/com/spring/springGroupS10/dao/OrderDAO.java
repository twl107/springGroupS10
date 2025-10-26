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

	OrderVO getOrderByOrderIdAndMember(@Param("orderId") String orderId, @Param("memberIdx") long memberIdx);

	List<OrderDetailVO> getOrderDetailItems(@Param("orderIdx") long orderIdx);

	int getAdminOrderTotalCnt(@Param("status") String status);

	List<OrderVO> getAdminOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("startJumun") String startJumun, 
			@Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	int setUpdateStatus(@Param("orderId") String orderId, @Param("orderStatus") String orderStatus);

	List<OrderVO> getRecentOrderList(@Param("memberIdx") Long memberIdx, @Param("i") int i);

	int getTotRecCntAdminOrder(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	List<OrderVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("memberIdx") long memberIdx, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun,
			@Param("orderStatus") String orderStatus);

	int getMyOrdersTotRecCnt(@Param("memberIdx") int memberIdx, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	int getOrderCountByStatus(@Param("orderStatus") String orderStatus);

	long getSalesByDate(@Param("period") String period);


}
