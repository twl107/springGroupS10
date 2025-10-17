package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.PdsVO;

public interface PdsDAO {

	int getTotRecCnt(@Param("part") String part);

	List<PdsVO> getPdsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	int pdsUpload(@Param("vo") PdsVO vo);

	PdsVO getPdsContent(@Param("idx") int idx);

	void setPdsDownNumCheck(@Param("idx") int idx);

	int getPdsDelelte(@Param("idx") int idx);

	PdsVO getPdsIdx(@Param("idx") int idx);

	
	
	
	
	

}
