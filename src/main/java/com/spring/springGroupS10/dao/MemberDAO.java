package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberByUserid(@Param("userid") String userid);

	int setMemberJoin(@Param("vo") MemberVO vo);

	MemberVO getMemberByNickname(@Param("nickname") String nickname);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	void setMemberLevelUp(@Param("userid") String userid);

	void setMemberTodayCntClear(@Param("userid") String userid);

	void setMemberInforUpdate(@Param("userid") String userid, @Param("point") int point);

	int updateMemberLevel(@Param("idx") int idx, @Param("level") int level);

	int getTotRecCnt(@Param("level") int level);

	void deleteExpiredMembers();


}
