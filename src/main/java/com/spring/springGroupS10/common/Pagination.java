package com.spring.springGroupS10.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.service.AdminService;
import com.spring.springGroupS10.service.MemberService;
import com.spring.springGroupS10.vo.PageVO;

@Service
public class Pagination {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
  public PageVO pagination(PageVO pageVO) {
    int pag = pageVO.getPag() == 0 ? 1 : pageVO.getPag();
    int pageSize = pageVO.getPageSize() == 0 ? 5 : pageVO.getPageSize();
    int totRecCnt = 0;
    if(pageVO.getSection().equals("member")) {
      totRecCnt = memberService.getTotRecCnt(pageVO.getLevel());
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
