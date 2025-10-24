package com.spring.springGroupS10.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.service.InquiryService;
import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;
import com.spring.springGroupS10.vo.PageVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	Pagination pagination;
	
	
	@GetMapping("/inquiryList")
	public String inquryListGet(Model model, HttpSession session, PageVO pageVO,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part
		) {
		String userId = (String) session.getAttribute("sUserId");
		Integer level = (Integer) session.getAttribute("sLevel");
		if(level != null && level == 0) userId = "admin";
		
		pageVO.setSection("inquiry");
		pageVO.setPart(part);
		pageVO.setSearchString(userId);
		pageVO = pagination.pagination(pageVO);
		List<InquiryVO> vos = inquiryService.getInquryList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, userId);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		
		return "inquiry/inquiryList";
	}
	
	@GetMapping("/inquiryInput")
	public String inquiryInputGet(Model model, int pag) {
		model.addAttribute("pag", pag);
		return "inquiry/inquiryInput";
	}
	
	@PostMapping("/inquiryInput")
	public String inquiryInputPost(MultipartFile file, InquiryVO vo, HttpServletRequest request) {
		inquiryService.setInquiryInput(file, vo, request);
		
		return "redirect:/message/inquiryInputOk";
	}
	
	@GetMapping("/inquiryContent")
	public String inquiryContentGet(Model model, int idx, PageVO pageVO) {
		InquiryVO vo = inquiryService.getInquiryContent(idx);
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pageVO", pageVO);
		
		return "inquiry/inquiryContent";
	}
	
	@GetMapping("/inquiryUpdate")
	public String inquiryUpdateGet(Model model, int idx, 
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag
		) {
		InquiryVO vo = inquiryService.getInquiryContent(idx);
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		model.addAttribute("idx", idx);
		
		return "inquiry/inquiryUpdate";
	}
	
	@PostMapping("/inquiryUpdate")
	public String inquiryUpdatePost(Model model, MultipartFile file, InquiryVO vo, HttpServletRequest request,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag
		) {
		int res = inquiryService.setInquiryUpdate(file, vo, request);
		model.addAttribute("pag", pag);
		model.addAttribute("idx", vo.getIdx());
		if(res != 0) return "redirect:/message/inquiryUpdateOk";
		else return "redirect:/message/inquiryUpdateNo";
	}
	
	@GetMapping("/inquiryDelete")
	public String inquiryDeleteGet(Model model, int idx,
			@RequestParam(name = "fSName", defaultValue = "", required = false) String fSName
		) {
		int res = inquiryService.setInquiryDelete(idx, fSName);
		if(res != 0) return "redirect:/message/inquiryDeleteOk";
		else return "redirect:/message/inquiryDeleteNo?idx="+idx;
	}
	
	
	
	
	
	
	
	
}
