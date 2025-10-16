package com.spring.springGroupS10.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.dao.PdsDAO;
import com.spring.springGroupS10.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {

	@Autowired
	PdsDAO pdsDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	
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
		
		try {
		List<MultipartFile> fileList = vo.getFiles();
		
		// 리스트가 비어있지 않았을 경우 실행
		if(fileList != null && !fileList.isEmpty() && fileList.get(0).getSize() > 0) {
			
			StringBuilder oFileNames = new StringBuilder();
			StringBuilder sFileNames = new StringBuilder();			
			long fSize = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName;
					sFileName = projectProvide.saveFile(file, "pds", request);
				
				oFileNames.append(oFileName).append("/");
				sFileNames.append(sFileName).append("/");
				fSize += file.getSize();
			}
			
			oFileNames.setLength(oFileNames.length() -1);
			sFileNames.setLength(sFileNames.length() -1);
			
			vo.setFName(oFileNames.toString());
			vo.setFSName(sFileNames.toString());
			vo.setFSize(fSize);
		}
		System.out.println("vo" + vo);
		return pdsDAO.pdsUpload(vo);
		} catch (IOException e) {
				e.printStackTrace();
				return 0;
		}
	}


	@Override
	public PdsVO getPdsContent(int idx) {
		return pdsDAO.getPdsContent(idx);
	}
	
	
	
	
	
}
	
