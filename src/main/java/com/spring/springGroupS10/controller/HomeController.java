package com.spring.springGroupS10.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.service.BannerService;
import com.spring.springGroupS10.service.DbShopService;
import com.spring.springGroupS10.vo.BannerVO;
import com.spring.springGroupS10.vo.DbProductVO;

@Controller
public class HomeController {
	
	@Autowired
	BannerService bannerService;
	
	@Autowired
	DbShopService dbShopService;
	
	@RequestMapping(value = {"/","/h","/index","/main"}, method = RequestMethod.GET)
	public String home(Model model) {
		
		List<BannerVO> bannerList = bannerService.getActiveBannersOrdered();
		model.addAttribute("bannerList", bannerList);
		
		List<DbProductVO> bestSellerList = dbShopService.getBestSellerProducts(4);
    model.addAttribute("bestSellerList", bestSellerList);

    List<DbProductVO> recommendedProductList = dbShopService.getRecommendedProducts(4);
    model.addAttribute("recommendedProductList", recommendedProductList);
		
		return "home";
	}
	
	@RequestMapping(value = "/fileDownAction", method = RequestMethod.GET)
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
		String file = request.getParameter("file");
		
		if(path.equals("pds")) path += "/temp/";
		
		String realPathFile = request.getSession().getServletContext().getRealPath("/resources/data/" + path) + file;
		
		File downFile = new File(realPathFile);
		String downFileName = new String(file.getBytes("UTF-8"), "8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] bytes = new byte[2048];
		int data;
		while((data = fis.read(bytes, 0, bytes.length)) != -1) {
			sos.write(bytes, 0, data);
		}
		sos.flush();
		sos.close();
		fis.close();
		
		downFile.delete();
	}
	
	@PostMapping("/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		String regExt = "(jpg|jpeg|gif|png|mp4)";
		String ext = oFileName.substring(oFileName.lastIndexOf(".")+1);
		if(!ext.matches(regExt)) {
			System.out.println("잘못된 파일 업로드중...");
			return;
		}
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		byte[] bytes = upload.getBytes();
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath()+"/data/ckeditor/"+oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		fos.close();
	}
	
	
}




