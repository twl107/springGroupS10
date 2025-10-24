package com.spring.springGroupS10.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
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

	
	// 상품 카테고리 등록폼/리스트 출력
	@GetMapping("/dbCategory")
	public String adminMainGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();			// 대분류 리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();	// 중분류 리스트
		
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);
		
		return "admin/dbShop/dbCategory";
	}
	
	// 대분류 등록하기
	@ResponseBody
	@PostMapping("/categoryMainInput")
	public int categoryMainInputPost(DbProductVO vo) {
		int res = 0;
		// 기존에 생성된 대분류명이 있는지 체크
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMainInput(vo);
		return res;
	}
	
	// 대분류 삭제하기
	@ResponseBody
	@PostMapping("/categoryMainDelete")
	public int categoryMainDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);
		if(middleVO != null) return res;
		
		res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());
		return res;
	}
	
	// 중분류 등록하기
	@ResponseBody
	@PostMapping("/categoryMiddleInput")
	public int categoryMiddleInputPost(DbProductVO vo) {
		int res = 0;
		// 중분류 중복체크
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMiddleInput(vo);
		return res;
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@PostMapping("/categoryMiddleDelete")
	public int categoryMiddleDeletePost(DbProductVO vo) {
		int res = 0;
		DbProductVO productVO = dbShopService.getCategoryProductName(vo);
		if(productVO != null) return 0;
		
		res = dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode());
		return res;
	}
	
	// 대분류 선택하면서 중분류항목 가져오기
	@ResponseBody
	@PostMapping("/categoryMiddleName")
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}
	
	// 상품 등록 폼보기
	@GetMapping("/dbProduct")
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain(); 
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}
	
	// 상품 등록 처리
	@PostMapping("/dbProduct")
	public String dbProductPost(MultipartFile file, HttpServletRequest request, DbProductVO vo) {
		int res = dbShopService.mainImgToSubImgSave(file, vo);
		
		if(res != 0) return "redirect:/message/dbProductInputOk";
		return "redirect:/message/dbProductInputNo";
	}
	
	// 관리자페이지 상품리스트 보기
	@GetMapping("/dbShopList")
	public String dbShopListGet(Model model,
	    // 여러 개의 파라미터를 받기 위해 String[] 또는 List<String> 타입으로 변경합니다.
	    @RequestParam(name = "mainCategory", required = false) List<String> mainCategories,
	    @RequestParam(name = "middleCategory", required = false) List<String> middleCategories
	  ) {

	  // 모든 대분류/중분류 목록을 가져와 메뉴를 구성합니다.
	  List<DbProductVO> mainCategoryVOS = dbShopService.getAllMainCategory();
	  List<DbProductVO> middleCategoryVOS = dbShopService.getAllMiddleCategory(); // 모든 중분류를 가져오는 서비스 메소드
	  model.addAttribute("mainCategoryVOS", mainCategoryVOS);
	  model.addAttribute("middleCategoryVOS", middleCategoryVOS);

	  // 선택된 카테고리 목록을 다시 뷰로 보내 체크박스 상태를 유지합니다.
	  model.addAttribute("selectedMainCodes", mainCategories);
	  model.addAttribute("selectedMiddleCodes", middleCategories);
	  

	  // 선택된 카테고리 목록에 해당하는 상품 목록을 가져옵니다.
	  List<DbProductVO> productVOS = null;
	  
	  boolean mainIsEmpty = (mainCategories == null || mainCategories.isEmpty());
	  boolean middleIsNotEmpty = (middleCategories != null && !middleCategories.isEmpty());
	  
	  if (mainIsEmpty && middleIsNotEmpty) {
			
			List<String> middleCategoryNames = dbShopService.getMiddleCategoryNamesByCodes(middleCategories);
			
			if (middleCategoryNames != null && !middleCategoryNames.isEmpty()) {
				productVOS = dbShopService.getProductsByProductNames(middleCategoryNames);
				
				model.addAttribute("selectedMiddleName", String.join(", ", middleCategoryNames) + " (제품명 검색)");
			} 
			else productVOS = Collections.emptyList();
		}
	  else productVOS = dbShopService.getDbShopList(mainCategories, middleCategories);
	  
	  model.addAttribute("productVOS", productVOS);
	  
	  System.out.println("productVOS" + productVOS);
	  
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
	
	// 중분류 선택 시 해당 상품명(모델명) 가져오기
	@ResponseBody
	@PostMapping("/categoryProductName")
	public List<DbProductVO> categoryProductNameGet(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategoryProductNameAjax(categoryMainCode, categoryMiddleCode);
	}
	
	// 옵션보기에서 상품선택 콤보상자에서 상품을 선택 시 해당 상품의 정보를 보여준다.
	@ResponseBody
	@PostMapping("/getProductInfor")
	public DbProductVO getProductInforGet(String productName) {
		return dbShopService.getProductInfor(productName);
	}
	
	// 옵션보기에서 옵션보기 버튼 클릭 시 해당 상품의 옵션리스트를 보여준다.
	@ResponseBody
	@PostMapping("/getOptionList")
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}
	
	// 옵션에 기록한 내용들을 등록처리
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
	
	// 전체 상품 리스트 출력
	@GetMapping("/dbProductList")
	public String dbProductListGet(Model model,
			@RequestParam(name = "mainCategory", required = false) String mainCategoryCode,
			@RequestParam(name = "keyword", required = false) String keyword
			
		) {
		List<DbProductVO> vos;
		
		if(keyword != null && !keyword.trim().isEmpty()) {
			vos = dbShopService.getProductSearch(keyword);
			model.addAttribute("keyword", keyword);
		}
		else if(mainCategoryCode != null && !mainCategoryCode.trim().isEmpty()) {
			vos = dbShopService.getProductByMainCategory(mainCategoryCode);
		}
		else vos = dbShopService.getDbProductList();
		
		model.addAttribute("vos", vos);
		
		return "dbShop/dbProductList";
	}

	// 상품 상세 정보 출력
	@GetMapping("/dbProductContent")
	public String dbProductContentGet(int idx, Model model) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx);
		List<DbProductVO> optionVOS = dbShopService.getDbShopOption(idx);
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "dbShop/dbProductContent";
	}
	
	// 장바구니 보기
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
	
	/* 장바구니에 상품 추가 (AJAX) */
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
	
	/* 장바구니 항목 삭제 (AJAX) */
	@ResponseBody
	@PostMapping("/cartDelete")
	public String deleteCartPost(int cartIdx) {
		cartService.deleteCartItem(cartIdx);
		return "1";
	}
	
	 /* 장바구니 수량 변경 (AJAX) */
	@ResponseBody
	@PostMapping("/cartUpdateQuantity")
	public String updateQuantityPost(int cartIdx, int quantity) {
		cartService.updateItemQuantity(cartIdx, quantity);
		return "1";
	}
	
	@PostMapping("/orderForm")
  public String dbShopOrderFormPost(
	    @RequestParam("cartIdxs") List<Long> cartIdxs, 
	    HttpSession session,
	    Model model
    ) {
      
	  // 2. 로그인 회원 정보 조회
	  String sUserId = (String) session.getAttribute("sUserId");
	  if (sUserId == null) {
	      return "redirect:/member/memberLogin";
	  }
	  MemberVO memberVO = memberService.getMemberByUserId(sUserId);
	  
	  List<CartVO> orderItems = cartService.getCartListByIdxs(cartIdxs);
	  
	  // 4. 주문 총액 계산
	  int totalOrderPrice = 0;
	  for (CartVO item : orderItems) {
	      // CartVO의 totalPrice 필드 (단가*수량)를 합산
	      totalOrderPrice += item.getTotalPrice();
	  }
	  
	  // 5. Model에 데이터 담기 (orderForm.jsp에서 사용할 이름)
	  model.addAttribute("memberVO", memberVO);         // 회원 정보
	  model.addAttribute("orderItems", orderItems);     // 주문할 상품 목록
	  model.addAttribute("totalOrderPrice", totalOrderPrice); // 상품 총액 (배송비 제외)
	  
	  // 6. 주문서 작성 페이지로 이동
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
		
		System.out.println("memberVO : " + memberVO);
		System.out.println("orderItems : " + orderItems);
		System.out.println("totalOrderPrice : " + totalOrderPrice);
		
		return "dbShop/orderForm";
	}
	
	@PostMapping("/createOrder")
	public String createOrderPost(
		OrderVO orderVO, // OrdersVO -> OrderVO
		@RequestParam("cartIdxs") List<Long> cartIdxs,
		HttpSession session,
		RedirectAttributes redirectAttributes
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
		
		String strNow = "";
		if(startJumun.equals("")) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			strNow = sdf.format(now);
			
			startJumun = strNow;
			endJumun = strNow;
		}
		
		String sUserId = (String) session.getAttribute("sUserId");
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
