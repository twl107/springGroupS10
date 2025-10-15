package com.spring.springGroupS10.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.spring.springGroupS10.vo.PdsVO;

public interface PdsService {

	int getTotRecCnt(String part);

	List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	int pdsUpload(PdsVO vo, HttpServletRequest request);

	
	
	
	
	
}
