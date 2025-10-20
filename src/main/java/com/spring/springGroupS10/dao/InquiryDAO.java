package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

public interface InquiryDAO {

	List<InquiryVO> getInquryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("userId") String userId);

	int getTotRecCnt(@Param("part") String part, @Param("userId") String userId);

	void setInquiryInput(@Param("file") MultipartFile file, @Param("vo") InquiryVO vo);

	InquiryVO getInquiryContent(@Param("idx") int idx);

	InquiryReplyVO getInquiryReply(@Param("idx") int idx);

	int setInquiryUpdate(@Param("vo") InquiryVO vo);

	int setInquiryDelete(@Param("idx") int idx);

	int getTotRecCntAdmin(@Param("part") String part);


}
