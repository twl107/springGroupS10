package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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




}
