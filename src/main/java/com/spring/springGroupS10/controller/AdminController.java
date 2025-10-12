package com.spring.springGroupS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.MemberVO;
import com.spring.springGroupS10.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
	
	
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
  public String adminMemberListGet(Model model, PageVO pageVO,
      @RequestParam(name="level", defaultValue="99", required=false) int level) {
    
    pageVO.setLevel(level); // 파라미터로 받은 level 값을 pageVO에 설정하여 기본값을 보장
    pageVO.setSection("member");
    pageVO = pagination.pagination(pageVO);
    
    List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getLevel());
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    
    return "admin/member/adminMemberList";
  }
	
  // AJAX를 통한 회원 등급 변경 처리
  @ResponseBody
  @PostMapping("/member/updateLevel")
  public int memberUpdateLevelPost(	int idx, int level) {
    return memberService.updateMemberLevel(idx, level);
  }
	
	
	
	
	
	
}
