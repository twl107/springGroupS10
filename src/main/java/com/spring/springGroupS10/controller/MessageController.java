package com.spring.springGroupS10.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS10.vo.PageVO;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, HttpSession session, PageVO pageVO,
			@PathVariable String msgFlag,
			@RequestParam(name="userid", defaultValue = "", required = false) String userid,
			@RequestParam(name="member_id", defaultValue = "0", required = false) int memberId
			//@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			//@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) {
		
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", userid + "님 환영합니다.");
			model.addAttribute("url", "/member/home?userid="+userid);
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
		
		
		return "include/message";
	}
	
}
