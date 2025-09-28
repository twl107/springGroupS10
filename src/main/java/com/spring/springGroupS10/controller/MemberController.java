package com.spring.springGroupS10.controller;

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

import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	@GetMapping("/memberLogin")
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cUserid")) {
					request.setAttribute("userid", cookies[i].getValue());
					break;
				}
			}
		}
		return "/member/memberLogin";
	}
	
	@PostMapping("/memberLogin")
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="userid", defaultValue="", required = false) String userid,
			@RequestParam(name="password", defaultValue="", required = false) String password,
			@RequestParam(name="idCheck", defaultValue="off", required = false) String idCheck,
			HttpSession session, Model model
		) {
		
		MemberVO vo = memberService.getMemberByUserid(userid);
		
		if(vo != null && passwordEncoder.matches(password, vo.getPassword())) {
			
			if(vo.isDeleted()) {
				return "redirect:/message/loginError?msgFlag=deleted";
			}
			
			session.setAttribute("sUserid", vo.getUserid());
			session.setAttribute("sNickname", vo.getNickname());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sRole", vo.getRole());
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cUserid", userid);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cUserid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			return "redirect:/message/memberLoginOk?userid="+userid;
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
	public String memberJoinPost(MemberVO vo) {
		if(memberService.getMemberByUserid(vo.getUserid()) != null) {
			return "redirect:/message/memberJoinNo";
		}
		
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
		
	}
	
	
	@PostMapping("/useridCheck")
	@ResponseBody
	public String useridCheckPost(@RequestParam("userid") String userid) {
		
		MemberVO vo = memberService.getMemberByUserid(userid);
		
		if(vo != null) {
			return "true";
		}
		return "";
	}
	
	@PostMapping("/nicknameCheck")
	@ResponseBody
	public String nicknameCheckPost(@RequestParam("nickname") String nickname) {
		
		MemberVO vo = memberService.getMemberByNickname(nickname);
		
		if(vo != null) {
			return "true";
		}
		return "";
	}
	
	
}
