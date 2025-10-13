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

	List<DbProductVO> getOptionList(int productIdx);

	int getOptionSame(int productIdx, String optionName);

	int setDbOptionInput(DbOptionVO vo);

	int setOptionDelete(int idx);




}
