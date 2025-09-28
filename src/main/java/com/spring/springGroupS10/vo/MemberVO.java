package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	// 기본 정보
	private long memberId;
	private String userid;
	private String password;
	private String nickname;
	private String name;
	private String email;
	private String tel;

	// 주소 정보
	private String postcode;
	private String address1;
	private String address2;

	// 개인 정보
	private String gender;
	private String birthday;

	// 쇼핑몰 관련 정보
	private int point;
	private int level;
	private String role;
	
	// 상태 및 일시 정보
	private boolean isDeleted;
	private String deletedAt;   // DATETIME 타입을 String으로 처리
	private String createdAt;
	private String lastLoginAt;
	
}