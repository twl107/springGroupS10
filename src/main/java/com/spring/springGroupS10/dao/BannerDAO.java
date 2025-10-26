package com.spring.springGroupS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS10.vo.BannerVO;

public interface BannerDAO {

	List<BannerVO> getActiveBannersOrdered();

	List<BannerVO> getAllBannersOrdered();

	int addBanner(@Param("vo") BannerVO vo);

	BannerVO getBannerByIdx(@Param("idx") int idx);

	int deleteBanner(@Param("idx") int idx);

}
