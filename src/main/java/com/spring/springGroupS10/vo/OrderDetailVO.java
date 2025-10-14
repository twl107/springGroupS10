package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class OrderDetailVO {
	private long idx;
	private long orderIdx;
	private int productIdx;
	private Integer optionIdx;
	private int quantity;
	private int price;
	private String itemStatus;
	
	private String productName;
	private String optionName;
	private String fSName;
	
}
