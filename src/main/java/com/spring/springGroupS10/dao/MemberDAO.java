package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberByUserid(@Param("userid") String userid);

	int setMemberJoin(@Param("vo") MemberVO vo);

	MemberVO getMemberByNickname(@Param("nickname") String nickname);

	List<MemberVO> getMemberList();

}
