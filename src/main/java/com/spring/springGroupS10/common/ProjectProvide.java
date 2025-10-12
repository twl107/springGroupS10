package com.spring.springGroupS10.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

//@Component
@Service
public class ProjectProvide {
	
	@Autowired
	JavaMailSender mailSender;
	

	// 메일 보내기
	public String mailSend(
			String toMail,
			String title,
			String mailFlag
		) throws MessagingException {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		String content = "";
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지보관함에 저장되는 'content'변수안에 발신자의 필요한 정보를 추가로 담아준다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>SpringGroup에서 보냅니다.</h3><hr>";
		content += "<font size='5' color='red'><b>"+mailFlag+"</b></font><hr>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>springGroup</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		mailSender.send(message);
		
		return "1";
	}

	// 파일 업로드후 서버에 구분처리해서 저장하기
	public String fileUpload(MultipartFile fName, String mid, String part) {
		// 파일명 중복처리
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + UUID.randomUUID().toString().substring(0, 4) + "_" + oFileName;
		
		try {
			// 서버에 파일 구분처리하여 저장하기
			writeFile(fName, sFileName, part);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	// 지정된경로에 파일 저정하기
	public void writeFile(MultipartFile fName, String sFileName, String part) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+part+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	// 지정된 경로의 파일 삭제하기
	public void fileDelete(String fileName, String part) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+part+"/");
		File file = new File(realPath + fileName);
		if(file.exists()) file.delete();
	}

	// 파일 이름 변경하기(서버 파일시스템에 저장되는 파일명의 중복을 방지하기위함)
	public String saveFileName(String oFileName) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		return sdf.format(date) + "_" + oFileName;
	}

	public void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
}
