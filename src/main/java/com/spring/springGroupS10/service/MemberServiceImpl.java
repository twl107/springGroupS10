package com.spring.springGroupS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.springGroupS10.dao.MemberDAO;
import com.spring.springGroupS10.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public MemberVO getMemberByUserId(String userId) {
		return memberDAO.getMemberByUserId(userId);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public MemberVO getMemberByNickName(String nickName) {
		return memberDAO.getMemberByNickName(nickName);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return memberDAO.getMemberList(startIndexNo, pageSize, level);
	}
	
	@Override
	public void setMemberLevelUp(String userId) {
		memberDAO.setMemberLevelUp(userId);
	}

	@Override
	public void setMemberTodayCntClear(String userId) {
		memberDAO.setMemberTodayCntClear(userId);
	}

	@Override
	public void setMemberInforUpdate(String userId, int point) {
		memberDAO.setMemberInforUpdate(userId, point);
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

	@Override
	public void updatePasswordByUserId(String userId, String encodedPassword) {
		memberDAO.updatePasswordByUserId(userId, encodedPassword);
	}

	@Override
	public List<String> findUserIdByEmail(String email) {
		return memberDAO.findUserIdByEmail(email);
	}

	@Override
	public boolean userDelete(String userId, String password) {
		
		MemberVO member = memberDAO.getMemberByUserId(userId);
		
		if(member != null && passwordEncoder.matches(password, member.getPassword())) {
			int result = memberDAO.updateMemberDelete(userId);
			
			return result > 0;
		}
		else return false;
	}

	@Override
	public boolean recoverAccount(String userId) {
		return memberDAO.recoverAccount(userId);
	}

	@Override
	public void updateLastLogin(String userId) {
		memberDAO.updateLastLogin(userId);
	}

	@Override
	public int setUpdateMember(MemberVO vo) {
		return memberDAO.setUpdateMember(vo);
	}

	@Override
	public boolean checkCurrentPassword(String userId, String currentPassword) {
		MemberVO member = memberDAO.getMemberByUserId(userId);
		if (member != null && passwordEncoder.matches(currentPassword, member.getPassword())) {
			return true;
		}
		return false;
	}

	@Override
	public int getNewMemberCountToday() {
		return memberDAO.getNewMemberCountToday();
	}

	@Override
	public MemberVO getMemberByKakaoId(long kakaoId) {
		return memberDAO.getMemberByKakaoId(kakaoId);
	}

	@Override
	public MemberVO getMemberByEmail(String email) {
		return memberDAO.getMemberByEmail(email);
	}

}

