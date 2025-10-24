package com.spring.springGroupS10.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.common.ProjectProvide;
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
	public String pdsFormGet(HttpSession session) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if(sLevel == null || sLevel != 0) {
			return "redirect:/message/noPerMission";
		}
		return "pds/pdsForm";
	}
	
	@PostMapping("/pdsUpload")
	public String pdsUploadPost(PdsVO vo, HttpSession session, HttpServletRequest request) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if(sLevel == null || sLevel != 0) {
			return "redirect:/message/noPerMission";
		}
		
		String sUserId = (String) session.getAttribute("sUserId");
		
		MemberVO memberVO = memberService.getMemberByUserId(sUserId);
		vo.setMemberIdx(memberVO.getIdx());
		vo.setHostIp(request.getRemoteAddr());
		
		int res = pdsService.pdsUpload(vo, request);
		
		if(res != 0) return "redirect:/message/pdsUploadOk";
		else return "redirect:/message/pdsUploadNo";
	}
	
	@GetMapping("/pdsContent")
	public String pdsContentGet(Model model, PageVO pageVO,
			@RequestParam(name = "idx", defaultValue = "0") int idx
		) {
		
		PdsVO vo = pdsService.getPdsContent(idx);
		
		if(vo != null) {
			vo.setFormattedFSize(projectProvide.formatFileSize(vo.getFSize()));
		}
		
		if(vo != null && vo.getFName() != null) {
			String[] fNames = vo.getFName().split("/");
			String[] fSNames = vo.getFSName().split("/");
			model.addAttribute("fNames", fNames);
			model.addAttribute("fSNames", fSNames);
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageVO", pageVO);
		
		return "pds/pdsContent";
	}
	
	@GetMapping("/pdsDownload")
	public void pdsDownloadGet(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam("idx") int idx,
			@RequestParam("fSName") String fSName,
			@RequestParam("fName") String fName
		) throws Exception {
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		File file = new File(realPath + fSName);
		
		response.setContentType("application/octet-stream");
		
		String encodedFName = URLEncoder.encode(fName, "UTF-8");
		
		response.setHeader("Content-Disposition", "attachment; filename=" +encodedFName);
		
		FileInputStream fis = new FileInputStream(file);
		OutputStream os = response.getOutputStream();
		
		FileCopyUtils.copy(fis, os);
		
		if(fis != null) fis.close();
		if(os != null) os.close();
		
	}
	
	@ResponseBody
	@PostMapping("/pdsDownNumCheck")
	public void pdsDownNumCheckPost(int idx) {
		pdsService.setPdsDownNumCheck(idx);
	}
	
	@GetMapping("/pdsDelete")
	public String pdsDeleteGet(int idx, HttpServletRequest request) {
		
		PdsVO vo = pdsService.getPdsIdx(idx);
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		String[] fSNames = vo.getFSName().split("/");
		
		for(String fSName : fSNames) {
			new File(realPath + fSName).delete();
		}
		
		int res = pdsService.getPdsDelelte(idx);
		
		if(res != 0) return "redirect:/message/pdsDeleteOk";
		else return "redirect:/message/pdsDeleteNo";
	}
	
	@GetMapping("/pdsUpdate")
	public String pdsUpdateGet(Model model, int idx) {
		PdsVO vo = pdsService.getPdsContent(idx);
		
		if(vo != null && vo.getFName() != null) {
			String[] fNames = vo.getFName().split("/");
			String[] fSNames = vo.getFSName().split("/");
			model.addAttribute("fNames", fNames);
			model.addAttribute("fSNames", fSNames);
		}
		
		model.addAttribute("vo", vo);
		return "pds/pdsUpdate";
	}
	
	@PostMapping("/pdsUpdate")
	public String pdsUpdatePost(PdsVO vo,
			String[] deleteFiles,
			MultipartFile[] newFiles,
			HttpServletRequest request
		) {
		
		if(deleteFiles != null) {
			pdsService.deletedPdsFiles(deleteFiles, request);
		}
		
		Map<String, String> newFilesMap = pdsService.uploadNewPdsFiles(newFiles, request);
		
		pdsService.updatePdsVO(vo, deleteFiles, newFilesMap, request);
		
		int res = pdsService.pdsUpdate(vo);
		
		if(res != 0) return "redirect:/message/pdsUpdateOk?idx=" + vo.getIdx();
		else return "redirect:/message/pdsUpdateNo";
	}
	
	
}
