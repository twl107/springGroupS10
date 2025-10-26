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
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.service.CartService;
import com.spring.springGroupS10.service.InquiryService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.OrderService;
import com.spring.springGroupS10.vo.CartVO;
import com.spring.springGroupS10.vo.InquiryVO;
import com.spring.springGroupS10.vo.KakaoProfile;
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
	
	@Autowired
	RestTemplate restTemplate;
	
	
	
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
			
			else {
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
		return "redirect:/";
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
		
		Long memberIdx = vo.getIdx();
		List<OrderVO> myOrderList = orderService.getRecentOrderList(memberIdx, 4);
		model.addAttribute("myOrderList", myOrderList);
		
		List<CartVO> myCartList = cartService.getRecentCartList(memberIdx, 4);
		model.addAttribute("myCartList", myCartList);
		
		List<InquiryVO> myInquiryList = inquiryService.getRecntInquiryList(userId, 4);
		model.addAttribute("myInquiryList", myInquiryList);
		
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
	
	@GetMapping("/memberFind")
  public String memberFindGet() {
    return "member/memberFind";
  }
  
	@ResponseBody
  @PostMapping("/sendAuthCodeForFind")
  public String sendAuthCodeForFindPost(String email, HttpSession session) throws MessagingException {
    
		List<String> userIds = memberService.findUserIdByEmail(email);
		
    if (userIds == null || userIds.isEmpty()) {
      return "0";
    }
    
    String authKey = UUID.randomUUID().toString().substring(0, 8);
    
    session.setAttribute("sAuthKey", authKey);
    session.setAttribute("sAuthEmail", email);
    session.setMaxInactiveInterval(180);
    
    String title = "[TWAUDIO] 아이디 찾기 인증키입니다.";
    String mailFlag = "인증키 : " + authKey;
    
    projectProvide.mailSend(email, title, mailFlag);
    
    return "1";
  }
	
	@ResponseBody
  @PostMapping("/sendAuthCodeForPwReset")
  public String sendAuthCodeForPwResetPost(String userId, String email, HttpSession session) throws MessagingException {
    
    MemberVO vo = memberService.getMemberByUserId(userId);
    
    if (vo == null || !vo.getEmail().equals(email)) {
      return "0";
    }
    
    String authKey = UUID.randomUUID().toString().substring(0, 8);
    
    session.setAttribute("sAuthKey", authKey);
    session.setAttribute("sAuthUserId", userId);
    session.setMaxInactiveInterval(180);
    
    String title = "[TWAUDIO] 비밀번호 찾기 인증키입니다.";
    String mailFlag = "인증키 : " + authKey;
    
    projectProvide.mailSend(email, title, mailFlag);
    
    return "1";
  }
	
	@ResponseBody
  @PostMapping("/findId")
  public String findIdPost(String email, String authKey, HttpSession session) {
    String sAuthKey = (String) session.getAttribute("sAuthKey");
    String sAuthEmail = (String) session.getAttribute("sAuthEmail");
    
    if (sAuthKey == null || !sAuthKey.equals(authKey) || sAuthEmail == null || !sAuthEmail.equals(email)) {
      return "0"; // 0: 인증 실패
    }
    
    List<String> userIds = memberService.findUserIdByEmail(email);
    
    session.removeAttribute("sAuthKey");
    session.removeAttribute("sAuthEmail");
    
    return String.join(", ", userIds);
  }
  
	@ResponseBody
  @PostMapping("/verifyForPwReset")
  public String verifyForPwResetPost(String authKey, HttpSession session) {
    String sAuthKey = (String) session.getAttribute("sAuthKey");
    String sAuthUserId = (String) session.getAttribute("sAuthUserId");
    
    if (sAuthKey == null || !sAuthKey.equals(authKey) || sAuthUserId == null) {
      return "0"; //
    }
    
    session.setAttribute("pwResetUserId", sAuthUserId);
    session.removeAttribute("sAuthKey");
    session.removeAttribute("sAuthUserId");
    
    return "1";
  }
  
	@GetMapping("/memberPwdReset")
  public String resetPasswordGet(HttpSession session, Model model, HttpServletRequest request) {
    String pwResetUserId = (String) session.getAttribute("pwResetUserId");
    
    if (pwResetUserId == null) return "redirect:/message/noUserId";
    
    model.addAttribute("userId", pwResetUserId);
    return "member/memberPwdReset";
  }
  
	@PostMapping("/memberPwdReset")
  public String resetPasswordPost(String userId, String newPassword, String newPasswordCheck,
  			HttpSession session, HttpServletRequest request
			) {
    
    String pwResetUserId = (String) session.getAttribute("pwResetUserId");
    
    if (pwResetUserId == null || !pwResetUserId.equals(userId)) {
      return "redirect:/message/userIdMathNo";
    }
    
    if (!newPassword.equals(newPasswordCheck)) {
      return "redirect:/message/pwdMathNo";
    }
    
    String encodedPassword = passwordEncoder.encode(newPassword);
    memberService.updatePasswordByUserId(userId, encodedPassword);
    
    session.removeAttribute("pwResetUserId");
    
    return "redirect:/message/pwdMathOk";
  }
	
	@GetMapping("/userDelete")
	public String userDeleteGet() {
		return "member/memberWithdrawalCheck";
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
	
	@GetMapping("/confirmRecovery")
	public String confirmRecoveryGet(@RequestParam("userId") String userId, Model model) {
	    MemberVO vo = memberService.getMemberByUserId(userId);
	    if (vo == null || !vo.isDeleted()) {
	        model.addAttribute("message", "잘못된 접근입니다.");
	        model.addAttribute("url", "/member/memberLogin");
	        return "include/message";
	    }
	    model.addAttribute("userId", userId);
	    return "member/confirmRecovery";
	}
	
	@GetMapping("/recoverAccount")
	public String recoverAccountGet(@RequestParam("userId") String userId, Model model, HttpSession session) {
	    boolean recoverySuccess = memberService.recoverAccount(userId); 
	    
	    if (recoverySuccess) {
	        MemberVO recoveredMember = memberService.getMemberByUserId(userId);

	        String strLevel = "";
	        if(recoveredMember.getLevel() == 0) strLevel = "관리자";
	        else if(recoveredMember.getLevel() == 3) strLevel = "준회원";

	        session.setAttribute("sUserId", recoveredMember.getUserId());
	        session.setAttribute("sNickName", recoveredMember.getNickName());
	        session.setAttribute("sLevel", recoveredMember.getLevel());
	        session.setAttribute("strLevel", strLevel);
	        session.setAttribute("sMemberIdx", recoveredMember.getIdx());
	        memberService.updateLastLogin(userId);
	        MemberVO updatedVo = memberService.getMemberByUserId(userId);
	        session.setAttribute("sLastLoginAt", updatedVo.getLastLoginAt());
	        
	        model.addAttribute("message", "계정이 복구되었습니다. 다시 로그인되었습니다.");
	        model.addAttribute("url", "/");
	    } else {
	        model.addAttribute("message", "계정 복구에 실패했습니다. 관리자에게 문의하세요.");
	        model.addAttribute("url", "/member/memberLogin");
	    }
	    return "include/message";
	}
	
	@GetMapping("/memberUpdate")
	public String memberUpdateGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) {
			return "redirect:/message/useLogin";
		}

		MemberVO vo = memberService.getMemberByUserId(userId);
		model.addAttribute("vo", vo);
		return "member/memberUpdate";
	}

	@PostMapping("/memberUpdate")
	public String memberUpdatePost(MemberVO vo, String email1, String email2, HttpSession session, Model model) {

		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) {
			return "redirect:/message/useLogin";
		}

		vo.setUserId(userId);
		vo.setEmail(email1 + "@" + email2);

		MemberVO checkVO = memberService.getMemberByNickName(vo.getNickName());
		if (checkVO != null && !checkVO.getUserId().equals(userId)) return "true";

		int res = memberService.setUpdateMember(vo);
		if (res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/message/memberUpdateOk";
		}
		else return "redirect:/message/memberUpdateNo";
	}

	@GetMapping("/memberPwdCheck")
	public String memberPwdCheckGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) return "redirect:/message/useLogin";

		return "member/memberPwdCheck";
	}

	@PostMapping("/memberPwdCheck")
	public String memberPwdCheckPost(@RequestParam("currentPassword") String currentPassword, HttpSession session, RedirectAttributes redirectAttributes) {

		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) return "redirect:/message/useLogin";

		boolean passwordMatch = memberService.checkCurrentPassword(userId, currentPassword);
		if (passwordMatch) {
			session.setAttribute("passwordChangeVerified", true);
			session.setMaxInactiveInterval(180);
			return "redirect:/member/memberPwdUpdate";
		} else {
			redirectAttributes.addFlashAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
			return "redirect:/member/memberPwdCheck";
		}
	}

	@GetMapping("/memberPwdUpdate")
	public String memberPwdUpdateGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUserId");
		Boolean verified = (Boolean) session.getAttribute("passwordChangeVerified");
		if (userId == null || verified == null || !verified) {
			session.removeAttribute("passwordChangeVerified");
			return "redirect:/message/invalidAccess";
		}

		session.removeAttribute("passwordChangeVerified");
		return "member/memberPwdUpdate";
	}

	@PostMapping("/memberPwdUpdate")
	public String memberPwdUpdatePost(
			@RequestParam("newPassword") String newPassword,
			@RequestParam("newPasswordCheck") String newPasswordCheck,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) return "redirect:/message/useLogin";

		String regPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{6,20}$";
		if (!newPassword.matches(regPassword)) {
			model.addAttribute("error", "비밀번호는 6~20자 길이의 영문 대/소문자, 숫자, 특수문자(!@#$%^&*)를 모두 포함해야 합니다.");
			return "member/memberPwdUpdate";
		}
		if (!newPassword.equals(newPasswordCheck)) {
			model.addAttribute("error", "새 비밀번호가 일치하지 않습니다.");
			return "member/memberPwdUpdate";
		}

		String encodedPassword = passwordEncoder.encode(newPassword);
		memberService.updatePasswordByUserId(userId, encodedPassword);

		return "redirect:/message/pwdUpdateOk";
	}
	
	@GetMapping("/kakaoLogin")
  public String kakaoLoginCallback(
      @RequestParam("accessToken") String accessToken,
      HttpSession session,
      Model model
    ) {

    // 1. 액세스 토큰으로 카카오 사용자 정보 요청
    KakaoProfile profile = getKakaoUserInfo(accessToken);

    if (profile == null) {
      // 토큰이 유효하지 않거나 정보 조회 실패
      return "redirect:/message/kakaoLoginFail";
    }

    long kakaoId = profile.getId();
    MemberVO member = memberService.getMemberByKakaoId(kakaoId);

    if (member != null) {
      if(member.isDeleted()) {
        return "redirect:/message/confirmRecovery?userId=" + member.getUserId();
      }
    }
    else {
      String email = profile.getKakaoAccount().getEmail();
      String nickName = profile.getKakaoAccount().getProfile().getNickname();

      if (email != null && !email.isEmpty()) {
        MemberVO emailMember = memberService.getMemberByEmail(email);
        if (emailMember != null) {
          model.addAttribute("message", "이미 ["+email+"] 이메일로 가입된 계정이 있습니다. 일반 로그인을 이용해주세요.");
          model.addAttribute("url", "/member/memberLogin");
          return "include/message";
        }
      }

      member = new MemberVO();
      member.setKakaoId(kakaoId);
      member.setEmail(email);
      member.setNickName(nickName);

      // ID/PW 자동 생성
      String tempUserId = "kakao_" + kakaoId;
      String tempPassword = passwordEncoder.encode(UUID.randomUUID().toString());

      member.setUserId(tempUserId);
      member.setPassword(tempPassword);
      member.setName(nickName);
      member.setLevel(3);

      memberService.setMemberJoin(member);

      member = memberService.getMemberByKakaoId(kakaoId);
      if (member == null) {
        return "redirect:/message/kakaoLoginFail";
      }
    }

    String strLevel = "";
    if(member.getLevel() == 0) strLevel = "관리자";
    else if(member.getLevel() == 1) strLevel = "우수회원";
    else if(member.getLevel() == 2) strLevel = "정회원";
    else if(member.getLevel() == 3) strLevel = "준회원";

    session.setAttribute("sUserId", member.getUserId());
    session.setAttribute("sNickName", member.getNickName());
    session.setAttribute("sLevel", member.getLevel());
    session.setAttribute("strLevel", strLevel);
    session.setAttribute("sLastLoginAt", member.getLastLoginAt());
    session.setAttribute("sMemberIdx", member.getIdx());

    memberService.setMemberInforUpdate(member.getUserId(), 0);

    return "redirect:/message/memberLoginOk?userId=" + member.getUserId();
  }

  private KakaoProfile getKakaoUserInfo(String accessToken) {
    String userUrl = "https://kapi.kakao.com/v2/user/me";

    try {
      HttpHeaders headers = new HttpHeaders();
      headers.add("Authorization", "Bearer " + accessToken);
      headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

      HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers);

      ResponseEntity<KakaoProfile> response = restTemplate.exchange(
          userUrl,
          HttpMethod.POST,
          kakaoProfileRequest,
          KakaoProfile.class
      );

      return response.getBody();

    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }

	
	
	
}

