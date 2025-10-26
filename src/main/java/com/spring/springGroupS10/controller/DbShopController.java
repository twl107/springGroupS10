package com.spring.springGroupS10.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.springGroupS10.common.Pagination;
import com.spring.springGroupS10.service.CartService;
import com.spring.springGroupS10.service.DbShopService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.OrderService;
import com.spring.springGroupS10.vo.CartVO;
import com.spring.springGroupS10.vo.DbOptionVO;
import com.spring.springGroupS10.vo.DbProductVO;
import com.spring.springGroupS10.vo.MemberVO;
import com.spring.springGroupS10.vo.OrderDetailVO;
import com.spring.springGroupS10.vo.OrderVO;
import com.spring.springGroupS10.vo.PageVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {
	
	@Autowired
	DbShopService dbShopService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	Pagination pagination;

	
	@GetMapping("/dbCategory")
	public String adminMainGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();
		
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);
		
		return "admin/dbShop/dbCategory";
	}
	
	@ResponseBody
	@PostMapping("/categoryMainInput")
	public int categoryMainInputPost(DbProductVO vo) {
		int res = 0;
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMainInput(vo);
		return res;
	}
	
	@ResponseBody
	@PostMapping("/categoryMainDelete")
	public int categoryMainDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);
		if(middleVO != null) return res;
		
		res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());
		return res;
	}
	
	@ResponseBody
	@PostMapping("/categoryMiddleInput")
	public int categoryMiddleInputPost(DbProductVO vo) {
		int res = 0;
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMiddleInput(vo);
		return res;
	}
	
	@ResponseBody
	@PostMapping("/categoryMiddleDelete")
	public int categoryMiddleDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO productVO = dbShopService.getCategoryProductName(vo);
		if(productVO != null) return 0;
		
		res = dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode());
		return res;
	}
	
	@ResponseBody
	@PostMapping("/categoryMiddleName")
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}
	
	@GetMapping("/dbProduct")
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain(); 
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}
	
	@PostMapping("/dbProduct")
	public String dbProductPost(MultipartFile file, HttpServletRequest request, DbProductVO vo) {
		int res = dbShopService.mainImgToSubImgSave(file, vo);
		
		if(res != 0) return "redirect:/message/dbProductInputOk";
		return "redirect:/message/dbProductInputNo";
	}
	
	@GetMapping("/dbShopList") 
	public String adminDbShopListGet(Model model, PageVO pageVO,
				@RequestParam(name = "mainCategory", required = false) List<String> mainCategories,
				@RequestParam(name = "middleCategory", required = false) List<String> middleCategories
			) {

		List<DbProductVO> mainCategoryVOS = dbShopService.getAllMainCategory();
		List<DbProductVO> middleCategoryVOS = dbShopService.getAllMiddleCategory();
		model.addAttribute("mainCategoryVOS", mainCategoryVOS);
		model.addAttribute("middleCategoryVOS", middleCategoryVOS);
		model.addAttribute("selectedMainCodes", mainCategories);
		model.addAttribute("selectedMiddleCodes", middleCategories);

		pageVO.setSection("adminDbShopList");
		if (pageVO.getPageSize() == 0) pageVO.setPageSize(9);

		String mainCatStr = (mainCategories != null && !mainCategories.isEmpty()) ? String.join(",", mainCategories) : "";
		String middleCatStr = (middleCategories != null && !middleCategories.isEmpty()) ? String.join(",", middleCategories) : "";
		
		pageVO.setPart(mainCatStr);
		pageVO.setSearchString(middleCatStr);

		pageVO = pagination.pagination(pageVO);

		List<DbProductVO> productVOS = dbShopService.getDbShopListPaging(
				mainCategories, 
				middleCategories,
				pageVO.getStartIndexNo(), 
				pageVO.getPageSize()
			);

		model.addAttribute("productVOS", productVOS);
		model.addAttribute("pageVO", pageVO);

		return "admin/dbShop/dbShopList";
	}
	
	@GetMapping("/dbShopContent")
	public String dbShopContentGet(Model model, int idx) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx);
		List<DbProductVO> optionVOS = dbShopService.getDbShopOption(idx);
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "admin/dbShop/dbShopContent";
	}
	
	@GetMapping("/dbOption")
	public String dbOptionGet(Model model, 
			@RequestParam(name = "productName", defaultValue = "", required = false) String productName
		) {
		
		if(productName.equals("")) {
			List<DbProductVO> mainVos = dbShopService.getCategoryMain();
			model.addAttribute("mainVos", mainVos);
		}
		else {
			DbProductVO imsiVO = dbShopService.getCategoryProductNameOne(productName);
			DbProductVO productVO = dbShopService.getCategoryProductNameOneVO(imsiVO);
			model.addAttribute("productVO", productVO);
		}
		return "admin/dbShop/dbOption";
	}
	
	@ResponseBody
	@PostMapping("/categoryProductName")
	public List<DbProductVO> categoryProductNameGet(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategoryProductNameAjax(categoryMainCode, categoryMiddleCode);
	}
	
	@ResponseBody
	@PostMapping("/getProductInfor")
	public DbProductVO getProductInforGet(String productName) {
		return dbShopService.getProductInfor(productName);
	}
	
	@ResponseBody
	@PostMapping("/getOptionList")
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}
	
	@ResponseBody
	@PostMapping("/dbOption")
	public String dbOptionPost(Model model, DbOptionVO vo, String[] optionName, int[] optionPrice) {
		if(optionName == null) {
			return "0";
		}
		
		int res = 0;
		boolean isSuccess = false;
		
		for(int i=0; i<optionName.length; i++) {
			if(optionName[i] == null || optionName[i].trim().equals("")) continue;
			
			int optionCnt = dbShopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if(optionCnt != 0) continue;
			
			vo.setOptionName(optionName[i].trim());
			vo.setOptionPrice(optionPrice[i]);
			
			res = dbShopService.setDbOptionInput(vo);
			if(res != 0) isSuccess = true;
		}
		
		if(isSuccess) return "1";
		else return "0";
	}
	
	@ResponseBody
	@PostMapping("/optionDelete")
	public int optionDeletePost(int idx) {
		return dbShopService.setOptionDelete(idx);
	}
	
	@GetMapping("/dbProductList")
	public String dbProductListGet(Model model, PageVO pageVO,
			@RequestParam(name = "mainCategory", required = false) String mainCategoryCode,
			@RequestParam(name = "keyword", required = false) String keyword
			
		) {
		
		pageVO.setPageSize(20);
    pageVO.setSection("dbProductList");
    
    // 3. Pagination 서비스가 총 개수를 계산할 수 있도록 검색어/카테고리 설정
    pageVO.setSearchString(keyword != null ? keyword : "");
    pageVO.setPart(mainCategoryCode != null ? mainCategoryCode : "");
    
    // 4. 페이지 정보 계산 (totRecCnt, startIndexNo 등)
    pageVO = pagination.pagination(pageVO);
    
    List<DbProductVO> vos;
    
    if(keyword != null && !keyword.trim().isEmpty()) {
        vos = dbShopService.getProductSearchPaging(keyword, pageVO.getStartIndexNo(), pageVO.getPageSize());
        model.addAttribute("keyword", keyword);
    }
    else if(mainCategoryCode != null && !mainCategoryCode.trim().isEmpty()) {
        vos = dbShopService.getProductByMainCategoryPaging(mainCategoryCode, pageVO.getStartIndexNo(), pageVO.getPageSize());
        model.addAttribute("mainCategoryCode", mainCategoryCode); // JSP에서 사용
    }
    else {
        vos = dbShopService.getDbProductListAdmin(pageVO.getStartIndexNo(), pageVO.getPageSize());
    }
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    
    return "dbShop/dbProductList";
	}

	@GetMapping("/dbProductContent")
	public String dbProductContentGet(int idx, Model model) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx);
		List<DbProductVO> optionVOS = dbShopService.getDbShopOption(idx);
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "dbShop/dbProductContent";
	}
	
	@GetMapping("/cartList")
	public String cartListGet(HttpSession session, Model model) {
		String sUserId = (String) session.getAttribute("sUserId"); 
		if (sUserId == null) {
			return "redirect:/member/memberLogin";
		}
		
		MemberVO memberVO = memberService.getMemberByUserId(sUserId);
		long memberIdx = memberVO.getIdx();
		
		List<CartVO> vos = cartService.getCartList(memberIdx);
		model.addAttribute("vos", vos);
		
		return "dbShop/cartList";
	}
	
	@ResponseBody
	@PostMapping("/cartAdd")
	public String addCartPost(HttpSession session, CartVO vo) {
		String userId = (String) session.getAttribute("sUserId");
		if (userId == null) {
			return "0";
		}
		
		MemberVO memberVO = memberService.getMemberByUserId(userId);
		vo.setMemberIdx(memberVO.getIdx());
		
		int res = cartService.addOrUpdateCart(vo);
		return res + "";
	}
	
	@ResponseBody
	@PostMapping("/cartDelete")
	public String deleteCartPost(int cartIdx) {
		cartService.deleteCartItem(cartIdx);
		return "1";
	}
	
	@ResponseBody
	@PostMapping("/cartUpdateQuantity")
	public String updateQuantityPost(int cartIdx, int quantity) {
		cartService.updateItemQuantity(cartIdx, quantity);
		return "1";
	}
	
	@PostMapping("/orderForm")
  public String dbShopOrderFormPost(@RequestParam("cartIdxs") List<Long> cartIdxs, HttpSession session, Model model) {
      
	  String sUserId = (String) session.getAttribute("sUserId");
	  if (sUserId == null) {
	      return "redirect:/member/memberLogin";
	  }
	  MemberVO memberVO = memberService.getMemberByUserId(sUserId);
	  
	  List<CartVO> orderItems = cartService.getCartListByIdxs(cartIdxs);
	  
	  int totalOrderPrice = 0;
	  for (CartVO item : orderItems) {
	  	totalOrderPrice += item.getTotalPrice();
	  }
	  
	  model.addAttribute("memberVO", memberVO);
	  model.addAttribute("orderItems", orderItems);
	  model.addAttribute("totalOrderPrice", totalOrderPrice);
	  
	  return "dbShop/orderForm";
  }
	
	@PostMapping("/orderFormOne")
	public String orderFormOnePost(Model model, HttpSession session,
			@RequestParam("productIdx") int productIdx,
			@RequestParam(name = "optionIdx", defaultValue = "0") int optionIdx,
			@RequestParam("quantity") int quantity
		) {
		
		String sUserId = (String) session.getAttribute("sUserId");
		if (sUserId == null) {
			return "redirect:/message/useLogin";
		}
		
		MemberVO memberVO = memberService.getMemberByUserId(sUserId);
		
		DbProductVO productVO = dbShopService.getDbShopProduct(productIdx);
		if(productVO == null) {
			return "redirect:/message/productNotFound";
		}
		
		List<CartVO> orderItems = new ArrayList<>();
		CartVO orderItem = new CartVO();
		
		int totalOrderPrice = 0;
		int basePrice = productVO.getMainPrice();
		
		if(optionIdx != 0) {
			DbOptionVO optionVO = dbShopService.getDbShopOptionOne(optionIdx);
			if(optionVO == null) {
				return "redirect:/message/optionNotFound";
			}
			
			orderItem.setOptionIdx(optionIdx);
			orderItem.setOptionName(optionVO.getOptionName());
			orderItem.setOptionPrice(optionVO.getOptionPrice());
			
			totalOrderPrice = (basePrice + optionVO.getOptionPrice()) * quantity;
		}
		else totalOrderPrice = basePrice * quantity;
		
		orderItem.setMemberIdx(memberVO.getIdx());
		orderItem.setProductIdx(productIdx);
		orderItem.setProductName(productVO.getProductName());
		orderItem.setMainPrice(basePrice);
		orderItem.setQuantity(quantity);
		orderItem.setTotalPrice(totalOrderPrice);
		
		if(productVO.getFSName() != null && !productVO.getFSName().isEmpty()) {
			orderItem.setFSName(productVO.getFSName().split("/")[0]);
		}
		
		orderItems.add(orderItem);
		
		model.addAttribute(memberVO);
		model.addAttribute("orderItems", orderItems);
		model.addAttribute("totalOrderPrice", totalOrderPrice);
		
		return "dbShop/orderForm";
	}
	
	@PostMapping("/createOrder")
	public String createOrderPost(OrderVO orderVO, HttpSession session, RedirectAttributes redirectAttributes,
				@RequestParam("cartIdxs") List<Long> cartIdxs
			) {
		String sUserId = (String) session.getAttribute("sUserId");
		if (sUserId == null) return "redirect:/member/memberLogin";
		
		MemberVO memberVO = memberService.getMemberByUserId(sUserId);
		orderVO.setMemberIdx(memberVO.getIdx());
		orderVO.setOrderStatus("결제완료");

		boolean isOrderSuccess = orderService.processOrder(orderVO, cartIdxs);

		if (!isOrderSuccess) {
			return "redirect:/message/orderFailed";
		}
		
		redirectAttributes.addAttribute("orderId", orderVO.getOrderId());
		return "redirect:/dbShop/orderComplete";
	}
	
	@GetMapping("/orderComplete")
	public String orderCompleteGet(@RequestParam("orderId") String orderId, Model model) {
		OrderVO orderVO = orderService.getOrderByOrderId(orderId);
		model.addAttribute("orderVO", orderVO);
		return "dbShop/orderComplete";
	}
	
	@GetMapping("/myOrders")
	public String myOrdersGet(HttpSession session, Model model, PageVO pageVO,
			@RequestParam(name = "orderStatus", defaultValue = "전체", required = false) String orderStatus,
			@RequestParam(name = "startJumun", defaultValue = "", required = false) String startJumun,
			@RequestParam(name = "endJumun", defaultValue = "", required = false) String endJumun
		) {
		
		String sUserId = (String) session.getAttribute("sUserId");
		if (sUserId == null) return "redirect:/member/memberLogin";
		
		String strNow = "";
		if(startJumun.equals("")) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			strNow = sdf.format(now);
			
			startJumun = strNow;
			endJumun = strNow;
		}
		
		long memberIdx = memberService.getMemberByUserId(sUserId).getIdx();
		
		pageVO.setPageSize(5);
		pageVO.setSection("myOrders");
		
		String strOrderStatus = memberIdx + "@" + startJumun + "@" + endJumun + "@" + orderStatus;
		pageVO.setSearchString(strOrderStatus);
		
		pageVO = pagination.pagination(pageVO);
		
		List<OrderVO> orderList = orderService.getMyOrderList(pageVO.getStartIndexNo(), pageVO.getPageSize(), memberIdx, startJumun, endJumun, orderStatus);

		model.addAttribute("startJumun", startJumun);
    model.addAttribute("endJumun", endJumun);
    model.addAttribute("orderStatus", orderStatus);
    model.addAttribute("orderList", orderList);
    model.addAttribute("pageVO", pageVO);
		
		return "dbShop/myOrders";
	}
	
	@GetMapping("/orderDetail")
	public String orderDetailGet(
		@RequestParam("orderId") String orderId,
		HttpSession session, Model model
	) {
		String sUserId = (String) session.getAttribute("sUserId");
		if (sUserId == null) return "redirect:/member/memberLogin";
		
		long memberIdx = memberService.getMemberByUserId(sUserId).getIdx();
		OrderVO orderVO = orderService.getOrderByOrderIdAndMember(orderId, memberIdx);
		
		if (orderVO == null) {
			return "redirect:/message/invalidOrderAccess";
		}
		
		List<OrderDetailVO> detailsList = orderService.getOrderDetailItems(orderVO.getIdx());
		
		model.addAttribute("orderVO", orderVO);
		model.addAttribute("detailsList", detailsList);
		
		return "dbShop/orderDetail";
	}
	
	
	
	
	
	
	
}
