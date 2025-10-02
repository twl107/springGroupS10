package com.spring.springGroupS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "/admin/adminMain";
	}
	
	@GetMapping("/adminLeft")
	public String adminLeftGet() {
		return "/admin/adminLeft";
	}
	
	@GetMapping("/adminContent")
	public String adminContentGet() {
		return "/admin/adminContent";
	}
	
	// 관리자 회원리스트 조회
	@GetMapping("/member/adminMemberList")
	public String adminMemberListGet(Model model) {
		List<MemberVO> vos = memberService.getMemberList();
		
		model.addAttribute("vos", vos);
		
		System.out.println("vos" + vos);
		return "admin/member/adminMemberList";
	}
	
	
	
	
	
	
	
	
}
