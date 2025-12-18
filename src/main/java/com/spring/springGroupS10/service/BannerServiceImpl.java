package com.spring.springGroupS10.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springGroupS10.dao.BannerDAO;
import com.spring.springGroupS10.vo.BannerVO;

@Service
public class BannerServiceImpl implements BannerService {
	
	@Autowired
	BannerDAO bannerDAO;

	@Override
	public List<BannerVO> getActiveBannersOrdered() {
		return bannerDAO.getActiveBannersOrdered();
	}

	@Override
	public List<BannerVO> getAllBannersOrdered() {
		return bannerDAO.getAllBannersOrdered();
	}

	@Override
	public int addBanner(BannerVO vo) {
		return bannerDAO.addBanner(vo);
	}

	@Override
	public boolean deleteBanner(int idx) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		BannerVO vo = bannerDAO.getBannerByIdx(idx);
		
		if(vo == null || vo.getFSName() == null || vo.getFSName().isEmpty()) {
      int res = bannerDAO.deleteBanner(idx);
      return res > 0;
		}
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/banner/");
		File file = new File(realPath + vo.getFSName());
		boolean fileDeleted = false;
		
		if(file.exists()) {
			fileDeleted = file.delete();
			if(!fileDeleted) return false;
		}
		else fileDeleted = true;
		
		if(fileDeleted) {
			int dbResult = bannerDAO.deleteBanner(idx);
			return dbResult > 0;
		}
		return false;
	}
	
}
