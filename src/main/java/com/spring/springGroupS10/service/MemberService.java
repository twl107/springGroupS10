package com.spring.springGroupS10.service;

import com.spring.springGroupS10.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberByUserid(String userid);

	int setMemberJoin(MemberVO vo);

	MemberVO getMemberByNickname(String nickname);

}
