package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int idx;
	private long memberIdx;
	private String title;
	private String content;
	private int viewCnt;
	private String wDate;
	
	private String nickName;
}
