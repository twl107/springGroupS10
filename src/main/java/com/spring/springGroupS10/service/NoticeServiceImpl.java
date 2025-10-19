package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.dao.NoticeDAO;
import com.spring.springGroupS10.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;

	@Override
	public int getTotRecCnt() {
		return noticeDAO.getTotRecCnt();
	}

	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return noticeDAO.getNoticeList(startIndexNo, pageSize);
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return noticeDAO.getNoticeContent(idx);
	}
	
	@Override
	public int setNoticeInput(NoticeVO vo) {
		return noticeDAO.setNoticeInput(vo);
	}
	
	@Override
	public int setNoticeUpdate(NoticeVO vo) {
		return noticeDAO.setNoticeUpdate(vo);
	}
	
	@Override
	public int setNoticeDelete(int idx) {
		return noticeDAO.setNoticeDelete(idx);
	}
	
	@Override
	public NoticeVO readNoticeContent(int idx) {
		// 1. 조회수를 1 증가시킵니다.
		noticeDAO.setViewCntUpdate(idx);
		
		// 2. 증가된 조회수가 반영된 게시물 정보를 가져옵니다.
		return noticeDAO.getNoticeContent(idx);
	}
	
	
	
	
	
	
	
	
	
	
	
}
