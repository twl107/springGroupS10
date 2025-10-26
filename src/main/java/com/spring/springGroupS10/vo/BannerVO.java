package com.spring.springGroupS10.vo;

import java.util.Date;

import lombok.Data;
@Data
public class BannerVO {
	private int idx;
	private String fSName;
	private String linkUrl;
	private int displayOrder;
	private Boolean isActive;
	private Date createdAt;
}
