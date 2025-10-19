package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.NoticeVO;

public interface NoticeService {

	int getTotRecCnt();

	List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	NoticeVO getNoticeContent(int idx);

	int setNoticeInput(NoticeVO vo);

	int setNoticeUpdate(NoticeVO vo);

	int setNoticeDelete(int idx);
	
	NoticeVO readNoticeContent(int idx);

}
