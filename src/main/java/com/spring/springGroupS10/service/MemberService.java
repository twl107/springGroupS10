package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberByUserid(String userid);

	int setMemberJoin(MemberVO vo);

	MemberVO getMemberByNickname(String nickname);
	
	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);
	
	void setMemberLevelUp(String userid);

	void setMemberTodayCntClear(String userid);

	void setMemberInforUpdate(String userid, int point);

	int updateMemberLevel(int idx, int level);

	int getTotRecCnt(int level);

	void deleteExpiredMembers();

}
