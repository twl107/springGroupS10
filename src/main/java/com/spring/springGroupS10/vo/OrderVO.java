package com.spring.springGroupS10.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {

	private long idx;
	private String orderId;
	private long memberIdx;
	private Date orderDate;
	private int totalPrice;
	
	// 배송지 정보
	private String recipientName;
	private String recipientTel;
	private String recipientPostCode;
	private String recipientAddress1;
	private String recipientAddress2;
	private String shippingMessage;
	
	private String orderStatus;
	private String imp_uid;
	private String mainProductName;
	private int itemCount;
	
	private List<OrderDetailVO> orderDetails = new ArrayList<OrderDetailVO>();
}
