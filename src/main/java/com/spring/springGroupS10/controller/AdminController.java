package com.spring.springGroupS10.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.BannerService;
import com.spring.springGroupS10.service.DbShopService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.OrderService;
import com.spring.springGroupS10.vo.BannerVO;
import com.spring.springGroupS10.vo.DbProductVO;
import com.spring.springGroupS10.vo.InquiryReplyVO;
import com.spring.springGroupS10.vo.InquiryVO;
import com.spring.springGroupS10.vo.MemberVO;
import com.spring.springGroupS10.vo.OrderVO;
import com.spring.springGroupS10.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	BannerService bannerService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	DbShopService dbShopService;
	
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "/admin/adminMain";
	}
	
	@GetMapping("/adminLeft")
	public String adminLeftGet() {
		return "/admin/adminLeft";
	}
	
	@GetMapping("/adminContent")
	public String adminContentGet(Model model) {
		
		int newOrders = orderService.getOrderCountByStatus("결제완료");
    int preparingShipment = orderService.getOrderCountByStatus("배송준비중");
    int pendingInquiries = adminService.getPendingInquiryCount();
    int newMembers = memberService.getNewMemberCountToday();

    model.addAttribute("newOrders", newOrders);
    model.addAttribute("preparingShipment", preparingShipment);
    model.addAttribute("pendingInquiries", pendingInquiries);
    model.addAttribute("newMembers", newMembers);
		
    long todaySales = orderService.getSalesByDate("today");
    long monthSales = orderService.getSalesByDate("month");
    
    model.addAttribute("todaySales", todaySales);
    model.addAttribute("monthSales", monthSales);
    
		return "/admin/adminContent";
	}
	
  @GetMapping("/member/adminMemberList")
  public String adminMemberListGet(Model model, PageVO pageVO,
      @RequestParam(name="level", defaultValue="99", required=false) int level) {
    
    pageVO.setLevel(level);
    pageVO.setSection("member");
    pageVO = pagination.pagination(pageVO);
    
    List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getLevel());
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    
    return "admin/member/adminMemberList";
  }
	
  @ResponseBody
  @PostMapping("/member/updateLevel")
  public int memberUpdateLevelPost(	int idx, int level) {
    return memberService.updateMemberLevel(idx, level);
  }
	
	@GetMapping("/inquiry/adInquiryList")
	public String adInquiryListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "15", required = false) int pageSize
		) {
		PageVO pageVO = new PageVO();
		pageVO.setPart(part);
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("adInquiry");
		pageVO = pagination.pagination(pageVO);
		
		ArrayList<InquiryVO> vos = adminService.getInquiryListAdmin(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		
		return "admin/inquiry/adInquiryList";
	}
	
	@GetMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyGet(Model model, int idx,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name = "replySw", defaultValue = "", required = false) String replySw
		) {
		
		InquiryVO vo = adminService.getInquiryContent(idx);
		InquiryReplyVO reVO = adminService.getInquiryReplyContent(idx);
		
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("replySw", replySw);
		
		return "admin/inquiry/adInquiryReply";
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyInput")
	public int adInquiryReplyInputPost(InquiryReplyVO vo) {
		int res = 0;
		res = adminService.setInquiryInputAdmin(vo);
		if(res != 0) adminService.setInquiryUpdateAdmin(vo.getInquiryIdx());
		
		return res;
	}
	
	@PostMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyUpdatePost(InquiryReplyVO reVO) {
		int res = adminService.setInquiryReplyUpdate(reVO);
		
		if(res != 0) return "redirect:/message/adInquiryReplyUpdateOk?idx="+reVO.getInquiryIdx();
		return "redirect:/message/adInquiryReplyUpdateNo?idx="+reVO.getInquiryIdx();
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyDelete")
	public int adInquiryReplyDeletePost(int inquiryIdx, int reIdx) {
		adminService.setAdInquiryReplyDelete(reIdx);
		return adminService.setInquiryReplyStatusUpdate(inquiryIdx);
	}
	
	@Transactional
	@RequestMapping(value="/inquiry/adInquiryDelete", method = RequestMethod.GET)
	public String adInquiryDeleteGet(Model model, int idx, String fSName, int reIdx, int pag) {
		adminService.setAdInquiryDelete(idx, fSName, reIdx);
		model.addAttribute("pag", pag);
		return "redirect:/message/adInquiryDeleteOk";
	}
	
	@GetMapping("/dbShop/adminOrderList")
	public String adminOrderListGet(Model model, PageVO pageVO,
			@RequestParam(name = "orderStatus", defaultValue = "전체", required = false) String orderStatus,
			@RequestParam(name="startJumun", defaultValue="", required=false) String startJumun,
	    @RequestParam(name="endJumun", defaultValue="", required=false) String endJumun
		) {
		
		String strNow = "";
		if(startJumun.equals("")) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			strNow = sdf.format(now);
			
			startJumun = strNow;
			endJumun = strNow;
		}
		
		String strOrderStatus = startJumun + "@" + endJumun + "@" + orderStatus;
		pageVO.setSection("adminOrder");
		pageVO.setSearchString(strOrderStatus);
		pageVO = pagination.pagination(pageVO);
		
		List<OrderVO> vos = orderService.getAdminOrderList(pageVO.getStartIndexNo(), pageVO.getPageSize(), startJumun, endJumun, orderStatus);
		
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("orderStatus", orderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/dbShop/adminOrderList";
	}
	
	@ResponseBody
	@PostMapping("/dbShop/updateStatus")
	public String adminOrderUpdateStatusPost(String orderId, String orderStatus) {
		
		int res = orderService.setUpdateStatus(orderId, orderStatus);
		
		if(res != 0) return "OK";
		else return "Status Update Failed";
	}
	
	@GetMapping("/banner/adminBannerList")
	public String bannerManagementGet(Model model, HttpSession session) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if (sLevel == null || sLevel != 0) return "redirect:/";

		List<BannerVO> bannerList = bannerService.getAllBannersOrdered();
		model.addAttribute("bannerList", bannerList);
		return "admin/banner/adminBannerList";
	}

	@GetMapping("/banner/bannerAdd")
	public String bannerAddGet(HttpSession session) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if (sLevel == null || sLevel != 0) return "redirect:/";
		return "admin/banner/adminBannerForm";
	}

	@PostMapping("/banner/bannerAdd")
	public String bannerAddPost(BannerVO vo, MultipartFile file, HttpSession session, Model model, HttpServletRequest request) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if (sLevel == null || sLevel != 0) return "redirect:/";
		
		if (vo.getIsActive() == null) {
			vo.setIsActive(false);
		}

		try {
			if (file != null && !file.isEmpty()) {
				String savedFileName = projectProvide.saveFile(file, "banner", request);
				if (savedFileName != null) {
					vo.setFSName(savedFileName);

					int res = bannerService.addBanner(vo);
					if (res > 0) {
						return "redirect:/message/adminBannerAddOk";
					}
				}
			} else {
				model.addAttribute("message", "배너 이미지를 첨부해주세요.");
				model.addAttribute("url", "/admin/banner/bannerAdd");
				return "include/message";
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "redirect:/message/adminBannerAddNo?reason=upload";
		}
		return "redirect:/message/adminBannerAddNo";
	}

	@PostMapping("/banner/bannerDelete")
	public String bannerDeletePost(@RequestParam("idx") int idx, HttpSession session) {
		Integer sLevel = (Integer) session.getAttribute("sLevel");
		if (sLevel == null || sLevel != 0) return "redirect:/";

		boolean res = bannerService.deleteBanner(idx);

		if (res) {
			return "redirect:/message/adminBannerDeleteOk";
		} else {
			return "redirect:/message/adminBannerDeleteNo";
		}
	}
	
	@GetMapping("/banner/adminMainProductList")
  public String mainProductManagementGet(Model model, PageVO pageVO, HttpSession session) {
      Integer sLevel = (Integer) session.getAttribute("sLevel");
      if (sLevel == null || sLevel != 0) return "redirect:/";

      pageVO.setSection("adminProductList");
      if (pageVO.getPageSize() == 0) pageVO.setPageSize(10);
      
      pageVO = pagination.pagination(pageVO);
      List<DbProductVO> productList = dbShopService.getDbProductListAdmin(pageVO.getStartIndexNo(), pageVO.getPageSize());

      model.addAttribute("productList", productList);
      model.addAttribute("pageVO", pageVO);

      return "admin/banner/adminMainProductList";
  }
	
	@ResponseBody
  @PostMapping("/banner/toggleRecommendation")
  public String toggleProductRecommendation(
          @RequestParam("idx") int idx,
          @RequestParam("isRecommended") boolean isRecommended,
          HttpSession session) {

    Integer sLevel = (Integer) session.getAttribute("sLevel");
    if (sLevel == null || sLevel != 0) {
      return "AUTH_ERROR"; // 권한 없음
    }

    int res = dbShopService.updateProductRecommendation(idx, isRecommended);

    return (res > 0) ? "SUCCESS" : "FAIL";
  }

	
	
	
		
}
