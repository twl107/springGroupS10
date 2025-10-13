package com.spring.springGroupS10.vo;

import lombok.Data;

@Data
public class CartVO {
	
	// cart 테이블의 기본 컬럼
	private int idx;
	private long memberIdx;
	private int productIdx;
	private Integer optionIdx; // NULL 값을 허용해야 하므로 int 대신 Integer 타입을 사용
	private int quantity;
	private String addDate;
	
	// --------------------------------------------------------------------
	// JOIN을 통해 다른 테이블에서 가져올 추가 정보들
	// --------------------------------------------------------------------
	
	// dbProduct 테이블에서 가져올 정보
	private String productName; // 상품명
	private int mainPrice;      // 상품 기본 가격
	private String fSName;      // 상품 썸네일 이미지 파일명
	
	// dbOption 테이블에서 가져올 정보
	private String optionName;  // 옵션명
	private int optionPrice;    // 옵션 가격
	
	// --------------------------------------------------------------------
	// 계산이 필요한 필드 (Service 또는 Mapper에서 계산 후 담아줄 필드)
	// --------------------------------------------------------------------
	private int totalPrice; // 최종 가격 = (상품 기본가 + 옵션가) * 수량
	
}
