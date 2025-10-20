package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private String userId;
	private String title;
	private String part;
	private String wDate;
	private String orderId;
	private String content;
	private String fName;
	private String fSName;
	private String reply;
	
	private int wNDate;
}
