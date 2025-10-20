package com.spring.springGroupS10.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

public interface InquiryService {

	List<InquiryVO> getInquryList(int startIndexNo, int pageSize, String part, String userId);

	int getTotRecCnt(String part, String userId);

	void setInquiryInput(MultipartFile file, InquiryVO vo, HttpServletRequest request);

	InquiryVO getInquiryContent(int idx);

	InquiryReplyVO getInquiryReply(int idx);

	int setInquiryUpdate(MultipartFile file, InquiryVO vo, HttpServletRequest request);

	int setInquiryDelete(int idx, String fSName);

	int getTotRecCntAdmin(String part);

}
