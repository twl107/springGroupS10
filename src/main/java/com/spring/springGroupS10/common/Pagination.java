package com.spring.springGroupS10.common;

import org.springframework.stereotype.Service;

import com.spring.springGroupS10.vo.PageVO;

@Service
public class Pagination {
	
	/*
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PdsService pdsService;
	*/
	
	public PageVO pagination(PageVO pageVO) {	// 각각의 변수로 받으면 초기값처리를 spring가 자동할수 있으나, 객체로 받으면 개별 문자/객체 자료에는 null이 들어오기에 따로 초기화 작업처리해야함.
		//System.out.println("pageVO(Pagination) : " + pageVO);
		int pag = pageVO.getPag() == 0 ? 1 : pageVO.getPag();
		int pageSize = pageVO.getPageSize() == 0 ? 10 : pageVO.getPageSize();
		int level = pageVO.getLevel() == 0 ? 99 : pageVO.getLevel();
		String part = pageVO.getPart() == null ? "" : pageVO.getPart();
		
		
		/*
		int totRecCnt = 0;
		if(pageVO.getSection().equals("board")) {
			if(pageVO.getSearch() == null) totRecCnt = boardService.getTotRecCnt("","");
			else totRecCnt = boardService.getTotRecCnt(pageVO.getSearch(), pageVO.getSearchString());
		}
		else if(pageVO.getSection().equals("member")) {
			if(level == 99)	totRecCnt = memberService.getTotRecCnt();
			else totRecCnt = memberService.getMemberLevelCount(level).size();
		}
		else if(pageVO.getSection().equals("complaint")) {
			totRecCnt = adminService.getComplaintTotRecCnt(part);
		}
		else if(pageVO.getSection().equals("pds")) {
			//if(part.equals("")) part = "전체";
			totRecCnt = pdsService.getTotRecCnt(part);
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
		*/
		
		
		if(pageVO.getSearch() != null) {
			if(pageVO.getSearch().equals("title")) pageVO.setSearchStr("글제목");
			else if(pageVO.getSearch().equals("nickName")) pageVO.setSearchStr("닉네임");
			else if(pageVO.getSearch().equals("content")) pageVO.setSearchStr("글내용");
		}
		pageVO.setSearch(pageVO.getSearch());
		pageVO.setSearchString(pageVO.getSearchString());
		
		pageVO.setPart(part);
		pageVO.setBoardFlag(pageVO.getBoardFlag());
		
		pageVO.setLevel(level);
		
		return pageVO;
	}
}
