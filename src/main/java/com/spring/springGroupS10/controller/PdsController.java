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

import com.spring.springGroupS10.common.Pagination;import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.PdsService;
import com.spring.springGroupS10.vo.MemberVO;
import com.spring.springGroupS10.vo.PageVO;
import com.spring.springGroupS10.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	ProjectProvide projectProvide;
	
	
	
	@GetMapping("/pdsList")
	public String pdsListGet(Model model, PageVO pageVO) {
		pageVO.setSection("pds");
		pageVO = pagination.pagination(pageVO);
		
		List<PdsVO> vos = pdsService.getPdsList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getPart());
		
		for(PdsVO vo : vos) {
			vo.setFormattedFSize(projectProvide.formatFileSize(vo.getFSize()));
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "pds/pdsList";
	}
	
	@GetMapping("/pdsForm")
	public String pdsFormGet() {
		return "pds/pdsForm";
	}
	
	@PostMapping("/pdsUpload")
	public String pdsUploadPost(PdsVO vo, HttpSession session, HttpServletRequest request) {
		String sUserId = (String) session.getAttribute("sUserId");
		if(sUserId == null) return "redirect:/member/memberLogin";
		
		MemberVO memberVO = memberService.getMemberByUserId(sUserId);
		vo.setMemberIdx(memberVO.getIdx());
		vo.setHostIp(request.getRemoteAddr());
		
		int res = pdsService.pdsUpload(vo, request);
		
		if(res != 0) return "redirect:/message/pdsUploadOk";
		else return "redirect:/message/pdsUploadNo";
	}
	
	@GetMapping("/pdsContent")
	public String pdsContentGet(Model model,
			@RequestParam(name = "idx", defaultValue = "0") int idx
		) {
		
		// 1. idx로 상세 정보를 DB에서 가져옵니다.
		PdsVO vo = pdsService.getPdsContent(idx);
		
		if(vo != null) {
			vo.setFormattedFSize(projectProvide.formatFileSize(vo.getFSize()));
		}
		
		// 2. '/'로 묶인 파일명들을 분리해서 List로 만듦
		if(vo != null && vo.getFName() != null) {
			String[] fNames = vo.getFName().split("/");
			String[] fSNames = vo.getFSName().split("/");
			model.addAttribute("fNames", fNames);
			model.addAttribute("fSNames", fSNames);
		}
		
		model.addAttribute("vo", vo);
		return "pds/pdsContent";
	}
	
	@GetMapping("/pdsDownload")
	public void pdsDownloadGet() {
		
		
		
	}
	
	
	
	
	
	
}
