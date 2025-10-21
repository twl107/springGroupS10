package com.spring.springGroupS10.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;
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
	
	@GetMapping("/inquiry/adInquiryList")
	public String adInquiryListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize
		) {
		PageVO pageVO = new PageVO();
		pageVO.setPart(part);
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("adminInquiry");
		pageVO = pagination.pagination(pageVO);
		
		ArrayList<InquiryVO> vos = adminService.getInquiryListAdmin(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		
		return "admin/inquiry/adInquiryList";
	}
	
	@GetMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyGet(Model model, int idx,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name = "replySw", defaultValue = "", required = false) String replySw
		) {
		
		InquiryVO vo = adminService.getInquiryContent(idx);
		InquiryReplyVO reVO = adminService.getInquiryReplyContent(idx);
		
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("replySw", replySw);
		
		return "admin/inquiry/adInquiryReply";
	}
	
	// 관리자 답변 저장
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyInput")
	public int adInquiryReplyInputPost(InquiryReplyVO vo) {
		int res = 0;
		res = adminService.setInquiryInputAdmin(vo);
		if(res != 0) adminService.setInquiryUpdateAdmin(vo.getInquiryIdx());
		
		return res;
	}
	
	// 관리자 답변 수정
	@PostMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyUpdatePost(InquiryReplyVO reVO) {
		int res = adminService.setInquiryReplyUpdate(reVO);	// 관리자가 답변글을 수정했을 때 처리 루틴
		
		System.out.println("res : " + res);
		if(res != 0) return "redirect:/message/adInquiryReplyUpdateOk?idx="+reVO.getInquiryIdx();
		return "redirect:/message/adInquiryReplyUpdateNo?idx="+reVO.getInquiryIdx();
	}
	
	// 답변글만 삭제하기(답변글을 삭제처리하면 원본글의 '상태'는 '답변대기중'으로 수정해준다.
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyDelete")
	public int adInquiryReplyDeletePost(int inquiryIdx, int reIdx) {
		adminService.setAdInquiryReplyDelete(reIdx);
		return adminService.setInquiryReplyStatusUpdate(inquiryIdx);
	}
	
	// 관리자 원본글과 답변글 삭제처리(답변글이 있을경우는 답변글 먼저 삭제후 원본글을 삭제처리한다.)
	@Transactional
	@RequestMapping(value="/inquiry/adInquiryDelete", method = RequestMethod.GET)
	public String adInquiryDeleteGet(Model model, int idx, String fSName, int reIdx, int pag) {
		//adminService.setAdInquiryReplyDelete(reIdx);	// 관리자가 현재글을 삭제했을때 먼저 답변글을 삭제처리해준다.
		adminService.setAdInquiryDelete(idx, fSName, reIdx); // 답변글 삭제처리가 끝나면 원본글을 삭제처리해준다. (답변글삭제와 원본글 삭제를 동시에 처리한다.)
		model.addAttribute("pag", pag);
		return "redirect:/message/adInquiryDeleteOk";
	}
	
	
	
	
	
	
	
	
	
}
