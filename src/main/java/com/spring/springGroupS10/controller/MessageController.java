package com.spring.springGroupS10.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springGroupS10.vo.PageVO;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, HttpSession session, PageVO pageVO,
			@PathVariable String msgFlag,
			@RequestParam(name="userId", defaultValue = "", required = false) String userId,
			@RequestParam(name="memberId", defaultValue = "0", required = false) int memberId,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx
		) {
		
		
			/*
			 * if(msgFlag.equals("memberLoginOk")) { model.addAttribute("message", userId +
			 * "님 환영합니다."); model.addAttribute("url", "/member/home?userId="+userId); }
			 */
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", "로그인 되었습니다.");
			model.addAttribute("url", "/");
		}
		
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "아이디와 비밀번호를 다시 확인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("message", "로그아웃 되었습니다.");
			model.addAttribute("url", "/member/home");
		}
		
		else if(msgFlag.equals("loginDelError")) {
			model.addAttribute("message", "탈퇴 신청된 회원입니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "정상적으로 회원가입 가입되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원가입 실패");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("noUserId")) {
			model.addAttribute("message", "잘못된 접근입니다. 이메일 인증을 먼저 진행해주세요.");
			model.addAttribute("url", "/member/memberFind");
		}
		else if(msgFlag.equals("userIdMathNo")) {
			model.addAttribute("message", "비정상적인 접근입니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("pwdMathNo")) {
			model.addAttribute("message", "새 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "/member/memberPwdReset");
		}
		else if(msgFlag.equals("pwdMathOk")) {
			model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		
		else if(msgFlag.equals("dbProductInputOk")) {
			model.addAttribute("message", "상품이 등록되었습니다.");
			model.addAttribute("url", "/dbShop/dbShopList");
		}
		else if(msgFlag.equals("dbProductInputNo")) {
			model.addAttribute("message", "상품 등록 실패~~.");
			model.addAttribute("url", "/dbShop/dbProduct");
		}
		else if(msgFlag.equals("dbOptionInputOk")) {
			model.addAttribute("message", "옵션이 등록되었습니다.");
			model.addAttribute("url", "/admin/dbShop/dbOption");
		}
		else if(msgFlag.equals("dbOptionInputNo")) {
			model.addAttribute("message", "옵션 등록 실패~~");
			model.addAttribute("url", "/admin/dbShop/dbOption");
		}
		else if(msgFlag.equals("pdsUploadOk")) {
			model.addAttribute("message", "게시글이 등록 되었습니다.");
			model.addAttribute("url", "/pds/pdsList");
		}
		else if(msgFlag.equals("pdsUploadNo")) {
			model.addAttribute("message", "게시글 등록 실패~~");
			model.addAttribute("url", "/pds/pdsForm");
		}
		else if(msgFlag.equals("pdsDeleteOk")) {
			model.addAttribute("message", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/pds/pdsList");
		}
		else if(msgFlag.equals("pdsDeleteNo")) {
			model.addAttribute("message", "게시글 삭제 실패~~");
			model.addAttribute("url", "/pds/pdsContent");
		}
		else if(msgFlag.equals("noPerMission")) {
			model.addAttribute("message", "등록 권한이 없습니다.");
			model.addAttribute("url", "/pds/pdsContent");
		}
		else if(msgFlag.equals("pdsUpdateOk")) {
			model.addAttribute("message", "게시글이 수정되었습니다.");
			model.addAttribute("url", "/pds/pdsContent?idx=" + idx);
		}
		else if(msgFlag.equals("pdsUpdateNo")) {
			model.addAttribute("message", "게시글 수정 실패~~");
			model.addAttribute("url", "/pds/pdsUpdate?idx=" + idx);
		}
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("message", "공지사항이 등록되었습니다.");
			model.addAttribute("url", "/notice/noticeList");
		}
		else if(msgFlag.equals("noticeInputNo")) {
			model.addAttribute("message", "공지사항 등록에 실패했습니다.");
			model.addAttribute("url", "/notice/noticeInput");
		}
		else if(msgFlag.equals("noticeUpdateOk")) {
			model.addAttribute("message", "공지사항이 수정되었습니다.");
			model.addAttribute("url", "/notice/noticeContent?idx=" + idx);
		}
		else if(msgFlag.equals("noticeUpdateNo")) {
			model.addAttribute("message", "공지사항 수정에 실패했습니다.");
			model.addAttribute("url", "/notice/noticeUpdate?idx=" + idx);
		}
		else if(msgFlag.equals("noticeDeleteOk")) {
			model.addAttribute("message", "공지사항이 삭제되었습니다.");
			model.addAttribute("url", "/notice/noticeList");
		}
		else if(msgFlag.equals("noticeDeleteNo")) {
			model.addAttribute("message", "공지사항 삭제에 실패했습니다.");
			model.addAttribute("url", "/notice/noticeContent?idx=" + idx);
		}
		else if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("message", "1:1 문의가 등록되었습니다.");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryUpdateOk")) {
			model.addAttribute("message", "1:1 문의 내역이 수정되었습니다.");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryUpdateNo")) {
			model.addAttribute("message", "1:1 문의 수정실패~~");
			model.addAttribute("url", "/inquiry/inquiryUpdate?idx="+idx);
		}
		else if(msgFlag.equals("inquiryDeleteOk")) {
			model.addAttribute("message", "1:1 문의 내역이 삭제되었습니다.");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryDeleteNo")) {
			model.addAttribute("message", "1:1 문의 삭제실패~~");
			model.addAttribute("url", "/admin/inquiry/inquiryView?idx="+idx);
		}
		else if(msgFlag.equals("adInquiryReplyUpdateOk")) {
			model.addAttribute("message", "1:1 문의 답변글이 수정되었습니다.");
			model.addAttribute("url", "/admin/inquiry/adInquiryReply?idx="+idx);
		}
		else if(msgFlag.equals("adInquiryReplyUpdateNo")) {
			model.addAttribute("message", "1:1 문의 답변글이 수정 실패~~");
			model.addAttribute("url", "/admin/inquiry/adInquiryReply?idx="+idx);
		}
		else if(msgFlag.equals("adInquiryDeleteOk")) {
			model.addAttribute("message", "1:1 문의 원본글(+답변글)이 삭제 되었습니다.");
			model.addAttribute("url", "/admin/inquiry/adInquiryList");
		}
		else if(msgFlag.equals("useLogin")) {
			model.addAttribute("message", "로그인 후 이용해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("productNotFound")) {
			model.addAttribute("message", "잘못된 접근입니다.(productNotFound)");
			model.addAttribute("url", "/dbShop/dbProductList");
		}
		else if(msgFlag.equals("optionNotFound")) {
			model.addAttribute("message", "잘못된 접근입니다.(optionNotFound)");
			model.addAttribute("url", "/dbShop/dbProductList");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("message", "회원 탈퇴가 정상적으로 처리되었습니다. 이용해주셔서 감사합니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
			model.addAttribute("url", "/member/userDeletePwdCheck");
		}
		else if(msgFlag.equals("confirmRecovery")) {
			model.addAttribute("message", userId + "님 환영합니다.");
			model.addAttribute("url", "/member/confirmRecovery?userId=" + userId);
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "회원정보가 수정에 실패했습니다.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("pwdUpdateOk")) {
			model.addAttribute("message", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("invalidAccess")) {
			model.addAttribute("message", "잘못된 접근입니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("adminBannerAddOk")) {
			model.addAttribute("message", "새 배너가 등록되었습니다.");
			model.addAttribute("url", "/admin/banner/adminBannerList");
		}
		else if(msgFlag.equals("adminBannerAddNo")) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String reason = request.getParameter("reason");
			String message = "배너 등록에 실패했습니다.";
			if ("upload".equals(reason)) message += " (파일 업로드 오류)";
			model.addAttribute("message", message);
			model.addAttribute("url", "/admin/banner/bannerAdd");
		}
		else if(msgFlag.equals("adminBannerDeleteOk")) {
			model.addAttribute("message", "배너가 삭제되었습니다.");
			model.addAttribute("url", "/admin/banner/adminBannerList");
		}
		else if(msgFlag.equals("adminBannerDeleteNo")) {
			model.addAttribute("message", "배너 삭제에 실패했습니다.");
			model.addAttribute("url", "/admin/banner/adminBannerForm");
		}
		
		
		
		
		return "include/message";
	}
	
}
