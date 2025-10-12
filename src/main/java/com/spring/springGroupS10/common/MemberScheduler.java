package com.spring.springGroupS10.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.springGroupS10.service.MemberService;

@Component
public class MemberScheduler {

	@Autowired
	MemberService memberService;
	
  /**
   * 매일 새벽 1시에 탈퇴 신청 후 30일이 경과한 회원을 DB에서 완전히 삭제합니다.
   * cron = "초 분 시 일 월 요일"
   */
  @Scheduled(cron = "0 0 1 * * *")
  public void autoDeleteExpiredMembers() {
    System.out.println("스케줄러 실행: 30일 경과 탈퇴 회원 삭제 시작");
    memberService.deleteExpiredMembers();
    System.out.println("스케줄러 실행: 30일 경과 탈퇴 회원 삭제 완료");
  }
}
