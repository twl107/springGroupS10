package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	// 기본 정보
	private long idx;
	private String userId;
	private String password;
	private String nickName;
	private String name;
	private String email;
	private String tel;

	// 주소 정보
	private String postCode;
	private String address1;
	private String address2;
	private String fullAddress;

	// 개인 정보
	private String gender;
	private String birthday;

	// 쇼핑몰 관련 정보
	private int point;
	private int level;
	private int todayCnt;
	private int visitCnt;

	// 상태 및 일시 정보
	private boolean isDeleted;
	private String deletedAt;
	private String createdAt;
	private String lastLoginAt;
	
	private int deleteDiff;
	private long kakaoId;
	
}

