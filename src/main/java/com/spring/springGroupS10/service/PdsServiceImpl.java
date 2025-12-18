package com.spring.springGroupS10.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
		List<String> savedServerFileNames = new ArrayList<>();
		
		try {
			List<MultipartFile> fileList = vo.getFiles();
			
			if(fileList != null && !fileList.isEmpty() && fileList.get(0).getSize() > 0) {
				
				StringBuilder oFileNames = new StringBuilder();
				StringBuilder sFileNames = new StringBuilder();			
				long fSize = 0;
				
				for(MultipartFile file : fileList) {
					String oFileName = file.getOriginalFilename();
					String sFileName = projectProvide.saveFile(file, "pds", request);
					
					savedServerFileNames.add(sFileName);
					
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
			
			return pdsDAO.pdsUpload(vo);
		} catch (Exception e) {
			System.out.println("pdsUpload 실패 : " + e.getMessage());
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
			
			if(!savedServerFileNames.isEmpty()) {
				for(String sFileName : savedServerFileNames) {
					new File(realPath + sFileName).delete();
				}
			}
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public PdsVO getPdsContent(int idx) {
		return pdsDAO.getPdsContent(idx);
	}

	@Override
	public void setPdsDownNumCheck(int idx) {
		pdsDAO.setPdsDownNumCheck(idx);
	}

	@Override
	public int getPdsDelelte(int idx) {
		return pdsDAO.getPdsDelelte(idx);
	}

	@Override
	public PdsVO getPdsIdx(int idx) {
		return pdsDAO.getPdsIdx(idx);
	}

	@Override
	public void deletedPdsFiles(String[] deleteFiles, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/data/pds/");
		for(String fSName : deleteFiles) {
			File file = new File(realPath + fSName);
			if(file.exists()) {
				file.delete();
			}
		}
	}

	@Override
	public Map<String, String> uploadNewPdsFiles(MultipartFile[] newFiles, HttpServletRequest request) {
		Map<String, String> newFilesMap = new HashMap<>();
		try {
			for(MultipartFile file : newFiles) {
				if(file.getSize() > 0) {
					String oFileName = file.getOriginalFilename();
					String sFileName = projectProvide.saveFile(file, "pds", request);
					newFilesMap.put(sFileName, oFileName);
				}
			}
		}
		catch (IOException e) {
			System.out.println("신규 파일 업로드 실패 : " + e.getMessage());
			e.printStackTrace();
		}
		return newFilesMap;
	}

	@Override
	public void updatePdsVO(PdsVO vo, String[] deleteFiles, Map<String, String> newFilesMap, HttpServletRequest request) {
		
		List<String> fNameList = new ArrayList<>(Arrays.asList(vo.getFName().split("/")));
		List<String> fSNameList = new ArrayList<>(Arrays.asList(vo.getFSName().split("/")));
		
		if(vo.getFName() != null && vo.getFName().trim().isEmpty()) {
			fNameList.addAll(Arrays.asList(vo.getFName().split("/")));
			fSNameList.addAll(Arrays.asList(vo.getFSName().split("/")));
		}
		
		if(deleteFiles != null && deleteFiles.length > 0) {
			for(String delFSName : deleteFiles) {
				int index = fSNameList.indexOf(delFSName);
				if(index != -1) {
					fSNameList.remove(index);
					fNameList.remove(index);
				}
			}
		}
		
		if(newFilesMap != null && !newFilesMap.isEmpty()) {
			for(String sFileName : newFilesMap.keySet()) {
				fSNameList.add(sFileName);
				fNameList.add(newFilesMap.get(sFileName));
			}
		}
		
		fNameList = fNameList.stream().filter(name -> !name.trim().isEmpty()).collect(Collectors.toList());
		fSNameList = fSNameList.stream().filter(name -> !name.trim().isEmpty()).collect(Collectors.toList());
		
		vo.setFName(String.join("/", fNameList));
		vo.setFSName(String.join("/", fSNameList));
		
		long totalSize = 0;
		if(!fSNameList.isEmpty()) {
			String realPath = request.getSession().getServletContext().getRealPath("resources/data/pds/");
			for(String sFileName : fSNameList) {
				File file = new File(realPath + sFileName);
				if(file.exists()) {
					totalSize += file.length();
				}
			}
		}
		vo.setFSize(totalSize);
	}

	@Override
	public int pdsUpdate(PdsVO vo) {
		return pdsDAO.pdsUpdate(vo);
	}
	
	
}
	
