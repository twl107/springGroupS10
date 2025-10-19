package com.spring.springGroupS10.controller;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	ProjectProvide projectProvide;
	
	
	@GetMapping("/memberLogin")
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cUserId")) {
					request.setAttribute("userId", cookies[i].getValue());
					break;
				}
			}
		}
		return "/member/memberLogin";
	}
	
	// 일반 로그인 처리
	@PostMapping("/memberLogin")
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="userId", defaultValue="", required = false) String userId,
			@RequestParam(name="password", defaultValue="", required = false) String password,
			@RequestParam(name="idCheck", defaultValue="off", required = false) String idCheck,
			HttpSession session, Model model
		) {
		
		MemberVO vo = memberService.getMemberByUserId(userId);
		
		if(vo != null &&  passwordEncoder.matches(password, vo.getPassword())) {
			
			if(vo.isDeleted()) {
				return "redirect:/message/loginDelError";
			}
			
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sUserId", vo.getUserId());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sLastLoginAt", vo.getLastLoginAt());
			session.setAttribute("sMemberIdx", vo.getIdx());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cUserId", userId);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cUserId")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			if(vo.getLevel() == 3 && vo.getVisitCnt() > 3) {
				memberService.setMemberLevelUp(userId);
			}
			
			if(!LocalDateTime.now().toString().substring(0,10).equals(vo.getLastLoginAt().substring(0,10))) {
				memberService.setMemberTodayCntClear(userId);
				vo.setTodayCnt(0);
			}
			
			if(vo.getLevel() < 3) {
				int point = vo.getTodayCnt() < 5 ? 10 : 0;
				memberService.setMemberInforUpdate(userId, point);
			}
			else memberService.setMemberInforUpdate(userId, 0);
			
			return "redirect:/message/memberLoginOk?userId="+userId;
		}
		else return "redirect:/message/memberLoginNo"; 
	}
	
	@GetMapping("/home")
	public String memberHomeGet() {
		return "home";
	}
	
	@GetMapping("/memberLogout")
	public String memberLogoutGet(HttpSession session) {
		session.invalidate();
		return "redirect:/message/memberLogout";
	}
	
	
	@GetMapping("/memberJoin")
	public String memberJoinGet() {
		return "/member/memberJoin";
	}
	
	@PostMapping("/memberJoin")
	public String memberJoinPost(MemberVO vo, String email1, String email2) {
		if(memberService.getMemberByUserId(vo.getUserId()) != null) {
			return "redirect:/message/memberJoinNo";
		}
		
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		vo.setEmail(email1 + "@" + email2);
		
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
		
	}
	
	@PostMapping("/userIdCheck")
	@ResponseBody
	public String userIdCheckPost(@RequestParam("userId") String userId) {
		
		MemberVO vo = memberService.getMemberByUserId(userId);
		
		if(vo != null) {
			return "true";
		}
		return "";
	}
	
	@PostMapping("/nickNameCheck")
	@ResponseBody
	public String nickNameCheckPost(@RequestParam("nickName") String nickName) {
		
		MemberVO vo = memberService.getMemberByNickName(nickName);
		
		if(vo != null) {
			return "true";
		}
		return "";
	}
	
	@GetMapping("/memberMain")
	public String memberMainGet(Model model, HttpSession session) {
		String userId = (String) session.getAttribute("sUserId");
		MemberVO vo = memberService.getMemberByUserId(userId);
		
		model.addAttribute("memberVO", vo);
		
		return "/member/memberMain";
	}
	
	@ResponseBody
	@PostMapping("/memberEmailCheck")
	public int memberEmailCheckPost(String email, HttpSession session) throws MessagingException {
		String emailKey = UUID.randomUUID().toString().substring(0, 8);
		
		session.setAttribute("sEmailKey", emailKey);
		
		projectProvide.mailSend(email, "이메일 인증키입니다.", "이메일 인증키 : " + emailKey);
		
		return 1;
	}
	
	@ResponseBody
	@PostMapping("/memberEmailCheckOk")
	public int memberEmailCheckOkPost(String checkKey, HttpSession session) {
		String emailKey = (String) session.getAttribute("sEmailKey");
		if(checkKey.equals(emailKey)) {
			session.removeAttribute("sEmailKey");
			return 1;
		}
		return 0;
	}
	
	@ResponseBody
	@PostMapping("/memberEmailCheckNo")
	public void memberEmailCheckNoPost(HttpSession session) {
	   session.removeAttribute("sEmeilKey");
	}	
}

