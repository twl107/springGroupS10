package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberByUserId(@Param("userId") String userId);

	int setMemberJoin(@Param("vo") MemberVO vo);

	MemberVO getMemberByNickName(@Param("nickName") String nickName);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	void setMemberLevelUp(@Param("userId") String userId);

	void setMemberTodayCntClear(@Param("userId") String userId);

	void setMemberInforUpdate(@Param("userId") String userId, @Param("point") int point);

	int updateMemberLevel(@Param("idx") int idx, @Param("level") int level);

	int getTotRecCnt(@Param("level") int level);

	void deleteExpiredMembers();

	void updatePasswordByUserId(@Param("userId") String userId, @Param("encodedPassword") String encodedPassword);

	List<String> findUserIdByEmail(@Param("email") String email);

	int updateMemberDelete(@Param("userId") String userId);


	
	
	
	
	
	
	
	
}

