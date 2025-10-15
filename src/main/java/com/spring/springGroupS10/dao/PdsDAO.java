package com.spring.springGroupS10.dao;

import java.util.List;

import com.spring.springGroupS10.vo.PdsVO;

public interface PdsDAO {

	int getTotRecCnt(String part);

	List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	
	
	
	
	

}
