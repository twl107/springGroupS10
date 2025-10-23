package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.NoticeVO;

public interface NoticeDAO {

	int getTotRecCnt();

	List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	NoticeVO getNoticeContent(@Param("idx") int idx);

	int setNoticeInput(@Param("vo") NoticeVO vo);

	int setNoticeUpdate(@Param("vo") NoticeVO vo);

	int setNoticeDelete(@Param("idx") int idx);
	
	int setViewCntUpdate(@Param("idx") int idx);



}
