package com.spring.springGroupS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	
	
	
	
	
	
	
	
}
