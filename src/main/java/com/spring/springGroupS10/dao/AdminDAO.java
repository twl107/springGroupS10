package com.spring.springGroupS10.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

public interface AdminDAO {

	ArrayList<InquiryVO> getInquiryListAdmin(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	InquiryVO getInquiryContent(@Param("idx") int idx);

	InquiryReplyVO getInquiryReplyContent(@Param("idx") int idx);

	int setInquiryInputAdmin(@Param("vo") InquiryReplyVO vo);

	void setInquiryUpdateAdmin(@Param("inquiryIdx") int inquiryIdx);

	int setInquiryReplyUpdate(@Param("reVO") InquiryReplyVO reVO);

	
	
	
}
