package com.spring.springGroupS10.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.NoticeVO;

public interface NoticeService {

	int getTotRecCnt();

	List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	NoticeVO getNoticeContent(int idx);

	int setNoticeInput(NoticeVO vo);

	int setNoticeUpdate(MultipartFile file, NoticeVO vo, HttpServletRequest request);

	int setNoticeDelete(int idx);
	
	NoticeVO readNoticeContent(int idx);

	int noticeImgSave(MultipartFile file, NoticeVO vo, Long sMemberIdx);


}
