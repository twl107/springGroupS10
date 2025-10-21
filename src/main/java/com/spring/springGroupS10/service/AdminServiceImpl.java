package com.spring.springGroupS10.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.dao.AdminDAO;
import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<InquiryVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part) {
		return adminDAO.getInquiryListAdmin(startIndexNo, pageSize, part);
	}

	@Override
	public InquiryVO getInquiryContent(int idx) {
		return adminDAO.getInquiryContent(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReplyContent(int idx) {
		return adminDAO.getInquiryReplyContent(idx);
	}

	@Override
	public int setInquiryInputAdmin(InquiryReplyVO vo) {
		return adminDAO.setInquiryInputAdmin(vo);
	}

	@Override
	public void setInquiryUpdateAdmin(int inquiryIdx) {
		adminDAO.setInquiryUpdateAdmin(inquiryIdx);
	}

	@Override
	public int setInquiryReplyUpdate(InquiryReplyVO reVO) {
		return adminDAO.setInquiryReplyUpdate(reVO);
	}

	@Override
	public void setAdInquiryReplyDelete(int reIdx) {
		adminDAO.setAdInquiryReplyDelete(reIdx);
	}

	@Override
	public int setInquiryReplyStatusUpdate(int inquiryIdx) {
		return adminDAO.setInquiryReplyStatusUpdate(inquiryIdx);
	}

	@Override
	public void setAdInquiryDelete(int idx, String fSName, int reIdx) {
		adminDAO.setAdInquiryDelete(idx, fSName, reIdx);
	}
	
	
	
	
	
	
	
	
}
