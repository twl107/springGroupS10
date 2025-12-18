package com.spring.springGroupS10.vo;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PdsVO {
	private int idx;
	private long memberIdx;
	private String fName;
	private String fSName;
	private long fSize;
	private String part;
	private String title;
	private String content;
	private String openSw;
	private String hostIp;
	private Timestamp createdAt;
	private int downNum;
	
	private String nickName;
	private String formattedFSize;
	private List<MultipartFile> files;
	
}
