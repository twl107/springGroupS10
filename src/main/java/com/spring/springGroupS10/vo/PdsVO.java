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
	
	private String nickName;				// member 테이블과 JOIN하여 가져올 작성자 닉네임
	private String formattedFSize;	// fSize를 가공하여 "KB", "MB" 등으로 변환한 문자열
	private List<MultipartFile> files;	// 파일 업로드 시 Controller에서 Service로 파일을 전달하기 위한 임시 필드 (DB와는 무관)
	
}
