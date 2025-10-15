package com.spring.springGroupS10.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.dao.PdsDAO;
import com.spring.springGroupS10.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {

	@Autowired
	PdsDAO pdsDAO;

	
	@Override
	public int getTotRecCnt(String part) {
		return pdsDAO.getTotRecCnt(part);
	}


	@Override
	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		return pdsDAO.getPdsList(startIndexNo, pageSize, part);
	}


	@Override
	public int pdsUpload(PdsVO vo, HttpServletRequest request) {
		
		List<MultipartFile> fileList = vo.getFiles();
		
		// 리스트가 비어있지 않았을 경우 실행
		if(fileList != null && !fileList.isEmpty() && fileList.get(0).getSize() > 0) {
			
			StringBuilder originalFileName = new StringBuilder();
			StringBuilder serverFileName = new StringBuilder();			
			long totalFileSize = 0;
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
			File realPathFile = new File(realPath);
			
			if(!realPathFile.exists()) {
				realPathFile.mkdirs();	// 경로에 해당하는 폴더가 없을 경우 폴더생성
			}
			
			for(MultipartFile file : fileList) {
				
			}
			
		}
		
		return 0;
	}


	
	
	
}
