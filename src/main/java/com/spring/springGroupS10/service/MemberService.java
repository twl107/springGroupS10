package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberByUserId(String userId);

	int setMemberJoin(MemberVO vo);

	MemberVO getMemberByNickName(String nickName);
	
	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);
	
	void setMemberLevelUp(String userId);

	void setMemberTodayCntClear(String userId);

	void setMemberInforUpdate(String userId, int point);

	int updateMemberLevel(int idx, int level);

	int getTotRecCnt(int level);

	void deleteExpiredMembers();

	void updatePasswordByUserId(String userId, String encodedPassword);

	List<String> findUserIdByEmail(String email);


}

