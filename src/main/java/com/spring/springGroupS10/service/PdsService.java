package com.spring.springGroupS10.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.PdsVO;

public interface PdsService {

	int getTotRecCnt(String part);

	List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	int pdsUpload(PdsVO vo, HttpServletRequest request);

	PdsVO getPdsContent(int idx);

	void setPdsDownNumCheck(int idx);

	int getPdsDelelte(int idx);

	PdsVO getPdsIdx(int idx);

	void deletedPdsFiles(String[] deleteFiles, HttpServletRequest request);

	Map<String, String> uploadNewPdsFiles(MultipartFile[] newFiles, HttpServletRequest request);

	void updatePdsVO(PdsVO vo, String[] deleteFiles, Map<String, String> newFilesMap, HttpServletRequest request);

	int pdsUpdate(PdsVO vo);


	
	
	
	
	
}
