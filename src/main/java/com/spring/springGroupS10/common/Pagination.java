package com.spring.springGroupS10.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.DbShopService;
import com.spring.springGroupS10.service.InquiryService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.service.NoticeService;
import com.spring.springGroupS10.service.OrderService;
import com.spring.springGroupS10.service.PdsService;
import com.spring.springGroupS10.vo.PageVO;

@Service
public class Pagination {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	DbShopService dbShopService;
	
	
  public PageVO pagination(PageVO pageVO) {
    int pag = pageVO.getPag() == 0 ? 1 : pageVO.getPag();
    int pageSize = pageVO.getPageSize() == 0 ? 15 : pageVO.getPageSize();
    String part = pageVO.getPart() == null ? "" : pageVO.getPart();
    
    int totRecCnt = 0;
    if(pageVO.getSection().equals("member")) {
      totRecCnt = memberService.getTotRecCnt(pageVO.getLevel());
    }
    else if(pageVO.getSection().equals("pds")) {
    	totRecCnt = pdsService.getTotRecCnt(part);
    }
    else if(pageVO.getSection().equals("notice")) {
    	totRecCnt = noticeService.getTotRecCnt();
    }
    else if(pageVO.getSection().equals("inquiry")) {
    	String userId = pageVO.getSearchString();
    	totRecCnt = inquiryService.getTotRecCnt(part, userId);
    }
    else if(pageVO.getSection().equals("adInquiry")) {
    	totRecCnt = inquiryService.getTotRecCntAdmin(part);
    }
    else if(pageVO.getSection().equals("adminOrder")) {
    	String[] searchData = pageVO.getSearchString().split("@");
    	
    	String startJumun = searchData[0];
    	String endJumun = searchData[1];
    	String orderStatus = searchData[2];
    	
    	totRecCnt = orderService.getTotRecCntAdminOrder(startJumun, endJumun, orderStatus);
    }
    else if(pageVO.getSection().equals("myOrders")) {
      String[] searchData = pageVO.getSearchString().split("@");
      
      int memberIdx = Integer.parseInt(searchData[0]);
      String startJumun = searchData[1];
      String endJumun = searchData[2];
      String orderStatus = searchData[3];

      totRecCnt = orderService.getMyOrdersTotRecCnt(memberIdx, startJumun, endJumun, orderStatus);
    }
    else if(pageVO.getSection().equals("adminProductList")) {
      totRecCnt = dbShopService.getTotalProductCount();
    }
    else if(pageVO.getSection().equals("dbProductList")) {
      String keyword = pageVO.getSearchString() == null ? "" : pageVO.getSearchString();
      String mainCategoryCode = pageVO.getPart() == null ? "" : pageVO.getPart();
      
      if(!keyword.equals("")) {
          totRecCnt = dbShopService.getProductSearchTotRecCnt(keyword);
      }
      else if(!mainCategoryCode.equals("")) {
          totRecCnt = dbShopService.getProductByMainCategoryTotRecCnt(mainCategoryCode);
      }
      else {
          totRecCnt = dbShopService.getTotalProductCount();
      }
    }
    else if(pageVO.getSection().equals("adminDbShopList")) {
    	String mainCatStr = pageVO.getPart();
    	String middleCatStr = pageVO.getSearchString();
			
    	List<String> mainCategories = null;
    	List<String> middleCategories = null;
			
    	if(mainCatStr != null && !mainCatStr.isEmpty()) {
    		mainCategories = new ArrayList<>(Arrays.asList(mainCatStr.split(",")));
    	} else {
				mainCategories = Collections.emptyList();
			}
			
    	if(middleCatStr != null && !middleCatStr.isEmpty()) {
    		middleCategories = new ArrayList<>(Arrays.asList(middleCatStr.split(",")));
    	} else {
				middleCategories = Collections.emptyList();
			}
			
    	totRecCnt = dbShopService.getDbShopListTotRecCnt(mainCategories, middleCategories);
    }
    
    int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
    int startIndexNo = (pag - 1) * pageSize;
    int curScrStartNo = totRecCnt - startIndexNo;
    
    int blockSize = 3;
    int curBlock = (pag - 1) / blockSize;
    int lastBlock = (totPage - 1) / blockSize;
    
    pageVO.setPag(pag);
    pageVO.setPageSize(pageSize);
    pageVO.setTotRecCnt(totRecCnt);
    pageVO.setTotPage(totPage);
    pageVO.setStartIndexNo(startIndexNo);
    pageVO.setCurScrStartNo(curScrStartNo);
    pageVO.setBlockSize(blockSize);
    pageVO.setCurBlock(curBlock);
    pageVO.setLastBlock(lastBlock);
    
    return pageVO;
  }
}
