package com.spring.springGroupS10.service;

import java.util.ArrayList;

import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

public interface AdminService {

	ArrayList<InquiryVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part);

	InquiryVO getInquiryContent(int idx);

	InquiryReplyVO getInquiryReplyContent(int idx);

	int setInquiryInputAdmin(InquiryReplyVO vo);

	void setInquiryUpdateAdmin(int inquiryIdx);

	int setInquiryReplyUpdate(InquiryReplyVO reVO);

	void setAdInquiryReplyDelete(int reIdx);

	int setInquiryReplyStatusUpdate(int inquiryIdx);

	void setAdInquiryDelete(int idx, String fSName, int reIdx);

	
	
	
	
	
}
