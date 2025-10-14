package com.spring.springGroupS10.vo;

import java.util.List;

import lombok.Data;

@Data
public class OrderVO {

	// orders 테이블의 기본 컬럼
	private long idx;
	private String orderId;
	private long memberIdx;
	private String orderDate;
	private int totalPrice;
	
	// 배송지 정보
	private String recipientName;
	private String recipientTel;
	private String recipientPostCode;
	private String recipientAddress1;
	private String recipientAddress2;
	
	private String orderStatus;

	private List<OrderDetailVO> orderDetails;
}
