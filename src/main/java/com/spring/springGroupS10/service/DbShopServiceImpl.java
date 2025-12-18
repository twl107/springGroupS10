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
import com.spring.springGroupS10.vo.DbOptionVO;
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
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		try {
			if(file != null && !file.isEmpty()) {
				String saveFileName = projectProvide.saveFile(file, "dbShop/product", request);
				vo.setFSName(saveFileName);
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		
		String content = vo.getContent();
		if(content != null && content.indexOf("src=\"/") != -1) {
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
			
			Pattern pattern = Pattern.compile("src=\"/springGroupS10/data/ckeditor/([^\"]+)\"");
			Matcher matcher = pattern.matcher(content);
			
			while(matcher.find()) {
				String imgFile = matcher.group(1);
				
				String oriFilePath = uploadPath + "ckeditor/" + imgFile;
				String copyFilePath = uploadPath + "dbShop/product/" + imgFile;
				
				projectProvide.fileCopyCheck(oriFilePath, copyFilePath);
			}
			vo.setContent(content.replace("/data/ckeditor/", "/data/dbShop/product/"));
		}
		
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

	@Override
	public DbProductVO getDbShopProduct(int idx) {
		return dbShopDAO.getDbShopProduct(idx);
	}

	@Override
	public List<DbProductVO> getDbShopOption(int idx) {
		return dbShopDAO.getDbShopOption(idx);
	}

	@Override
	public DbProductVO getCategoryProductNameOne(String productName) {
		return dbShopDAO.getCategoryProductNameOne(productName);
	}

	@Override
	public DbProductVO getCategoryProductNameOneVO(DbProductVO imsiVO) {
		return dbShopDAO.getCategoryProductNameOneVO(imsiVO);
	}

	@Override
	public List<DbProductVO> getCategoryProductNameAjax(String categoryMainCode, String categoryMiddleCode) {
		return dbShopDAO.getCategoryProductNameAjax(categoryMainCode, categoryMiddleCode);
	}

	@Override
	public DbProductVO getProductInfor(String productName) {
		return dbShopDAO.getProductInfor(productName);
	}

	@Override
	public List<DbOptionVO> getOptionList(int productIdx) {
		return dbShopDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return dbShopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public int setDbOptionInput(DbOptionVO vo) {
		return dbShopDAO.setDbOptionInput(vo);
	}

	@Override
	public int setOptionDelete(int idx) {
		return dbShopDAO.setOptionDelete(idx);
	}

	@Override
	public List<DbProductVO> getDbProductList() {
		return dbShopDAO.getDbProductList();
	}

	@Override
	public List<DbProductVO> getProductSearch(String keyword) {
		return dbShopDAO.getProductSearch(keyword);
	}

	@Override
	public DbOptionVO getDbShopOptionOne(int optionIdx) {
		return dbShopDAO.getDbShopOptionOne(optionIdx);
	}

	@Override
	public List<DbProductVO> getProductByMainCategory(String mainCategoryCode) {
		return dbShopDAO.getProductByMainCategory(mainCategoryCode);
	}

	@Override
	public List<String> getMiddleCategoryNamesByCodes(List<String> middleCategories) {
		return dbShopDAO.getMiddleCategoryNamesByCodes(middleCategories);
	}

	@Override
	public List<DbProductVO> getProductsByProductNames(List<String> middleCategoryNames) {
		return dbShopDAO.getProductsByProductNames(middleCategoryNames);
	}

	@Override
	public List<DbProductVO> getBestSellerProducts(int limit) {
		return dbShopDAO.getBestSellerProducts(limit);
	}

	@Override
	public List<DbProductVO> getRecommendedProducts(int limit) {
		return dbShopDAO.getRecommendedProducts(limit);
	}

	@Override
	public int updateProductRecommendation(int idx, boolean isRecommended) {
		return dbShopDAO.updateProductRecommendation(idx, isRecommended);
	}

	@Override
	public int getTotalProductCount() {
		return dbShopDAO.getTotalProductCount();
	}

	@Override
	public int getProductSearchTotRecCnt(String keyword) {
		return dbShopDAO.getProductSearchTotRecCnt(keyword);
	}

	@Override
	public int getProductByMainCategoryTotRecCnt(String mainCategoryCode) {
		return dbShopDAO.getProductByMainCategoryTotRecCnt(mainCategoryCode);
	}

	@Override
	public List<DbProductVO> getProductSearchPaging(String keyword, int startIndexNo, int pageSize) {
		return dbShopDAO.getProductSearchPaging(keyword, startIndexNo, pageSize);
	}

	@Override
	public List<DbProductVO> getProductByMainCategoryPaging(String mainCategoryCode, int startIndexNo, int pageSize) {
		return dbShopDAO.getProductByMainCategoryPaging(mainCategoryCode, startIndexNo, pageSize);
	}

	@Override
	public List<DbProductVO> getDbProductListAdmin(int startIndexNo, int pageSize) {
		return dbShopDAO.getDbProductListAdmin(startIndexNo, pageSize);
	}

	@Override
	public List<DbProductVO> getDbShopListPaging(List<String> mainCategories, List<String> middleCategories, int startIndexNo, int pageSize) {
		return dbShopDAO.getDbShopListPaging(mainCategories, middleCategories, startIndexNo, pageSize);
	}

	@Override
	public int getDbShopListTotRecCnt(List<String> mainCategories, List<String> middleCategories) {
		return dbShopDAO.getDbShopListTotRecCnt(mainCategories, middleCategories);
	}
	
}
