package com.spring.springGroupS10.controller;

import java.time.LocalDateTime;
import java.util.List;
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
import com.spring.springGroupS10.service.CartService;
import com.spring.springGroupS10.service.InquiryService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.OrderService;
import com.spring.springGroupS10.vo.CartVO;
import com.spring.springGroupS10.vo.InquiryVO;
import com.spring.springGroupS10.vo.MemberVO;
import com.spring.springGroupS10.vo.OrderVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	InquiryService inquiryService;
	
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
				return "redirect:/message/confirmRecovery?userId=" + userId;
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
				int point = vo.getTodayCnt() < 6 ? 10 : 0;
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
		
		// 최근 주문 내역
		Long memberIdx = vo.getIdx();
		List<OrderVO> myOrderList = orderService.getRecentOrderList(memberIdx, 4);
		model.addAttribute("myOrderList", myOrderList);
		
		// 장바구니 내역
		List<CartVO> myCartList = cartService.getRecentCartList(memberIdx, 4);
		model.addAttribute("myCartList", myCartList);
		
		// 문의 내역
		List<InquiryVO> myInquiryList = inquiryService.getRecntInquiryList(userId, 4);
		model.addAttribute("myInquiryList", myInquiryList);
		
		System.out.println("myInquiryList : " + myInquiryList);
		
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
	
	/* 아이디/비밀번호 찾기 폼화면 */
	@GetMapping("/memberFind")
  public String memberFindGet() {
    return "member/memberFind";
  }
  
	/* 아이디 찾기 이메일 발송 */
	@ResponseBody
  @PostMapping("/sendAuthCodeForFind")
  public String sendAuthCodeForFindPost(String email, HttpSession session) throws MessagingException {
    
		List<String> userIds = memberService.findUserIdByEmail(email);
		
    if (userIds == null || userIds.isEmpty()) {
      return "0"; // 0: 가입되지 않은 이메일
    }
    
    String authKey = UUID.randomUUID().toString().substring(0, 8);
    
    session.setAttribute("sAuthKey", authKey);
    session.setAttribute("sAuthEmail", email);
    session.setMaxInactiveInterval(300); // 유효시간 5분
    
    String title = "[MyWebSite] 아이디 찾기 인증키입니다.";
    String mailFlag = "인증키 : " + authKey;
    
    projectProvide.mailSend(email, title, mailFlag);
    
    return "1"; // 1: 인증키 발송 성공
  }
	
	/* 비밀번호 찾기 이메일 발송 */
	@ResponseBody
  @PostMapping("/sendAuthCodeForPwReset")
  public String sendAuthCodeForPwResetPost(String userId, String email, HttpSession session) throws MessagingException {
    
    MemberVO vo = memberService.getMemberByUserId(userId);
    
    // 아이디가 없거나, 해당 아이디의 이메일 정보가 일치하지 않으면 실패 처리
    if (vo == null || !vo.getEmail().equals(email)) {
      return "0"; // 0: 아이디가 없거나, 아이디와 이메일이 일치하지 않음
    }
    
    String authKey = UUID.randomUUID().toString().substring(0, 8);
    
    // 세션에 인증받을 대상의 userId를 저장
    session.setAttribute("sAuthKey", authKey);
    session.setAttribute("sAuthUserId", userId);
    session.setMaxInactiveInterval(300);
    
    String title = "[MyWebSite] 비밀번호 찾기 인증키입니다.";
    String mailFlag = "인증키 : " + authKey;
    
    projectProvide.mailSend(email, title, mailFlag);
    
    return "1"; // 1: 인증키 발송 성공
  }
	
  /* 아이디 찾기 (AJAX) - 인증번호 확인 */
	@ResponseBody
  @PostMapping("/findId")
  public String findIdPost(String email, String authKey, HttpSession session) {
    String sAuthKey = (String) session.getAttribute("sAuthKey");
    String sAuthEmail = (String) session.getAttribute("sAuthEmail");
    
    if (sAuthKey == null || !sAuthKey.equals(authKey) || sAuthEmail == null || !sAuthEmail.equals(email)) {
      return "0"; // 0: 인증 실패
    }
    
    List<String> userIds = memberService.findUserIdByEmail(email);
    
    // 이메일 중복 가입이 가능하다면, Service단에서 List로 받아와서 처리하거나 정책을 정해야 합니다.
    // 여기서는 첫 번째 검색된 회원ID를 반환하는 것으로 가정합니다.
    
    session.removeAttribute("sAuthKey");
    session.removeAttribute("sAuthEmail");
    
    return String.join(", ", userIds);
  }
  
  /* 비밀번호 재설정 (AJAX) - 인증번호 확인 */
	@ResponseBody
  @PostMapping("/verifyForPwReset")
  public String verifyForPwResetPost(String authKey, HttpSession session) {
    String sAuthKey = (String) session.getAttribute("sAuthKey");
    String sAuthUserId = (String) session.getAttribute("sAuthUserId");
    
    if (sAuthKey == null || !sAuthKey.equals(authKey) || sAuthUserId == null) {
      return "0"; // 0: 인증 실패
    }
    
    // 인증 성공 시, '비밀번호 변경 가능' 상태로 'userId'를 세션에 저장
    session.setAttribute("pwResetUserId", sAuthUserId);
    
    session.removeAttribute("sAuthKey");
    session.removeAttribute("sAuthUserId");
    
    return "1"; // 1: 인증 성공
  }
  
  /* 비밀번호 재설정 폼 페이지 (View) */
	@GetMapping("/memberPwdReset")
  public String resetPasswordGet(HttpSession session, Model model, HttpServletRequest request) {
    String pwResetUserId = (String) session.getAttribute("pwResetUserId");
    
    if (pwResetUserId == null) return "redirect:/message/noUserId";
    
    model.addAttribute("userId", pwResetUserId);
    return "member/memberPwdReset"; // /WEB-INF/views/member/memberPwdReset.jsp
  }
  
   /* 비밀번호 재설정 처리 */
	@PostMapping("/memberPwdReset")
  public String resetPasswordPost(String userId, String newPassword, String newPasswordCheck,
  			HttpSession session, HttpServletRequest request
			) {
    
    String pwResetUserId = (String) session.getAttribute("pwResetUserId");
    
    // 세션의 userId와 폼의 userId가 일치하는지 최종 확인
    if (pwResetUserId == null || !pwResetUserId.equals(userId)) {
      return "redirect:/message/userIdMathNo";
    }
    
    if (!newPassword.equals(newPasswordCheck)) {
      return "redirect:/message/pwdMathNo";
    }
    
    // userId를 기준으로 암호화된 비밀번호 업데이트
    String encodedPassword = passwordEncoder.encode(newPassword);
    memberService.updatePasswordByUserId(userId, encodedPassword);
    
    session.removeAttribute("pwResetUserId");
    
    return "redirect:/message/pwdMathOk";
  }
	
	@GetMapping("/userDelete")
	public String userDeleteGet() {
		return "member/userDeletePwdCheck";
	}
	
	@PostMapping("/userDelete")
	public String userDeletePost(Model model, HttpSession session, @RequestParam("password") String password) {
		
		String userId = (String) session.getAttribute("sUserId");
		
		boolean userDeleteOk = memberService.userDelete(userId, password);
		
		if(userDeleteOk) {
			session.invalidate();
			return "redirect:/message/userDeleteOk";
		}
		else {
			return "redirect:/message/userDeleteNo";
		}
	}
	
	@GetMapping("/memberDeleteRecovery")
	public String memberDeleteRecoveryGet(Model model, @RequestParam("userId") String userId) {
		model.addAttribute("userId", userId);
		return "member/memberDeleteRecovery";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}

