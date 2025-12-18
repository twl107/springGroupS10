package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	private long idx;
	private String userId;
	private String password;
	private String nickName;
	private String name;
	private String email;
	private String tel;

	private String postCode;
	private String address1;
	private String address2;
	private String fullAddress;

	private String gender;
	private String birthday;

	private int point;
	private int level;
	private int todayCnt;
	private int visitCnt;

	private boolean isDeleted;
	private String deletedAt;
	private String createdAt;
	private String lastLoginAt;
	
	private int deleteDiff;
	private Long kakaoId;
	
}

