package com.spring.springGroupS10.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.dao.InquiryDAO;
import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	InquiryDAO inquiryDAO;
	
	@Autowired
	ProjectProvide projectProvide;
	

	@Override
	public List<InquiryVO> getInquryList(int startIndexNo, int pageSize, String part, String userId) {
		return inquiryDAO.getInquryList(startIndexNo, pageSize, part, userId);
	}

	@Override
	public int getTotRecCnt(String part, String userId) {
		return inquiryDAO.getTotRecCnt(part, userId);
	}

	@Override
	public void setInquiryInput(MultipartFile file, InquiryVO vo, HttpServletRequest request) {
		try {
			String originalFileName = file.getOriginalFilename();
			
			if(originalFileName != null && !originalFileName.equals("")) {
				String saveFileName = projectProvide.saveFile(file, "inquiry", request);
				
				vo.setFName(originalFileName);
				vo.setFSName(saveFileName);
			}
			inquiryDAO.setInquiryInput(file, vo);
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public InquiryVO getInquiryContent(int idx) {
		return inquiryDAO.getInquiryContent(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReply(int idx) {
		return inquiryDAO.getInquiryReply(idx);
	}

	@Override
	public int setInquiryUpdate(MultipartFile file, InquiryVO vo, HttpServletRequest request) {
		int res = 0;
		
		try {
			String originalFileName = file.getOriginalFilename();
			if(originalFileName != null && !originalFileName.equals("")) {
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
				File deleteFile = new File(realPath + vo.getFSName());
				if(deleteFile.exists()) deleteFile.delete();
				
				String saveFileName = projectProvide.saveFile(file, "inquiry", request);
				vo.setFName(originalFileName);
				vo.setFSName(saveFileName);
			}
			else {
				vo.setFName(vo.getFName());
				vo.setFSName(vo.getFSName());
			}
			res = inquiryDAO.setInquiryUpdate(vo);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return res; 
	}

	@Override
	public int setInquiryDelete(int idx, String fSName) {
		if(fSName != null && !fSName.equals("")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("resources/data/inquiry/");
			File deleteFile = new File(realPath + fSName);
			if(deleteFile.exists()) deleteFile.delete();
		}
		return inquiryDAO.setInquiryDelete(idx);
	}

	@Override
	public int getTotRecCntAdmin(String part) {
		return inquiryDAO.getTotRecCntAdmin(part);
	}

	@Override
	public List<InquiryVO> getRecntInquiryList(String userId, int i) {
		return inquiryDAO.getRecntInquiryList(userId, i);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}
