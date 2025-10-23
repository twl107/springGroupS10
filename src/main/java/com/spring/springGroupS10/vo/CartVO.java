package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private int idx;
	private long memberIdx;
	private int productIdx;
	private Integer optionIdx;
	private int quantity;
	private String addDate;
	
	private String productName;
	private int mainPrice;
	private String fSName;
	
	private String optionName;
	private int optionPrice;
	
	private int totalPrice;
	
}
