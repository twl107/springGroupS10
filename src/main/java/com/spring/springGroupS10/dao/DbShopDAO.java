package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.vo.DbProductVO;

public interface DbShopDAO {

	List<DbProductVO> getCategoryMain();

	List<DbProductVO> getCategoryMiddle();

	DbProductVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	int setCategoryMainInput(@Param("vo") DbProductVO vo);

	DbProductVO getCategoryMiddleOne(@Param("vo") DbProductVO vo);

	int setCategoryMainDelete(@Param("categoryMainCode") String categoryMainCode);

	int setCategoryMiddleInput(@Param("vo") DbProductVO vo);

	int setCategoryMiddleDelete(@Param("categoryMiddleCode") String categoryMiddleCode);

	DbProductVO getCategoryProductName(@Param("vo") DbProductVO vo);

	List<DbProductVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	DbProductVO getProductMaxIdx();

	int setDbProductInput(@Param("vo") DbProductVO vo);

	List<DbProductVO> getMiddleCategory(@Param("mainCategory") String mainCategory);

	List<DbProductVO> getAllMainCategory();

	List<DbProductVO> getAllMiddleCategory();

	List<DbProductVO> getDbShopList(@Param("mainCategories") List<String> mainCategories, @Param("middleCategories") List<String> middleCategories);





	
	
	
	
	
	
	
	
	
	
}
