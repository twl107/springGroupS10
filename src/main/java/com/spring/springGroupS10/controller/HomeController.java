package com.spring.springGroupS10.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@RequestMapping(value = {"/","/h","/index","/main"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	// data폴더아래 다운받고자 할때 수행하는 메소드(다운받을 경로와 파일명을 넘져줘서 처리한다.)
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
	
	
	
}




