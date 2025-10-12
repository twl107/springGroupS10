package com.spring.springGroupS10.service;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.dao.DbShopDAO;
import com.spring.springGroupS10.vo.DbProductVO;

@Service
public class DbShopServiceImpl implements DbShopService {

	@Autowired
	DbShopDAO dbShopDAO;
	
	@Autowired
	ProjectProvide projectProvide;
	

	@Override
	public List<DbProductVO> getCategoryMain() {
		return dbShopDAO.getCategoryMain();
	}

	@Override
	public List<DbProductVO> getCategoryMiddle() {
		return dbShopDAO.getCategoryMiddle();
	}

	@Override
	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName) {
		return dbShopDAO.getCategoryMainOne(categoryMainCode, categoryMainName);
	}

	@Override
	public int setCategoryMainInput(DbProductVO vo) {
		return dbShopDAO.setCategoryMainInput(vo);
	}

	@Override
	public DbProductVO getCategoryMiddleOne(DbProductVO vo) {
		return dbShopDAO.getCategoryMiddleOne(vo);
	}

	@Override
	public int setCategoryMainDelete(String categoryMainCode) {
		return dbShopDAO.setCategoryMainDelete(categoryMainCode);
	}

	@Override
	public int setCategoryMiddleInput(DbProductVO vo) {
		return dbShopDAO.setCategoryMiddleInput(vo);
	}

	@Override
	public int setCategoryMiddleDelete(String categoryMiddleCode) {
		return dbShopDAO.setCategoryMiddleDelete(categoryMiddleCode);
	}

	@Override
	public DbProductVO getCategoryProductName(DbProductVO vo) {
		return dbShopDAO.getCategoryProductName(vo);
	}

	@Override
	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode) {
		return dbShopDAO.getCategoryMiddleName(categoryMainCode);
	}

	@Override
	public int mainImgToSubImgSave(MultipartFile file, DbProductVO vo) {
		int res = 0;
		// 메인 이미지 업로드
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != null && originalFilename != "") {
				String saveFileName = projectProvide.saveFileName(originalFilename);
				
					projectProvide.writeFile(file, saveFileName, "/dbShop/product/");
					vo.setFSName(saveFileName);
			}
			else return res;
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		
		// ckeditor에서 올린 이미지 파일 처리
		String content = vo.getContent();
		if(content.indexOf("src=\"/") != -1) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
			
			Pattern pattern = Pattern.compile("src=\"/springGroupS10/data/ckeditor/([^\"]+)\"");
			Matcher matcher = pattern.matcher(content);
			
			while(matcher.find()) {
				String imgFile = matcher.group(1); // 정규식 괄호 안에 매칭된 파일명 가져옴
				
				String oriFilePath = uploadPath + "ckeditor/" + imgFile;
				String copyFilePath = uploadPath + "dbShop/product/" + imgFile;
				
				projectProvide.fileCopyCheck(oriFilePath, copyFilePath);
			}
			vo.setContent(content.replace("/data/ckeditor/", "/data/dbShop/product/"));
		}
		
		// 고유번호 idx값 만들기(상품코드 만들 때 필요)
		int maxIdx = 1;
		DbProductVO maxVO = dbShopDAO.getProductMaxIdx();
		if(maxVO != null) maxIdx = maxVO.getIdx() + 1;
		
		vo.setIdx(maxIdx);
		vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode() + maxIdx);
		res = dbShopDAO.setDbProductInput(vo);
		return res;
	}

	@Override
	public List<DbProductVO> getMiddleCategory(String mainCategory) {
		return dbShopDAO.getMiddleCategory(mainCategory);
	}

	@Override
	public List<DbProductVO> getAllMainCategory() {
		return dbShopDAO.getAllMainCategory();
	}

	@Override
	public List<DbProductVO> getAllMiddleCategory() {
		return dbShopDAO.getAllMiddleCategory();
	}

	@Override
	public List<DbProductVO> getDbShopList(List<String> mainCategories, List<String> middleCategories) {
		return dbShopDAO.getDbShopList(mainCategories, middleCategories);
	}

		
		
		
		

	
	
	
	
}
