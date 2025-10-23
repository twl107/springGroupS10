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
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.NoticeService;
import com.spring.springGroupS10.vo.NoticeVO;
import com.spring.springGroupS10.vo.PageVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

  @Autowired
  NoticeService noticeService;

  @Autowired
  MemberService memberService; // member 정보 조회를 위해 추가
  
  @Autowired
  Pagination pagination;

  // 공지사항 목록 (누구나 접근 가능)
  @GetMapping("/noticeList")
  public String noticeListGet(Model model, PageVO pageVO) {
  	
  	if (pageVO.getPag() == 0 || pageVO.getPag() < 1) {
      pageVO.setPag(1);
	  }
	  if (pageVO.getPageSize() == 0 || pageVO.getPageSize() < 1) {
	      pageVO.setPageSize(10); // 한 페이지에 10개씩 보이도록 기본값 설정	
	  }
  	
	  pageVO.setSection("notice");
    pageVO.setTotRecCnt(noticeService.getTotRecCnt());
    pageVO = pagination.pagination(pageVO);
    
    List<NoticeVO> vos = noticeService.getNoticeList(pageVO.getStartIndexNo(), pageVO.getPageSize());
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    return "notice/noticeList";
  }
  
  // 공지사항 내용 보기 (누구나 접근 가능)
  @GetMapping("/noticeContent")
  public String noticeContentGet(Model model, @RequestParam(name="idx", defaultValue="0") int idx, PageVO pageVO) {
    NoticeVO vo = noticeService.readNoticeContent(idx);
    model.addAttribute("vo", vo);
    model.addAttribute("pageVO", pageVO);
    return "notice/noticeContent";
  }

  // --- 관리자 권한 체크 시작 ---

  // 공지사항 작성 폼 (관리자만 접근)
  @GetMapping("/noticeInput")
  public String noticeInputGet(HttpSession session) {
    Integer sLevel = (Integer) session.getAttribute("sLevel");
    // 관리자 레벨이 0이 아니면 권한 없음 페이지로 리다이렉트
    if (sLevel == null || sLevel != 0) {
        return "redirect:/message/noPermission";
    }
    return "notice/noticeInput";
  }

  // 공지사항 등록 처리 (관리자만 처리)
  @PostMapping("/noticeInput")
  public String noticeInputPost(NoticeVO vo, HttpSession session,
  		MultipartFile file, HttpServletRequest request
		) {
    Integer sLevel = (Integer) session.getAttribute("sLevel");
    if (sLevel == null || sLevel != 0) {
        return "redirect:/message/noPermission";
    }
    Long sMemberIdx = (Long) session.getAttribute("sMemberIdx");
    if(sMemberIdx == null) {
    	return "redirect:/message/useLogin";
    }
    
    int res = noticeService.noticeImgSave(file, vo, sMemberIdx);
    
    if (res != 0) return "redirect:/message/noticeInputOk";
    else return "redirect:/message/noticeInputNo";
  }

  // 공지사항 수정 폼 (관리자만 접근)
  @GetMapping("/noticeUpdate")
  public String noticeUpdateGet(Model model, int idx, HttpSession session, PageVO pageVO) {
    Integer sLevel = (Integer) session.getAttribute("sLevel");
    if (sLevel == null || sLevel != 0) {
        return "redirect:/message/noPermission";
    }

    NoticeVO vo = noticeService.getNoticeContent(idx);
    model.addAttribute("vo", vo);
    model.addAttribute("pageVO", pageVO);
    return "notice/noticeUpdate";
  }
  
  // 공지사항 수정 처리 (관리자만 처리)
  @PostMapping("/noticeUpdate")
  public String noticeUpdatePost(NoticeVO vo, HttpSession session, MultipartFile file, HttpServletRequest request) {
    Integer sLevel = (Integer) session.getAttribute("sLevel");
    if (sLevel == null || sLevel != 0) {
        return "redirect:/message/noPermission";
    }

    int res = noticeService.setNoticeUpdate(file, vo, request);
    if (res != 0) return "redirect:/message/noticeUpdateOk?idx=" + vo.getIdx();
    else return "redirect:/message/noticeUpdateNo?idx=" + vo.getIdx();
  }
  
  // 공지사항 삭제 처리 (관리자만 처리)
  @GetMapping("/noticeDelete")
  public String noticeDeleteGet(int idx, HttpSession session) {
    Integer sLevel = (Integer) session.getAttribute("sLevel");
    if (sLevel == null || sLevel != 0) {
        return "redirect:/message/noPermission";
    }

    int res = noticeService.setNoticeDelete(idx);
    if (res != 0) return "redirect:/message/noticeDeleteOk";
    else return "redirect:/message/noticeDeleteNo?idx=" + idx;
  }
}

