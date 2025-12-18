package com.spring.springGroupS10.service;

import java.util.List;

import com.spring.springGroupS10.vo.BannerVO;

public interface BannerService {

	List<BannerVO> getActiveBannersOrdered();
	
	List<BannerVO> getAllBannersOrdered();

	int addBanner(BannerVO vo);

	boolean deleteBanner(int idx);

}
