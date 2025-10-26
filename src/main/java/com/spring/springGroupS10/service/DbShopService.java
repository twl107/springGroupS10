package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.DbOptionVO;
import com.spring.springGroupS10.vo.DbProductVO;

public interface DbShopService {

	List<DbProductVO> getCategoryMain();

	List<DbProductVO> getCategoryMiddle();

	DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	int setCategoryMainInput(DbProductVO vo);

	DbProductVO getCategoryMiddleOne(DbProductVO vo);

	int setCategoryMainDelete(String categoryMainCode);

	int setCategoryMiddleInput(DbProductVO vo);

	int setCategoryMiddleDelete(String categoryMiddleCode);

	DbProductVO getCategoryProductName(DbProductVO vo);

	List<DbProductVO> getCategoryMiddleName(String categoryMainCode);

	int mainImgToSubImgSave(MultipartFile file, DbProductVO vo);

	List<DbProductVO> getMiddleCategory(String mainCategory);

	List<DbProductVO> getAllMainCategory();

	List<DbProductVO> getAllMiddleCategory();

	List<DbProductVO> getDbShopList(List<String> mainCategories, List<String> middleCategories);

	DbProductVO getDbShopProduct(int idx);

	List<DbProductVO> getDbShopOption(int idx);

	DbProductVO getCategoryProductNameOne(String productName);

	DbProductVO getCategoryProductNameOneVO(DbProductVO imsiVO);

	List<DbProductVO> getCategoryProductNameAjax(String categoryMainCode, String categoryMiddleCode);

	DbProductVO getProductInfor(String productName);

	List<DbOptionVO> getOptionList(int productIdx);

	int getOptionSame(int productIdx, String optionName);

	int setDbOptionInput(DbOptionVO vo);

	int setOptionDelete(int idx);

	List<DbProductVO> getDbProductList();

	List<DbProductVO> getProductSearch(String keyword);

	DbOptionVO getDbShopOptionOne(int optionIdx);

	List<DbProductVO> getProductByMainCategory(String mainCategoryCode);

	List<String> getMiddleCategoryNamesByCodes(List<String> middleCategories);

	List<DbProductVO> getProductsByProductNames(List<String> middleCategoryNames);

	List<DbProductVO> getBestSellerProducts(int limit);

	List<DbProductVO> getRecommendedProducts(int limit);

	int updateProductRecommendation(int idx, boolean isRecommended);

	int getTotalProductCount();

	int getProductSearchTotRecCnt(String keyword);

	int getProductByMainCategoryTotRecCnt(String mainCategoryCode);

	List<DbProductVO> getProductSearchPaging(String keyword, int startIndexNo, int pageSize);

	List<DbProductVO> getProductByMainCategoryPaging(String mainCategoryCode, int startIndexNo, int pageSize);

	List<DbProductVO> getDbProductListAdmin(int startIndexNo, int pageSize);

	List<DbProductVO> getDbShopListPaging(List<String> mainCategories, List<String> middleCategories, int startIndexNo,
			int pageSize);

	int getDbShopListTotRecCnt(List<String> mainCategories, List<String> middleCategories);




}
