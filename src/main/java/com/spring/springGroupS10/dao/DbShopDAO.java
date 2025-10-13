package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.DbOptionVO;
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

	DbProductVO getDbShopProduct(@Param("idx") int idx);

	List<DbProductVO> getDbShopOption(@Param("idx") int idx);

	DbProductVO getCategoryProductNameOne(@Param("productName") String productName);

	DbProductVO getCategoryProductNameOneVO(@Param("vo") DbProductVO vo);

	List<DbProductVO> getCategoryProductNameAjax(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	DbProductVO getProductInfor(@Param("productName") String productName);

	List<DbProductVO> getOptionList(@Param("productIdx") int productIdx);

	int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	int setDbOptionInput(@Param("vo") DbOptionVO vo);

	int setOptionDelete(@Param("idx") int idx);





	
	
	
	
	
	
	
	
	
	
}
