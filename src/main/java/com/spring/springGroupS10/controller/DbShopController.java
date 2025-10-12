package com.spring.springGroupS10.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.service.DbShopService;
import com.spring.springGroupS10.vo.DbProductVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {
	
	@Autowired
	DbShopService dbShopService;
	
	
	
	
	// 상품 카테고리 등록폼/리스트 출력
	@GetMapping("/dbCategory")
	public String adminMainGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();			// 대분류 리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();	// 중분류 리스트
		
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);
		
		return "admin/dbShop/dbCategory";
	}
	
	// 대분류 등록하기
	@ResponseBody
	@PostMapping("/categoryMainInput")
	public int categoryMainInputPost(DbProductVO vo) {
		int res = 0;
		// 기존에 생성된 대분류명이 있는지 체크
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMainInput(vo);
		return res;
	}
	
	// 대분류 삭제하기
	@ResponseBody
	@PostMapping("/categoryMainDelete")
	public int categoryMainDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);
		if(middleVO != null) return res;
		
		res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());
		return res;
	}
	
	// 중분류 등록하기
	@ResponseBody
	@PostMapping("/categoryMiddleInput")
	public int categoryMiddleInputPost(DbProductVO vo) {
		int res = 0;
		// 중분류 중복체크
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMiddleInput(vo);
		return res;
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@PostMapping("/categoryMiddleDelete")
	public int categoryMiddleDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO productVO = dbShopService.getCategoryProductName(vo);
		if(productVO != null) return 0;
		
		res = dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode());
		return res;
	}
	
	// 대분류 선택하면서 중분류항목 가져오기
	@ResponseBody
	@PostMapping("/categoryMiddleName")
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}
	
	// 상품 등록 폼보기
	@GetMapping("/dbProduct")
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain(); 
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}
	
	// 상품 등록 처리
	@PostMapping("/dbProduct")
	public String dbProductPost(MultipartFile file, HttpServletRequest request, DbProductVO vo) {
		int res = dbShopService.mainImgToSubImgSave(file, vo);
		
		if(res != 0) return "redirect:/message/dbProductInputOk";
		return "redirect:/message/dbProductInputNo";
	}
	
	// 관리자페이지 상품리스트 보기
	@GetMapping("/dbShopList")
	public String dbShopListGet(Model model,
	    // 여러 개의 파라미터를 받기 위해 String[] 또는 List<String> 타입으로 변경합니다.
	    @RequestParam(name = "mainCategory", required = false) List<String> mainCategories,
	    @RequestParam(name = "middleCategory", required = false) List<String> middleCategories
	  ) {

	  // 1. [항상 실행] 모든 대분류/중분류 목록을 가져와 메뉴를 구성합니다.
	  List<DbProductVO> mainCategoryVOS = dbShopService.getAllMainCategory();
	  List<DbProductVO> middleCategoryVOS = dbShopService.getAllMiddleCategory(); // 모든 중분류를 가져오는 서비스 메소드
	  model.addAttribute("mainCategoryVOS", mainCategoryVOS);
	  model.addAttribute("middleCategoryVOS", middleCategoryVOS);

	  // 2. [항상 실행] 선택된 카테고리 목록을 다시 뷰로 보내 체크박스 상태를 유지합니다.
	  model.addAttribute("selectedMainCodes", mainCategories);
	  model.addAttribute("selectedMiddleCodes", middleCategories);
	  
	  // 3. [핵심] 선택된 카테고리 목록에 해당하는 상품 목록을 가져옵니다.
	  List<DbProductVO> productVOS = dbShopService.getDbShopList(mainCategories, middleCategories);
	  model.addAttribute("productVOS", productVOS);
	  
	  return "admin/dbShop/dbShopList";
	}
	
	
	
	
	
}
