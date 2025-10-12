package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.dao.MemberDAO;
import com.spring.springGroupS10.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemberByUserid(String userid) {
		return memberDAO.getMemberByUserid(userid);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public MemberVO getMemberByNickname(String nickname) {
		return memberDAO.getMemberByNickname(nickname);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return memberDAO.getMemberList(startIndexNo, pageSize, level);
	}
	
	@Override
	public void setMemberLevelUp(String userid) {
		memberDAO.setMemberLevelUp(userid);
	}

	@Override
	public void setMemberTodayCntClear(String userid) {
		memberDAO.setMemberTodayCntClear(userid);
	}

	@Override
	public void setMemberInforUpdate(String userid, int point) {
		memberDAO.setMemberInforUpdate(userid, point);
	}


	@Override
	public int updateMemberLevel(int idx, int level) {
		return memberDAO.updateMemberLevel(idx, level);
	}

	@Override
	public int getTotRecCnt(int level) {
		return memberDAO.getTotRecCnt(level);
	}

	@Override
	public void deleteExpiredMembers() {
		memberDAO.deleteExpiredMembers();
	}
	
	
	
	
	

}
